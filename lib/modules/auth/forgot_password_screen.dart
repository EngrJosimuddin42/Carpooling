import 'dart:async';
import 'package:carpooling/modules/auth/success_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import 'package:country_picker/country_picker.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _step = 1; // 1: Phone, 2: OTP, 3: New Password

  // Step 1
  final _phoneCtrl = TextEditingController();
  String _selectedCode = '+90';
  String _selectedFlag = '🇹🇷';

  // Step 2
  final _otpCtrl = TextEditingController();
  int _resendSeconds = 53;
  Timer? _timer;

  // Step 3
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _showPass = false;
  bool _showConfirmPass = false;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _otpCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 53;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds == 0) {
        t.cancel();
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  void _goToStep(int step) {
    setState(() => _step = step);
    if (step == 2) _startResendTimer();
  }

  String _appBarTitle() {
    if (_step == 1) return 'Forget Password';
    if (_step == 2) return 'Reset Password';
    return 'Create New Password';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor:const Color(0xFFFCFCFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 24.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () {
            if (_step > 1) {
              setState(() => _step--);
            } else {
              context.pop();
            }
          },
        ),
        title: Text(_appBarTitle(), style: AppTextStyles.title.copyWith(color:const Color(0xFF0C0C0C)))),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: 300.ms,
          child: _step == 1
              ? _buildStep1()
              : _step == 2
              ? _buildStep2()
              : _buildStep3(),
        ),
      ),
    );
  }

  // ─── Step 1: Phone Number
  Widget _buildStep1() {
    return Padding(
      key: const ValueKey(1),
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          const Spacer(),
          _buildPhoneField()
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.1),
          SizedBox(height: 40.h),
          PrimaryButton(
            text: 'Next',
            onPressed: () {
              if (_phoneCtrl.text.isNotEmpty) _goToStep(2);
            },
          ).animate().fadeIn(delay: 100.ms),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                setState(() {
                  _selectedFlag = country.flagEmoji;
                  _selectedCode = '+${country.phoneCode}';
                });
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_selectedFlag, style: TextStyle(fontSize: 24.sp)),
              SizedBox(width: 4.w),
              Icon(Icons.keyboard_arrow_down, size: 18.sp, color:const Color(0xFF707070)),
              SizedBox(width: 4.w),
              Text(
                _selectedCode,
                style: AppTextStyles.hintText,
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        Expanded(
          child: AppTextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            hintText: 'Mobile Phone Number...',
            fillColor: const Color(0xFFFCFCFC),
          ),
        ),
      ],
    );
  }

  // ─── Step 2: OTP
  Widget _buildStep2() {
    final defaultPinTheme = PinTheme(
      width: 85.w,
      height: 61.h,
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

    return Padding(
      key: const ValueKey(2),
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Password reset code has been sent to ${_phoneCtrl.text.isEmpty ? '...' : '$_selectedCode ${_phoneCtrl.text.startsWith("0") ? _phoneCtrl.text.substring(1) : _phoneCtrl.text}'}. Please enter the code below.',
            style: AppTextStyles.medium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms),
          SizedBox(height: 24.h),
          Pinput(
            controller: _otpCtrl,
            length: 4,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            onCompleted: (_) {},
          ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.9, 0.9)),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Resend Code in ', style: AppTextStyles.hintText),
              Text(
                '${_resendSeconds}s',
                style: AppTextStyles.buttonText.copyWith(color: AppColors.primary),
              ),
            ],
          ).animate().fadeIn(delay: 150.ms),
          const Spacer(),
          PrimaryButton(
            text: 'Next',
            onPressed: () {
              if (_otpCtrl.text.length == 4) _goToStep(3);
            },
          ).animate().fadeIn(delay: 200.ms),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // ─── Step 3: New Password
  Widget _buildStep3() {
    return Padding(
      key: const ValueKey(3),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text('Create New Password here', style: AppTextStyles.medium)
              .animate()
              .fadeIn(duration: 400.ms),
          SizedBox(height: 24.h),
          _buildPasswordField(_passCtrl,'New Password', _showPass, () {
            setState(() => _showPass = !_showPass);
          }).animate().fadeIn(delay: 100.ms),
          SizedBox(height: 24.h),
          _buildPasswordField(_confirmPassCtrl,'Confirm Password', _showConfirmPass, () {
            setState(() => _showConfirmPass = !_showConfirmPass);
          }).animate().fadeIn(delay: 150.ms),
          const Spacer(),
          PrimaryButton(
            text: 'Done',
            onPressed: () {
              if (_passCtrl.text.isNotEmpty &&
                  _passCtrl.text == _confirmPassCtrl.text) {
                showSuccessDialog(context, isPasswordReset: true);
              }
            },
          ).animate().fadeIn(delay: 200.ms),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController ctrl, String hint, bool show, VoidCallback toggle) {
    return AppTextField(
      controller: ctrl,
      obscureText: !show,
      hintText: hint,
      fillColor: const Color(0xFFFCFCFC),
      suffixIcon: IconButton(
        icon: Icon(
          show ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: const Color(0xFF707070),
          size: 24.sp,
        ),
        onPressed: toggle,
      ),
    );
  }
}