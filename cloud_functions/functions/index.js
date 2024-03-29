const admin = require("firebase-admin");
const functions = require("firebase-functions");

const config = functions.config();
admin.initializeApp(config.firebase);
const plusOne = 1;
const minusOne = -1;
const fireStore = admin.firestore();
const batchLimit = 500;

// sendgrid
const sgMail = require("@sendgrid/mail");
const SENDGRID_API_KEY = config.sendgrid.api_key;


function sendMail(text, subject) {
  sgMail.setApiKey(SENDGRID_API_KEY); // 関数の度にAPIをセットしなければならない
  const msg = {
    to: "sunthick63@gmail.com",
    from: "sunthick63@gmail.com",
    subject: subject,
    text: text,
  };
  sgMail.send(msg)
      .then((ref) => {
        console.log(ref); // resを出力
      }).catch((e) => {
        console.log(e);// errorを出力
      });
}

function sendReport(data, contentType) {
  const stringData = JSON.stringify(data);
  const result = stringData.replace(/,/g, ",\n");
  sendMail(result, `${contentType}を報告`);
}

function sendInquiry(data) {
  const stringData = JSON.stringify(data);
  const result = stringData.replace(/,/g, ",\n");
  sendMail(result, `お問い合わせ`);
}

exports.onPostReportCreate =
functions.firestore.document("chari/{postId}/postReports/{postReport}")
    .onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.postDocRef.update({
            "reportCount": admin.firestore.FieldValue.increment(plusOne),
          });
          sendReport(newValue, "投稿");
        },
    );

exports.onInquiryCreate =
functions.firestore.document("users/{uid}/inquiries/{inquiryId}")
    .onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          sendInquiry(newValue);
        },
    );

exports.onFollowerCreate =
functions.firestore.document("users/{uid}/followers/{followerUid}").onCreate(
    async (snap, _) => {
      const newValue = snap.data();
      await fireStore.collection("users").doc(newValue.followedUid).update({
        "followerCount": admin.firestore.FieldValue.increment(plusOne),
      });
      await fireStore.collection("users").doc(newValue.followerUid).update({
        "followingCount": admin.firestore.FieldValue.increment(plusOne),
      });
    },
);

exports.onFollowerDelete =
functions.firestore.document("users/{uid}/followers/{followerUid}").onDelete(
    async (snap, _) => {
      const newValue = snap.data();
      await fireStore.collection("users").doc(newValue.followedUid).update({
        "followerCount": admin.firestore.FieldValue.increment(minusOne),
      });
      await fireStore.collection("users").doc(newValue.followerUid).update({
        "followingCount": admin.firestore.FieldValue.increment(minusOne),
      });
    },
);

exports.onChariLikeCreate =
functions.firestore.document("chari/{postId}/chariLikes/{activeUid}").onCreate(
    async (snap, _) => {
      const newValue = snap.data();
      await newValue.chariRef.update({
        "likeCount": admin.firestore.FieldValue.increment(plusOne),
      });
    },
);

exports.onChariLikeDelete =
functions.firestore.document("chari/{postId}/chariLikes/{activeUid}").onDelete(
    async (snap, _) => {
      const newValue = snap.data();
      await newValue.chariRef.update({
        "likeCount": admin.firestore.FieldValue.increment(minusOne),
      });
    },
);

exports.onChariDelete =
functions.firestore.document("chari/{postId}").onDelete(
    async (snap, context) => {
      const postId = snap.id;
      const chariLikes =
      await fireStore.collection("chari")
          .doc(postId).collection("chariLikes").get();
      let chariLikeCount = 0;
      let chariLikeBatch = fireStore.batch();
      for (const chariLike of chariLikes.docs) {
        chariLikeBatch.delete(chariLike.ref);
        chariLikeCount++;
        if (chariLikeCount == batchLimit) {
          await chariLikeBatch.commit();
          chariLikeBatch = fireStore.batch();
          chariLikeCount = 0;
        }
      }
      if (chariLikeCount > 0) {
        await chariLikeBatch.commit();
      }

      const deletedPostId = context.params.postId;
      const bucket = admin.storage().bucket();
      bucket.deleteFiles({
        prefix: "charis/" + deletedPostId + "/",
      });
    },
);

exports.onDeleteUserCreate =
functions.firestore.document("deleteUsers/{uid}").onCreate(
    async (snap, context) => {
      const uid = snap.id;
      const myRef = fireStore.collection("users").doc(uid);
      // 自分をPostを消す
      const posts =
      await fireStore.collection("chari").where("uid", "==", uid).get();
      let postCount = 0;
      let postBatch = fireStore.batch();
      for (const post of posts.docs) {
        postBatch.delete(post.ref);
        postCount++;
        if (postCount == batchLimit) {
          await postBatch.commit();
          postBatch = fireStore.batch();
          postCount = 0;
        }
      }
      if (postCount > 0) {
        await postBatch.commit();
      }
      // 自分のtokenを消す
      const tokens = await myRef.collection("tokens").get();
      let tokenCount = 0;
      let tokenBatch = fireStore.batch();
      for (const token of tokens.docs) {
        tokenBatch.delete(token.ref);
        tokenCount++;
        if (tokenCount == batchLimit) {
          await tokenBatch.commit();
          tokenBatch = fireStore.batch();
          tokenCount = 0;
        }
      }
      if (tokenCount > 0) {
        await tokenBatch.commit();
      }
      await myRef.delete(); // 一番最後。

      //  storageからプロフィール写真を削除
      const deletedUid = context.params.uid;
      const bucket = admin.storage().bucket();
      bucket.deleteFiles({
        prefix: "users/" + deletedUid + "/",
      });
    },
);
