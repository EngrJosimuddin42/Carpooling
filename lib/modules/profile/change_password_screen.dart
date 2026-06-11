import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../auth/success_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showOld = false;
  bool _showPass = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _oldPassCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leadingWidth: 72.w,
        titleSpacing: 8.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back,
                  size: 22.sp, color: const Color(0xFF364153)),
            ),
          ),
        ),
        title: Text('Change Password', style: AppTextStyles.heading),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Divider(color: Colors.grey.shade300, height: 2, thickness: 2),
            SizedBox(height: 20.h),

            Text(
              'Set New Password',
              style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 34.sp),
            ).animate().fadeIn(duration: 400.ms),

            SizedBox(height: 12.h),

            Text(
              'Create a secure new password to protect \nyour account.',
              textAlign: TextAlign.center,
              style: AppTextStyles.school
                  .copyWith(color: const Color(0xFF525866)),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

            SizedBox(height: 24.h),

            //  Old Password
            AppTextField(
              controller: _oldPassCtrl,
              hintText: 'Old Password',
              obscureText: !_showOld,
              fillColor: const Color(0xFFF9FAFB),
              suffixIcon: IconButton(
                icon: Icon(
                  _showOld
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                  size: 24.sp,
                ),
                onPressed: () => setState(() => _showOld = !_showOld),
              ),
            ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

            SizedBox(height: 14.h),

            //  New Password
            AppTextField(
              controller: _passCtrl,
              hintText: 'New Password',
              obscureText: !_showPass,
              fillColor: const Color(0xFFF9FAFB),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPass
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                  size: 24.sp,
                ),
                onPressed: () => setState(() => _showPass = !_showPass),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            SizedBox(height: 14.h),

            // Confirm Password
            AppTextField(
              controller: _confirmCtrl,
              hintText: 'Confirm Password',
              obscureText: !_showConfirm,
              fillColor: const Color(0xFFF9FAFB),
              suffixIcon: IconButton(
                icon: Icon(
                  _showConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                  size: 24.sp,
                ),
                onPressed: () =>
                    setState(() => _showConfirm = !_showConfirm),
              ),
            ).animate().fadeIn(delay: 250.ms, duration: 400.ms),

            SizedBox(height: 32.h),

            // Save Button
            PrimaryButton(
              text: 'Save Password',
              onPressed: () {
                if (_oldPassCtrl.text.isNotEmpty &&
                    _passCtrl.text.isNotEmpty &&
                    _passCtrl.text == _confirmCtrl.text) {
                  showSuccessDialog(context, isPasswordReset: true);
                }
              },
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }
}