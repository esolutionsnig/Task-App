import 'package:flutter/material.dart';
import 'package:tasks/shared/color.dart';

const textInputDecoration = InputDecoration(
  fillColor: cFormFillColor,
  filled: true,
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: cRed, width: 2)),
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: cWhite, width: 2)),
);
