const admin = require("firebase-admin");
const functions = require("firebase-functions");

const config = functions.config();
admin.initializeApp(config.firebase);
const plusOne = 1;
const minusOne = -1;
const fireStore = admin.firestore();
const batchLimit = 500;

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
    async (snap, _) => {
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
    },
);

exports.onDeleteUserCreate =
functions.firestore.document("deleteUsers/{uid}").onCreate(
    async (snap, _) => {
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
    },
);
