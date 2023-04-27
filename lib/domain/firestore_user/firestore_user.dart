import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'firestore_user.freezed.dart';
part 'firestore_user.g.dart';
 
@freezed
abstract class FirestoreUser with _$FirestoreUser {
 const factory FirestoreUser({
   required dynamic createdAt,
   required String email,
   required String userName,
  //  required String userImageURL,
   required String uid,
   required dynamic updatedAt,
  }) = _FirestoreUser;
 factory FirestoreUser.fromJson(Map<String, dynamic> json) => _$FirestoreUserFromJson(json);
}