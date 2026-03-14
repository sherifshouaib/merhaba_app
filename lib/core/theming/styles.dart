import 'package:flutter/material.dart';
import 'package:merhaba/core/theming/font_weight_helper.dart';

abstract class Styles {
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );

  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );

  static const textStylecheckout25 = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.medium,
    height: 0,
  );

  static const textStylecheckout18 = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.medium,
    height: 0,
  );

  static const textStylecheckoutBold18 = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    height: 0,
  );

  static const textStylecheckout24 = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.semiBold,
    height: 0,
  );

  static TextStyle textStylecheckout20 = TextStyle(
    color: Colors.black.withValues(alpha: 0.8),
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.regular,
    height: 0,
  );

  static const textStylecheckout22 = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.medium,
    height: 0,
  );
}
