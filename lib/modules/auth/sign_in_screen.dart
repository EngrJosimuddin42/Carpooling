import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import 'package:country_picker/country_picker.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey        = GlobalKey<FormState>();
  final _phoneCtrl      = TextEditingController();
  final _passwordCtrl   = TextEditingController();
  String _selectedCode = '+90';
  String _selectedFlag = '🇹🇷';
  bool _obscurePassword = true;
  bool _rememberMe      = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.pop();
      context.push(AppRoutes.otp, extra: {
        'phone': '$_selectedCode ${_phoneCtrl.text.startsWith("0") ? _phoneCtrl.text.substring(1) : _phoneCtrl.text}',
        'isSignUp': false,
      });
    }
  }


  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 100.h),

                Center(
                  child: Text(
                    'Sign In Your Account',
                      style: AppTextStyles.large.copyWith(fontWeight: FontWeight.w600)),
                ).animate().fadeIn(duration: 400.ms),

                SizedBox(height: 24.h),

                _buildPhoneField().animate().fadeIn(delay: 100.ms, duration: 400.ms),

                 SizedBox(height: 16.h),

                AppTextField(
                  controller: _passwordCtrl,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.muted, size: 24),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

                 SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5),
                          activeColor: const Color(0xFF3B8677),
                          checkColor: Colors.white,
                          onChanged: (v) => setState(() => _rememberMe = v ?? false),
                        ),
                        SizedBox(width: 8.w),
                        Text( 'Remember me',
                          style: AppTextStyles.buttonText.copyWith(color: const Color(0xFF707070))),
                      ],
                    ),

                    // ── Forgot Password  ──
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.forgotPassword),
                      child: Text('Forgot password?',
                        style: AppTextStyles.buttonText.copyWith( color: AppColors.primary))),
                  ],
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                SizedBox(height: 24.h),
                PrimaryButton(
                  text: 'Next',
                  onPressed: _submit,
                ).animate().fadeIn(delay: 250.ms, duration: 400.ms),

                 SizedBox(height: 32.h),

                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.hintText,
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign Up',
                          style: AppTextStyles.buttonText.copyWith(color: AppColors.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () { context.push(AppRoutes.signUp);
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
                _orDivider(),
                SizedBox(height: 12.h),

                SocialButton(
                  icon: SvgPicture.asset(
                      'assets/icons/google.svg', width: 24.w, height: 24.w),
                  text: 'Continue with Google',
                  onPressed: () {},
                ),
                SizedBox(height: 12.h),
                SocialButton(
                  icon: const SizedBox.shrink(),
                  text: 'Continue with Phone',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
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
            fillColor: AppColors.bg,
            validator: (v) => (v == null || v.isEmpty) ? 'Enter phone number' : null,
          ),
        ),
      ],
    );
  }

  Widget _orDivider() => Row(
    children: [
      const Expanded(child: Divider(color: Color(0xFFCDD0D5))),
      Padding(
          padding: EdgeInsets.symmetric(horizontal:8.h),
          child: Text('Or', style: TextStyle(color:const Color(0xFF868C98), fontSize: 12.sp))),
      const Expanded(child: Divider(color: Color(0xFFCDD0D5))),
    ],
  );
}