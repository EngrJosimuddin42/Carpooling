import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 55.r,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Icon(Icons.person, size: 55.sp, color: Colors.white),
            ),
            SizedBox(height: 20.h),
            Text('Ahmed Rahman',
                style: AppTextStyles.large.copyWith(color: Colors.white)),
            SizedBox(height: 8.h),
            Text('Calling...',
                style: AppTextStyles.medium.copyWith(color: Colors.white70)),
            SizedBox(height: 6.h),
            Text('+880 1712-345678',
                style: AppTextStyles.medium.copyWith(color: Colors.white70)),
            SizedBox(height: 20.h),
            Text('00:00',
                style: AppTextStyles.large.copyWith(
                    color: Colors.white, fontSize: 32.sp)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _callBtn(Icons.mic_off, Colors.white.withOpacity(0.2), Colors.white, () {}),
                SizedBox(width: 24.w),
                _callBtn(Icons.call_end, Colors.red, Colors.white,
                        () => Navigator.pop(context)),
                SizedBox(width: 24.w),
                _callBtn(Icons.volume_up, Colors.white.withOpacity(0.2), Colors.white, () {}),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _callBtn(IconData icon, Color bg, Color fg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: fg, size: 28.sp),
      ),
    );
  }
}