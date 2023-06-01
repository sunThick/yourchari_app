// 投稿がいいねされたことの印
import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'chari_like.freezed.dart';
part 'chari_like.g.dart';
 
@freezed
abstract class ChariLike with _$ChariLike {
 const factory ChariLike({
   required String activeUid,
   required dynamic createdAt,
   required String passiveUid,
   required dynamic chariRef,
   required String postId,
  }) = _Charilike;
 factory ChariLike.fromJson(Map<String, dynamic> json) => _$ChariLikeFromJson(json);
}