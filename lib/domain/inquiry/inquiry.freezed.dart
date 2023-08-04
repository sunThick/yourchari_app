// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inquiry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Inquiry _$InquiryFromJson(Map<String, dynamic> json) {
  return _Inquiry.fromJson(json);
}

/// @nodoc
mixin _$Inquiry {
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get inquiryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InquiryCopyWith<Inquiry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InquiryCopyWith<$Res> {
  factory $InquiryCopyWith(Inquiry value, $Res Function(Inquiry) then) =
      _$InquiryCopyWithImpl<$Res, Inquiry>;
  @useResult
  $Res call(
      {dynamic createdAt,
      String userName,
      String uid,
      String content,
      String inquiryId});
}

/// @nodoc
class _$InquiryCopyWithImpl<$Res, $Val extends Inquiry>
    implements $InquiryCopyWith<$Res> {
  _$InquiryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? userName = null,
    Object? uid = null,
    Object? content = null,
    Object? inquiryId = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      inquiryId: null == inquiryId
          ? _value.inquiryId
          : inquiryId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InquiryCopyWith<$Res> implements $InquiryCopyWith<$Res> {
  factory _$$_InquiryCopyWith(
          _$_Inquiry value, $Res Function(_$_Inquiry) then) =
      __$$_InquiryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      String userName,
      String uid,
      String content,
      String inquiryId});
}

/// @nodoc
class __$$_InquiryCopyWithImpl<$Res>
    extends _$InquiryCopyWithImpl<$Res, _$_Inquiry>
    implements _$$_InquiryCopyWith<$Res> {
  __$$_InquiryCopyWithImpl(_$_Inquiry _value, $Res Function(_$_Inquiry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? userName = null,
    Object? uid = null,
    Object? content = null,
    Object? inquiryId = null,
  }) {
    return _then(_$_Inquiry(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      inquiryId: null == inquiryId
          ? _value.inquiryId
          : inquiryId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Inquiry implements _Inquiry {
  const _$_Inquiry(
      {required this.createdAt,
      required this.userName,
      required this.uid,
      required this.content,
      required this.inquiryId});

  factory _$_Inquiry.fromJson(Map<String, dynamic> json) =>
      _$$_InquiryFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final String userName;
  @override
  final String uid;
  @override
  final String content;
  @override
  final String inquiryId;

  @override
  String toString() {
    return 'Inquiry(createdAt: $createdAt, userName: $userName, uid: $uid, content: $content, inquiryId: $inquiryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Inquiry &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.inquiryId, inquiryId) ||
                other.inquiryId == inquiryId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      userName,
      uid,
      content,
      inquiryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InquiryCopyWith<_$_Inquiry> get copyWith =>
      __$$_InquiryCopyWithImpl<_$_Inquiry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InquiryToJson(
      this,
    );
  }
}

abstract class _Inquiry implements Inquiry {
  const factory _Inquiry(
      {required final dynamic createdAt,
      required final String userName,
      required final String uid,
      required final String content,
      required final String inquiryId}) = _$_Inquiry;

  factory _Inquiry.fromJson(Map<String, dynamic> json) = _$_Inquiry.fromJson;

  @override
  dynamic get createdAt;
  @override
  String get userName;
  @override
  String get uid;
  @override
  String get content;
  @override
  String get inquiryId;
  @override
  @JsonKey(ignore: true)
  _$$_InquiryCopyWith<_$_Inquiry> get copyWith =>
      throw _privateConstructorUsedError;
}
