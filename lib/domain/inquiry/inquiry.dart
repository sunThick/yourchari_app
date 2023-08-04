
 
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inquiry.freezed.dart';
part 'inquiry.g.dart';

@freezed
abstract class Inquiry with _$Inquiry {
  // メールで送信する
 const factory Inquiry({
    required dynamic createdAt,
    required String userName,
    required String uid,
    required String content,
    required String inquiryId
  }) = _Inquiry;
 factory Inquiry.fromJson(Map<String, dynamic> json) => _$InquiryFromJson(json);
}