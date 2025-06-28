import 'package:flutter/material.dart';

class TextStyles {
  static medium1({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 12,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w500);
  }

  static medium2({Color? color}) {
    return TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w500);
  }

  static medium3({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 16,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w500);
  }

  static medium4({Color? color}) {
    return TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w500);
  }

  static regular1(
      {Color? color, TextDecoration? decoration, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 12,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w400,
        decoration: decoration);
  }

  static regular2({Color? color}) {
    return TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w400);
  }

  static regular3({Color? color}) {
    return TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w400);
  }

  static regular4({Color? color}) {
    return TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w400);
  }

  static regular5({Color? color}) {
    return TextStyle(
        fontSize: 20,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w400);
  }

  static semiBold(
      {Color? color, double? fontSize, TextDecoration? decoration}) {
    return TextStyle(
        fontSize: fontSize ?? 12,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w600,
        decoration: decoration);
  }

  static bold1({Color? color, required int fontSize}) {
    return TextStyle(
        fontSize: 12,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static bold2({Color? color}) {
    return TextStyle(
        fontSize: 14,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static bold3({Color? color}) {
    return TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static bold4({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 18,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static bold5({Color? color}) {
    return TextStyle(
        fontSize: 18,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static bold6({Color? color}) {
    return TextStyle(
        fontSize: 20,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w700);
  }

  static dmsansLight({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: dmSansFamily,
        fontWeight: FontWeight.w300);
  }

  static clashLight({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: clashFamily,
        fontWeight: FontWeight.w300);
  }

  static clashRegular({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: clashFamily,
        fontWeight: FontWeight.w400);
  }

  static clashMedium({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: clashFamily,
        fontWeight: FontWeight.w500);
  }

  static clashSemiBold({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: clashFamily,
        fontWeight: FontWeight.w600);
  }

  static clashBold({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize ?? 20,
        color: color,
        fontFamily: clashFamily,
        fontWeight: FontWeight.w700);
  }
}

const dmSansFamily = "dmSans";
const clashFamily = "clash";
