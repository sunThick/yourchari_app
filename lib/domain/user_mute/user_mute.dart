// 投稿がいいねされたことの印
import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'user_mute.freezed.dart';
part 'user_mute.g.dart';
 
@freezed
abstract class UserMute with _$UserMute {
 const factory UserMute({
   required String activeUid,
   required dynamic createdAt,
   required String passiveUid,
   required dynamic passiveUserRef
  }) = _UserMute;
 factory UserMute.fromJson(Map<String, dynamic> json) => _$UserMuteFromJson(json);
}