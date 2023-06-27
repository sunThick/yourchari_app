import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_chari_text.freezed.dart';

@freezed
abstract class FormChariText with _$FormChariText {
  const factory FormChariText(
      {required String part,
      required TextEditingController brandEditingController,
      required TextEditingController nameEditingController}) = _FormChariText;
}
