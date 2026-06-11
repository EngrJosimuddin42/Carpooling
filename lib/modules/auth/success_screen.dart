import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_buttons.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessScreen({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(24.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/congration icon.svg', width: 186.w, height: 180.h,
            ).animate().scale(
              begin: const Offset(0.5, 0.5),
              duration: 500.ms,
              curve: Curves.elasticOut),

            SizedBox(height: 32.h),

            Text('Congratulations!',
              style: AppTextStyles.headlineLarge.copyWith(height: 1.2),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            SizedBox(height: 16.h),

            Text( message,
              textAlign: TextAlign.center,
              style: AppTextStyles.medium,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

            SizedBox(height: 32.h),

            PrimaryButton(
              text: buttonText,
              onPressed: onPressed,
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context, {required bool isPasswordReset}) {
  showDialog(
    context: context,
    barrierColor: const Color(0xAD0C0C0C),
    barrierDismissible: false,
    builder: (_) => SuccessScreen(
      message: isPasswordReset
          ? 'Your password has been successfully renewed!'
          : 'Your HadiKid account has been successfully created and verified!',
      buttonText: isPasswordReset ? 'Home' : 'OK',
      onPressed: () {
        Navigator.pop(context);
        if (isPasswordReset) {
          context.go(AppRoutes.home);
        } else {
          context.push(AppRoutes.addChild);
        }
      },
    ),
  );
}