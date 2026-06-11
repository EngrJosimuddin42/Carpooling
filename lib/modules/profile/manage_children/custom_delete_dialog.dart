import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carpooling/theme/app_text_styles.dart';

class CustomDeleteDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(23.98.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTextStyles.tagline.copyWith(height: 1.4)),
              SizedBox(height: 12.h),
              Text(message, textAlign: TextAlign.center,
                  style: AppTextStyles.emptyText.copyWith(color: const Color(0xFF4A5565))),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:const Color(0xFFE5E7EB),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r))),
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text('Cancel', style: AppTextStyles.cs.copyWith(color: const Color(0xFF364153))))),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE7000B),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r))),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onConfirm();
                      },
                      child: Text('Delete', style: AppTextStyles.cs.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}