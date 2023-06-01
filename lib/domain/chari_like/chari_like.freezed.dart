// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chari_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChariLike _$ChariLikeFromJson(Map<String, dynamic> json) {
  return _Charilike.fromJson(json);
}

/// @nodoc
mixin _$ChariLike {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get passiveUid => throw _privateConstructorUsedError;
  dynamic get chariRef => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChariLikeCopyWith<ChariLike> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChariLikeCopyWith<$Res> {
  factory $ChariLikeCopyWith(ChariLike value, $Res Function(ChariLike) then) =
      _$ChariLikeCopyWithImpl<$Res, ChariLike>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String passiveUid,
      dynamic chariRef,
      String postId});
}

/// @nodoc
class _$ChariLikeCopyWithImpl<$Res, $Val extends ChariLike>
    implements $ChariLikeCopyWith<$Res> {
  _$ChariLikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? passiveUid = null,
    Object? chariRef = freezed,
    Object? postId = null,
  }) {
    return _then(_value.copyWith(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      chariRef: freezed == chariRef
          ? _value.chariRef
          : chariRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CharilikeCopyWith<$Res> implements $ChariLikeCopyWith<$Res> {
  factory _$$_CharilikeCopyWith(
          _$_Charilike value, $Res Function(_$_Charilike) then) =
      __$$_CharilikeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String passiveUid,
      dynamic chariRef,
      String postId});
}

/// @nodoc
class __$$_CharilikeCopyWithImpl<$Res>
    extends _$ChariLikeCopyWithImpl<$Res, _$_Charilike>
    implements _$$_CharilikeCopyWith<$Res> {
  __$$_CharilikeCopyWithImpl(
      _$_Charilike _value, $Res Function(_$_Charilike) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? passiveUid = null,
    Object? chariRef = freezed,
    Object? postId = null,
  }) {
    return _then(_$_Charilike(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      chariRef: freezed == chariRef
          ? _value.chariRef
          : chariRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Charilike implements _Charilike {
  const _$_Charilike(
      {required this.activeUid,
      required this.createdAt,
      required this.passiveUid,
      required this.chariRef,
      required this.postId});

  factory _$_Charilike.fromJson(Map<String, dynamic> json) =>
      _$$_CharilikeFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String passiveUid;
  @override
  final dynamic chariRef;
  @override
  final String postId;

  @override
  String toString() {
    return 'ChariLike(activeUid: $activeUid, createdAt: $createdAt, passiveUid: $passiveUid, chariRef: $chariRef, postId: $postId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Charilike &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.passiveUid, passiveUid) ||
                other.passiveUid == passiveUid) &&
            const DeepCollectionEquality().equals(other.chariRef, chariRef) &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeUid,
      const DeepCollectionEquality().hash(createdAt),
      passiveUid,
      const DeepCollectionEquality().hash(chariRef),
      postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CharilikeCopyWith<_$_Charilike> get copyWith =>
      __$$_CharilikeCopyWithImpl<_$_Charilike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharilikeToJson(
      this,
    );
  }
}

abstract class _Charilike implements ChariLike {
  const factory _Charilike(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String passiveUid,
      required final dynamic chariRef,
      required final String postId}) = _$_Charilike;

  factory _Charilike.fromJson(Map<String, dynamic> json) =
      _$_Charilike.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get passiveUid;
  @override
  dynamic get chariRef;
  @override
  String get postId;
  @override
  @JsonKey(ignore: true)
  _$$_CharilikeCopyWith<_$_Charilike> get copyWith =>
      throw _privateConstructorUsedError;
}
