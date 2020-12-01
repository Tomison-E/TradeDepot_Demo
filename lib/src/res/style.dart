import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colours.dart';

class Style {

  static const TextStyle regText =  TextStyle(color: Colours.regText,fontSize: 16);
  static const TextStyle hintText =  TextStyle(color: Colours.outlineBorder,fontSize: 18);
  static const TextStyle helperText =  TextStyle(color: Colours.helperText,fontSize: 13);
  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(borderSide: BorderSide(
      color: Colours.outlineBorder, width: 1.0));
  static const TextStyle darkText =  TextStyle(color: Colours.darkBlue,fontSize: 13,fontWeight: FontWeight.bold);
  static const TextStyle lightText =  TextStyle(color: Colours.lightBlue,fontSize: 11);
  static const TextStyle greyText =  TextStyle(color: Colours.grey,fontSize: 11);

}