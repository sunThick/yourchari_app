import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'mute_user_token.freezed.dart';
part 'mute_user_token.g.dart';
 
@freezed
abstract class MuteUserToken with _$MuteUserToken {
  // 自分が投稿にいいねしたことの印
 const factory MuteUserToken({
   required String activeUid,
   required dynamic createdAt,
   required String passiveUid,
   required String tokenId,
   required String tokenType,
  }) = _MuteUserToken;
 factory MuteUserToken.fromJson(Map<String, dynamic> json) => _$MuteUserTokenFromJson(json);
}