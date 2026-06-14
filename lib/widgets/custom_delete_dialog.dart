import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carpooling/theme/app_text_styles.dart';

class CustomDeleteDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Delete',
    Color confirmColor = const Color(0xFFE7000B),
    Widget? icon,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),  // wider
        child: Padding(
          padding: EdgeInsets.all(23.98.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── icon ──
              if (icon != null) ...[
                icon,
                SizedBox(height: 16.h),
              ],
              Text(title,
                  style: AppTextStyles.tagline.copyWith(height: 1.4)),
              SizedBox(height: 12.h),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.emptyText.copyWith(
                      color: const Color(0xFF4A5565))),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5E7EB),
                              side: BorderSide.none,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r))),
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text('Cancel',
                              style: AppTextStyles.cs.copyWith(
                                  color: const Color(0xFF364153))))),
                  SizedBox(width: 12.w),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: confirmColor,
                              side: BorderSide.none,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r))),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            onConfirm();
                          },
                          child: Text(confirmText,
                              style: AppTextStyles.cs.copyWith(
                                  color: Colors.white)))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}