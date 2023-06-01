import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'like_chari_token.freezed.dart';
part 'like_chari_token.g.dart';
 
@freezed
abstract class LikeChariToken with _$LikeChariToken {
  // 自分が投稿にいいねしたことの印
 const factory LikeChariToken({
   required String activeUid,
   required dynamic createdAt,
   required String passiveUid,
   required dynamic chariRef,
   required String postId,
   required String tokenId,
  }) = _LikeChariToken;
 factory LikeChariToken.fromJson(Map<String, dynamic> json) => _$LikeChariTokenFromJson(json);
}