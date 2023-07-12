// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUser _$$_FirestoreUserFromJson(Map<String, dynamic> json) =>
    _$_FirestoreUser(
      uid: json['uid'] as String,
      userName: json['userName'] as String,
      displayName: json['displayName'] as String,
      userImageURL: json['userImageURL'] as String,
      introduction: json['introduction'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'displayName': instance.displayName,
      'userImageURL': instance.userImageURL,
      'introduction': instance.introduction,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
    };
