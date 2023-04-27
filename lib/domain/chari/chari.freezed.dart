// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chari.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chari _$ChariFromJson(Map<String, dynamic> json) {
  return _Chari.fromJson(json);
}

/// @nodoc
mixin _$Chari {
  String get brand => throw _privateConstructorUsedError;
  String get frame => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChariCopyWith<Chari> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChariCopyWith<$Res> {
  factory $ChariCopyWith(Chari value, $Res Function(Chari) then) =
      _$ChariCopyWithImpl<$Res, Chari>;
  @useResult
  $Res call(
      {String brand,
      String frame,
      String? caption,
      String createdAt,
      String? updatedAt});
}

/// @nodoc
class _$ChariCopyWithImpl<$Res, $Val extends Chari>
    implements $ChariCopyWith<$Res> {
  _$ChariCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? frame = null,
    Object? caption = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      frame: null == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChariCopyWith<$Res> implements $ChariCopyWith<$Res> {
  factory _$$_ChariCopyWith(_$_Chari value, $Res Function(_$_Chari) then) =
      __$$_ChariCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String brand,
      String frame,
      String? caption,
      String createdAt,
      String? updatedAt});
}

/// @nodoc
class __$$_ChariCopyWithImpl<$Res> extends _$ChariCopyWithImpl<$Res, _$_Chari>
    implements _$$_ChariCopyWith<$Res> {
  __$$_ChariCopyWithImpl(_$_Chari _value, $Res Function(_$_Chari) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? frame = null,
    Object? caption = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Chari(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      frame: null == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chari implements _Chari {
  const _$_Chari(
      {required this.brand,
      required this.frame,
      this.caption,
      required this.createdAt,
      this.updatedAt});

  factory _$_Chari.fromJson(Map<String, dynamic> json) =>
      _$$_ChariFromJson(json);

  @override
  final String brand;
  @override
  final String frame;
  @override
  final String? caption;
  @override
  final String createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'Chari(brand: $brand, frame: $frame, caption: $caption, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chari &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.frame, frame) || other.frame == frame) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, brand, frame, caption, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChariCopyWith<_$_Chari> get copyWith =>
      __$$_ChariCopyWithImpl<_$_Chari>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChariToJson(
      this,
    );
  }
}

abstract class _Chari implements Chari {
  const factory _Chari(
      {required final String brand,
      required final String frame,
      final String? caption,
      required final String createdAt,
      final String? updatedAt}) = _$_Chari;

  factory _Chari.fromJson(Map<String, dynamic> json) = _$_Chari.fromJson;

  @override
  String get brand;
  @override
  String get frame;
  @override
  String? get caption;
  @override
  String get createdAt;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChariCopyWith<_$_Chari> get copyWith =>
      throw _privateConstructorUsedError;
}
