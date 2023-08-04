// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostReport _$$_PostReportFromJson(Map<String, dynamic> json) =>
    _$_PostReport(
      acitiveUid: json['acitiveUid'] as String,
      createdAt: json['createdAt'],
      reportContent: json['reportContent'] as String,
      postCreatorUid: json['postCreatorUid'] as String,
      passiveUserName: json['passiveUserName'] as String,
      postDocRef: json['postDocRef'],
      postId: json['postId'] as String,
      postReportId: json['postReportId'] as String,
    );

Map<String, dynamic> _$$_PostReportToJson(_$_PostReport instance) =>
    <String, dynamic>{
      'acitiveUid': instance.acitiveUid,
      'createdAt': instance.createdAt,
      'reportContent': instance.reportContent,
      'postCreatorUid': instance.postCreatorUid,
      'passiveUserName': instance.passiveUserName,
      'postDocRef': instance.postDocRef,
      'postId': instance.postId,
      'postReportId': instance.postReportId,
    };
