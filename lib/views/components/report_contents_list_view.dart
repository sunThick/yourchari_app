import 'package:flutter/material.dart';

class ReportContentsListView extends StatelessWidget {
  const ReportContentsListView(
      {Key? key, required this.selectedReportContentsNotifier})
      : super(key: key);
  final ValueNotifier<List<String>> selectedReportContentsNotifier;
  @override
  Widget build(BuildContext context) {
    const List<String> reportContents = ["暴力的なコンテンツ", "性的なコンテンツ", "不快なコンテンツ"];

    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        // valueNotifierの変更を検知
        child: ValueListenableBuilder<List<String>>(
            valueListenable: selectedReportContentsNotifier,
            builder: (_, selectedReportContents, __) {
              return ListView.builder(
                itemCount: reportContents.length,
                itemBuilder: (context, index) {
                  final String reportContent = reportContents[index];
                  return ListTile(
                    leading: selectedReportContents.contains(reportContent)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : const SizedBox.shrink(),
                    title: Text(reportContent),
                    onTap: () {
                      if (!selectedReportContentsNotifier.value
                          .contains(reportContent)) {
                        List<String> x = selectedReportContentsNotifier.value;
                        x.add(reportContent);
                        // valueの中身を上書きしている
                        selectedReportContentsNotifier.value =
                            x.map((e) => e).toList();
                      } else {
                        List<String> x = selectedReportContentsNotifier.value;
                        x.remove(reportContent);
                        // valueの中身を上書きしている
                        selectedReportContentsNotifier.value =
                            x.map((e) => e).toList();
                      }
                    },
                  );
                },
              );
            }));
  }
}
