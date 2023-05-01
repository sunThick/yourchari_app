import 'package:freezed_annotation/freezed_annotation.dart';

part 'chari.freezed.dart';
part 'chari.g.dart';

@freezed
class Chari with _$Chari {
  const factory Chari(
      {required String brand,
      required String category,
      required String frame,
      required List<String> imageURL,
      required int likeCount,
      required String postId,
      required String uid,
      required String caption,
      required dynamic createdAt,
      required dynamic updatedAt}) = _Chari;
  factory Chari.fromJson(Map<String, dynamic> json) => _$ChariFromJson(json);
}
