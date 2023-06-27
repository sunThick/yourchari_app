import 'package:freezed_annotation/freezed_annotation.dart';

part 'chari.freezed.dart';
part 'chari.g.dart';

@freezed
class Chari with _$Chari {
  const factory Chari({
    required String brand,
    required String category,
    required String frame,
    required List<String> imageURL,
    required int likeCount,
    required String postId,
    required String uid,
    required String caption,
    required dynamic createdAt,
    required dynamic updatedAt,
    List? fork,
    List? headSet,
    List? columnSpacer,
    List? handleBar,
    List? stem,
    List? grip,
    List? saddle,
    List? seatPost,
    List? seatClamp,
    List? tire,
    List? rim,
    List? hub,
    List? cog,
    List? sprocket,
    List? lockRing,
    List? freeWheel,
    List? crank,
    List? chainRing,
    List? chain,
    List? bottomBrancket,
    List? pedals,
    List? brake,
    List? brakeLever,
    List? shifter,
    List? shiftLever,
    List? rack,
    List? bottle,
    List? frontLight,
    List? rearLight,
    List? lock,
    List? bell,
    List? helmet,
    List? bag,
    List? basket,
  }) = _Chari;
  factory Chari.fromJson(Map<String, dynamic> json) => _$ChariFromJson(json);
}
