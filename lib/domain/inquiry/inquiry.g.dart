// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Inquiry _$$_InquiryFromJson(Map<String, dynamic> json) => _$_Inquiry(
      createdAt: json['createdAt'],
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      content: json['content'] as String,
      inquiryId: json['inquiryId'] as String,
    );

Map<String, dynamic> _$$_InquiryToJson(_$_Inquiry instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'userName': instance.userName,
      'uid': instance.uid,
      'content': instance.content,
      'inquiryId': instance.inquiryId,
    };
