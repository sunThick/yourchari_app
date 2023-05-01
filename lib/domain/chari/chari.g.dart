// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chari.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chari _$$_ChariFromJson(Map<String, dynamic> json) => _$_Chari(
      brand: json['brand'] as String,
      category: json['category'] as String,
      frame: json['frame'] as String,
      imageURL:
          (json['imageURL'] as List<dynamic>).map((e) => e as String).toList(),
      likeCount: json['likeCount'] as int,
      postId: json['postId'] as String,
      uid: json['uid'] as String,
      caption: json['caption'] as String,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_ChariToJson(_$_Chari instance) => <String, dynamic>{
      'brand': instance.brand,
      'category': instance.category,
      'frame': instance.frame,
      'imageURL': instance.imageURL,
      'likeCount': instance.likeCount,
      'postId': instance.postId,
      'uid': instance.uid,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
