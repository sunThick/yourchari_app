// packages

import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeAgo;


String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnFileName() => returnUuidV4();

String createTimeAgoString(DateTime postDateTime) {
  final now = DateTime.now();
  final difference = now.difference(postDateTime);
  return timeAgo.format(now.subtract(difference), locale: "ja");
}


String returnReportContentString({ required List<String> selectedReportContents }) {
  String reportContentString = "";
  for (final content in selectedReportContents) {
    reportContentString += '$content,'; // メールにした時見やすいように加工
  }
  return reportContentString;
}