// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_chari_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FormChariText {
  String get part => throw _privateConstructorUsedError;
  TextEditingController get brandEditingController =>
      throw _privateConstructorUsedError;
  TextEditingController get nameEditingController =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FormChariTextCopyWith<FormChariText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormChariTextCopyWith<$Res> {
  factory $FormChariTextCopyWith(
          FormChariText value, $Res Function(FormChariText) then) =
      _$FormChariTextCopyWithImpl<$Res, FormChariText>;
  @useResult
  $Res call(
      {String part,
      TextEditingController brandEditingController,
      TextEditingController nameEditingController});
}

/// @nodoc
class _$FormChariTextCopyWithImpl<$Res, $Val extends FormChariText>
    implements $FormChariTextCopyWith<$Res> {
  _$FormChariTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? brandEditingController = null,
    Object? nameEditingController = null,
  }) {
    return _then(_value.copyWith(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      brandEditingController: null == brandEditingController
          ? _value.brandEditingController
          : brandEditingController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nameEditingController: null == nameEditingController
          ? _value.nameEditingController
          : nameEditingController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FormChariTextCopyWith<$Res>
    implements $FormChariTextCopyWith<$Res> {
  factory _$$_FormChariTextCopyWith(
          _$_FormChariText value, $Res Function(_$_FormChariText) then) =
      __$$_FormChariTextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String part,
      TextEditingController brandEditingController,
      TextEditingController nameEditingController});
}

/// @nodoc
class __$$_FormChariTextCopyWithImpl<$Res>
    extends _$FormChariTextCopyWithImpl<$Res, _$_FormChariText>
    implements _$$_FormChariTextCopyWith<$Res> {
  __$$_FormChariTextCopyWithImpl(
      _$_FormChariText _value, $Res Function(_$_FormChariText) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? brandEditingController = null,
    Object? nameEditingController = null,
  }) {
    return _then(_$_FormChariText(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      brandEditingController: null == brandEditingController
          ? _value.brandEditingController
          : brandEditingController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nameEditingController: null == nameEditingController
          ? _value.nameEditingController
          : nameEditingController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$_FormChariText implements _FormChariText {
  const _$_FormChariText(
      {required this.part,
      required this.brandEditingController,
      required this.nameEditingController});

  @override
  final String part;
  @override
  final TextEditingController brandEditingController;
  @override
  final TextEditingController nameEditingController;

  @override
  String toString() {
    return 'FormChariText(part: $part, brandEditingController: $brandEditingController, nameEditingController: $nameEditingController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FormChariText &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.brandEditingController, brandEditingController) ||
                other.brandEditingController == brandEditingController) &&
            (identical(other.nameEditingController, nameEditingController) ||
                other.nameEditingController == nameEditingController));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, part, brandEditingController, nameEditingController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FormChariTextCopyWith<_$_FormChariText> get copyWith =>
      __$$_FormChariTextCopyWithImpl<_$_FormChariText>(this, _$identity);
}

abstract class _FormChariText implements FormChariText {
  const factory _FormChariText(
          {required final String part,
          required final TextEditingController brandEditingController,
          required final TextEditingController nameEditingController}) =
      _$_FormChariText;

  @override
  String get part;
  @override
  TextEditingController get brandEditingController;
  @override
  TextEditingController get nameEditingController;
  @override
  @JsonKey(ignore: true)
  _$$_FormChariTextCopyWith<_$_FormChariText> get copyWith =>
      throw _privateConstructorUsedError;
}
