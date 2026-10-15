import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'adaptive_layout.dart';

/// Secondary scaling helper.
///
/// Rule in this template:
/// 1) Primary responsive decisions come from `AdaptiveLayoutData` (breakpoints, panes).
/// 2) `ScreenUtil` is used only for fine-tuning sizes, mostly on compact layouts.
class ScreenUtilsHelper {
  ScreenUtilsHelper._();

  static bool _useScale(BuildContext context) {
    return context.adaptiveLayout.isCompact;
  }

  static double width(BuildContext context, double value) {
    if (!_useScale(context)) return value;
    try {
      return value.w;
    } on Object {
      return value;
    }
  }

  static double height(BuildContext context, double value) {
    if (!_useScale(context)) return value;
    try {
      return value.h;
    } on Object {
      return value;
    }
  }

  static double radius(BuildContext context, double value) {
    if (!_useScale(context)) return value;
    try {
      return value.r;
    } on Object {
      return value;
    }
  }

  static double font(BuildContext context, double value) {
    if (!_useScale(context)) return value;
    try {
      return value.sp;
    } on Object {
      return value;
    }
  }
}
