import 'package:freezed_annotation/freezed_annotation.dart';

part 'chari.freezed.dart';
part 'chari.g.dart';

@freezed
class Chari with _$Chari {
  const factory Chari({
    required String brand,
    required String frame,
    String? caption,
    required String createdAt,
    String? updatedAt,
  }) = _Chari;
  factory Chari.fromJson(Map<String, dynamic> json) =>
      _$ChariFromJson(json);
}
