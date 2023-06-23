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
    Map? fork,
    Map? headSet,
    Map? columnSpacer,
    Map? handleBar,
    Map? stem,
    Map? grip,
    Map? saddle,
    Map? seatPost,
    Map? seatClamp,
    Map? tire,
    Map? rim,
    Map? hub,
    Map? cog,
    Map? sprocket,
    Map? lockRing,
    Map? freeWheel,
    Map? crank,
    Map? charinRing,
    Map? chain,
    Map? bottomBrancket,
    Map? pedals,
    Map? brake,
    Map? brakeLever,
    Map? shifter,
    Map? shiftLever,
    Map? rack,
    Map? bottle,
    Map? frontLight,
    Map? rearLight,
    Map? lock,
    Map? bell,
    Map? helmet,
    Map? bag,
    Map? baske,
  }) = _Chari;
  factory Chari.fromJson(Map<String, dynamic> json) => _$ChariFromJson(json);
}
