// packages

import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeAgo;

// titles
const String appTitle = "SNS";
const String signupTitle = "新規登録";
const String loginTitle = "ログイン";
const String accountTitle = "アカウント";
const String themeTitle = "テーマ";
const String profileTitle = "プロフィール";
const String adminTitle = "管理者";
const String createPostTitle = "投稿を作成";
const String commentTitle = "コメント";
const String replyTitle = "リプライ";
const String editProfilePageTitle = "プロフィール編集ページ";
const String muteUsersPageTitle = "ミュートしているユーザー";
const String muteCommentsPageTitle = "ミュートしているコメント";
const String mutePostsPageTitle = "ミュートしている投稿";
const String muteRepliesPageTitle = "ミュートしているリプライ";
const String reauthenticationPageTitle = "再認証";
const String updatePasswordPageTitle = "新しいパスワード";
const String updateEmailPageTitle = "新しいメールアドレス";
const String searchScreenTitle = "Search";
// texts
const String mailAddressText = "メールアドレス";
const String passwordText = "パスワード";
const String signupText = "新規登録を行う";
const String cropperTitle = "Cropper";
const String loginText = "ログインする";
const String logoutText = "ログアウトを行う";
const String loadingText = "Loading";
const String uploadText = "アップロードする";
const String reloadText = "再読み込みを行う";
const String createCommentText = "コメントを作成";
const String createReplyText = "リプライを作成";
const String editProfileText = "プロフィールを編集する";
const String updateText = "更新する";
const String showMuteUsersText = "ミュートしているユーザーを表示する";
const String showMuteCommentsText = "ミュートしているコメントを表示する";
const String showMutePostsText = "ミュートしている投稿を表示する";
const String showMuteRepliesText = "ミュートしているリプライを表示する";
const String yesText = "Yes";
const String noText = "No";
const String backText = "戻る";
const String muteUserText = "ユーザーをミュート";
const String muteCommentText = "コメントをミュート";
const String mutePostText = "投稿をミュート";
const String reportPostText = "投稿を報告";
const String reportCommentText = "コメントを報告";
const String reportReplyText = "リプライを報告";
const String muteReplyText = "リプライをミュート";
const String unMuteUserText = "ユーザーのミュートを解除";
const String unMuteCommentText = "コメントのミュートを解除";
const String unMutePostText = "投稿のミュートを解除";
const String unMuteReplyText = "リプライのミュートを解除";
const String reauthenticateText = "再認証をする";
const String updatePasswordText = "パスワードをアップデートする";
const String updateEmailText = "メールアドレスをアップデートする";
const String usersText = "Users";
const String postsText = "Posts";
// alert message
const String muteUserAlertMsg = 'ユーザーをミュートしますが本当によろしいですか？';
const String muteCommentAlertMsg = "コメントをミュートしますが本当によろしいですか？";
const String mutePostAlertMsg = "投稿をミュートしますが本当によろしいですか？";
const String muteReplyAlertMsg = "リプライをミュートしますが本当によろしいですか？";
const String unMuteUserAlertMsg = 'ユーザーのミュートを解除しますが本当によろしいですか？';
const String unMuteCommentAlertMsg = "コメントのミュートを解除しますが本当によろしいですか？";
const String unMutePostAlertMsg = "投稿のミュートを解除しますが本当によろしいですか？";
const String unMuteReplyAlertMsg = "リプライのミュートを解除しますが本当によろしいですか?";
const String updatedPasswordMsg = "パスワードのアップデートが完了しました";
const String requiresRecentLoginMsg = "再認証を行ってください";
const String maxSearchLengthMsg = "検索できるのは100文字までです";
// FieldKey
const String usersFieldKey = "users";
// message
const String userCreatedMsg = "ユーザーが作成できました";
const String noAccountMsg = "アカウントをお持ちでない場合";
const String emailAlreadyInUseMsg = "そのemailはもう使われています";
const String firebaseAuthEmailOperationNotAllowed =
    "Firebaseでemail/passwordが許可されていません";
const String weakPasswordMsg = "パスワードが弱すぎます";
const String invalidEmailMsg = "そのメールアドレスはふさわしくありません";
const String wrongPasswordMsg = "パスワードが違います";
const String userNotFoundMsg = "そのメールアドレスに対応するユーザーが見つかりません";
const String userDisabledMsg = "そのユーザーは無効化されています";
const String reauthenticatedMsg = "再認証が完了しました";
const String userMismatchMsg = "与えられたクレデンシャルがユーザーに対応していません";
const String invalidCredentialMsg = "プロバイダのクレデンシャルが有効ではありません";
const String emailSendedMsg = "メールが送信されました";
const String missingAndroidPkgNameMsg = "Android Pkg Nameがありません";
const String missingIosBundleIdMsg = "Ios Bundle Idがありません";
const String createdPostMsg = "投稿が完了しました！表示するには時間がかかります";
// prefs key
const String isDarkThemePrefsKey = "isDarkTheme";
// bottom navigation bar
const String homeText = "Home";
const String searchText = "Search";
const String articleText = "Article";
const String profileText = "Profile";
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnFileName() => returnUuidV4();

String updateEmailLagMsg({required String email}) =>
    "$email('更新が反映されるまで時間がかかる可能性がございます')";
// name
const String aliceName = "Alice";
String returnReportContentString(
    {required List<String> selectedReportContents}) {
  String reportContentString = "";
  for (final content in selectedReportContents) {
    reportContentString += '$content,'; // メールにした時見やすいように加工
  }
  return reportContentString;
}

String createTimeAgoString(DateTime postDateTime) {
  final now = DateTime.now();
  final difference = now.difference(postDateTime);
  return timeAgo.format(now.subtract(difference), locale: "ja");
}
