import 'package:carpooling/modules/auth/success_screen.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_buttons.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final bool isSignUp;

  const OtpScreen({super.key, required this.phone, required this.isSignUp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpCtrl = TextEditingController();

  void _verify() async {
    if (_otpCtrl.text.length == 4) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;
      Navigator.pop(context);

      if (_otpCtrl.text == "1234") {
        if (widget.isSignUp) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (!mounted) return;
          showSuccessDialog(context, isPasswordReset: false);
        } else {
          context.push(AppRoutes.home);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The OTP code is incorrect! (Use 1234 for testing)'),
            backgroundColor: Colors.red,
          ),
        );
        _otpCtrl.clear();
      }
    }
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70.w,
      height: 70.w,
      textStyle: AppTextStyles.digit,
      decoration: BoxDecoration(
        border: Border.all(color:const Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(4.r),
        color: const Color(0xFFFCFCFC),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 1),
    );

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color:const Color(0xFF0C0C0C),
            size: 24.sp),
          onPressed: () => context.pop()),
        title: Text(
          'Mobile Verification',
          style: AppTextStyles.title.copyWith(
            color: const Color(0xFF0C0C0C)))),
      body: SafeArea(
        child: SingleChildScrollView(
        padding:  EdgeInsets.all(20.h),
        child: Column(
          children: [
             SizedBox(height: 170.h),

            Text('OTP Verification',
                style:AppTextStyles.large).animate().fadeIn(duration: 400.ms),

             SizedBox(height: 24.h),

            Text( 'An OTP code has been sent to ${widget.phone.isEmpty ? '+88052523151' : widget.phone}',
              style: AppTextStyles.medium,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

             SizedBox(height: 6.h),

            Text('Enter the code below to continue',
             style: AppTextStyles.medium,
            ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

             SizedBox(height: 24.h),

            Pinput(
              controller: _otpCtrl,
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              onCompleted: (_) => _verify(),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),

             SizedBox(height: 24.h),

            GestureDetector(
              onTap: () {},
              child: Text('Resend',
                  style: AppTextStyles.buttonText.copyWith(color: AppColors.primary)),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

             SizedBox(height: 90.h),


            PrimaryButton(
              text: widget.isSignUp ? 'Next' : 'Sign In',
              onPressed: _verify,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

             SizedBox(height: 16.h),
          ],
        ),
      ),
    ),
    );
  }
}