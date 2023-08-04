
 
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_report.freezed.dart';
part 'post_report.g.dart';

@freezed
abstract class PostReport with _$PostReport {
  // メールで送信する
 const factory PostReport({
    required String acitiveUid,
    required dynamic createdAt,
    required String reportContent,// メインの報告内容
    required String postCreatorUid,
    required String passiveUserName,
    required dynamic postDocRef,
    required String postId,
    required String postReportId,
  }) = _PostReport;
 factory PostReport.fromJson(Map<String, dynamic> json) => _$PostReportFromJson(json);
}