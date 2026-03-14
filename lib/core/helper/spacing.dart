import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(
  height: height.h,

  // // .h is used when you use flutter_screenutil package to
  // make the app responsive but if you are not using it you can just use height: height
);
SizedBox horizontalSpace(double width) => SizedBox(width: width.w);
