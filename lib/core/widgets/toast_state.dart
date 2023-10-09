import 'package:chef/core/resources/color_manager.dart';
import 'package:chef/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast ({
  required String text,
  required ToastState state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: ColorManager.sWhite,
  fontSize: AppSize.s15,
);

enum ToastState{success,error,warning}

Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.success:
      color = ColorManager.green;
      break;
    case ToastState.error:
      color = ColorManager.red;
      break;
    case ToastState.warning:
      color = ColorManager.amber;
      break;
  }
  return color;
}