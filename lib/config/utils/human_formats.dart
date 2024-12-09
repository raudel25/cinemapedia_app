import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HumanFormats {
  static String numberDecimal(double number,
      {int decimal = 2, Locale? locale}) {
    final formatterNumber = NumberFormat.decimalPatternDigits(
        decimalDigits: decimal, locale: locale?.toString());

    return formatterNumber.format(number);
  }

  static String numberCompact(double number, {Locale? locale}) {
    final formatterNumber = NumberFormat.compact(locale: locale?.toString());

    return formatterNumber.format(number);
  }
}
