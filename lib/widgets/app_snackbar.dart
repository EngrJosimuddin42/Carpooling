import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_text_styles.dart';

enum SnackPosition { top, center, bottom }

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (position == SnackPosition.bottom) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.medium.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          duration: duration,
        ),
      );
      return;
    }

    // top ও center এর জন্য Overlay use করুন
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    AlignmentGeometry alignment;
    EdgeInsets padding;

    if (position == SnackPosition.top) {
      alignment = Alignment.topCenter;
      padding = EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w);
    } else {
      alignment = Alignment.center;
      padding = EdgeInsets.symmetric(horizontal: 16.w);
    }

    entry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(
          child: Padding(
            padding: padding,
            child: Align(
              alignment: alignment,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: AppTextStyles.medium.copyWith(color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(duration, () => entry.remove());
  }
}