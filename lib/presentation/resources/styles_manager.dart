

import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight);
}
// Light Style

TextStyle getLightStyle(
    {double fontSize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// Medium Style
TextStyle getMediumStyle(
    {double fontSize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// Bold Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semibold, color);
}

// SemiBold Style
TextStyle getBoldStyle(
    {double fontSize = FontSize.fs12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
