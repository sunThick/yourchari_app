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
      fork: json['fork'] as List<dynamic>?,
      headSet: json['headSet'] as List<dynamic>?,
      columnSpacer: json['columnSpacer'] as List<dynamic>?,
      handleBar: json['handleBar'] as List<dynamic>?,
      stem: json['stem'] as List<dynamic>?,
      grip: json['grip'] as List<dynamic>?,
      saddle: json['saddle'] as List<dynamic>?,
      seatPost: json['seatPost'] as List<dynamic>?,
      seatClamp: json['seatClamp'] as List<dynamic>?,
      tire: json['tire'] as List<dynamic>?,
      rim: json['rim'] as List<dynamic>?,
      hub: json['hub'] as List<dynamic>?,
      cog: json['cog'] as List<dynamic>?,
      sprocket: json['sprocket'] as List<dynamic>?,
      lockRing: json['lockRing'] as List<dynamic>?,
      freeWheel: json['freeWheel'] as List<dynamic>?,
      crank: json['crank'] as List<dynamic>?,
      chainRing: json['chainRing'] as List<dynamic>?,
      chain: json['chain'] as List<dynamic>?,
      bottomBrancket: json['bottomBrancket'] as List<dynamic>?,
      pedals: json['pedals'] as List<dynamic>?,
      brake: json['brake'] as List<dynamic>?,
      brakeLever: json['brakeLever'] as List<dynamic>?,
      shifter: json['shifter'] as List<dynamic>?,
      shiftLever: json['shiftLever'] as List<dynamic>?,
      rack: json['rack'] as List<dynamic>?,
      bottle: json['bottle'] as List<dynamic>?,
      frontLight: json['frontLight'] as List<dynamic>?,
      rearLight: json['rearLight'] as List<dynamic>?,
      lock: json['lock'] as List<dynamic>?,
      bell: json['bell'] as List<dynamic>?,
      helmet: json['helmet'] as List<dynamic>?,
      bag: json['bag'] as List<dynamic>?,
      basket: json['basket'] as List<dynamic>?,
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
      'fork': instance.fork,
      'headSet': instance.headSet,
      'columnSpacer': instance.columnSpacer,
      'handleBar': instance.handleBar,
      'stem': instance.stem,
      'grip': instance.grip,
      'saddle': instance.saddle,
      'seatPost': instance.seatPost,
      'seatClamp': instance.seatClamp,
      'tire': instance.tire,
      'rim': instance.rim,
      'hub': instance.hub,
      'cog': instance.cog,
      'sprocket': instance.sprocket,
      'lockRing': instance.lockRing,
      'freeWheel': instance.freeWheel,
      'crank': instance.crank,
      'chainRing': instance.chainRing,
      'chain': instance.chain,
      'bottomBrancket': instance.bottomBrancket,
      'pedals': instance.pedals,
      'brake': instance.brake,
      'brakeLever': instance.brakeLever,
      'shifter': instance.shifter,
      'shiftLever': instance.shiftLever,
      'rack': instance.rack,
      'bottle': instance.bottle,
      'frontLight': instance.frontLight,
      'rearLight': instance.rearLight,
      'lock': instance.lock,
      'bell': instance.bell,
      'helmet': instance.helmet,
      'bag': instance.bag,
      'basket': instance.basket,
    };
