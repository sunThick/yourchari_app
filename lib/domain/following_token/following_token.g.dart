// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FollowingToken _$$_FollowingTokenFromJson(Map<String, dynamic> json) =>
    _$_FollowingToken(
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_FollowingTokenToJson(_$_FollowingToken instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
