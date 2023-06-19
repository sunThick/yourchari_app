// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_user_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MuteUserToken _$$_MuteUserTokenFromJson(Map<String, dynamic> json) =>
    _$_MuteUserToken(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_MuteUserTokenToJson(_$_MuteUserToken instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
