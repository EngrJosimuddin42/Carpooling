import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';

class EmailSupportScreen extends StatefulWidget {
  const EmailSupportScreen({super.key});

  @override
  State<EmailSupportScreen> createState() => _EmailSupportScreenState();
}

class _EmailSupportScreenState extends State<EmailSupportScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _sendEmail() {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _subjectCtrl.text.isEmpty ||
        _messageCtrl.text.isEmpty) {

      AppSnackBar.show(
        context: context,
        message: 'Please fill in all fields',
        backgroundColor: Colors.red,

      );
      return;
    }
    AppSnackBar.show(
      context: context,
      message: 'Email sent successfully!',
      backgroundColor: Colors.orange,
    );

    _nameCtrl.clear();
    _emailCtrl.clear();
    _subjectCtrl.clear();
    _messageCtrl.clear();
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
                          shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back,
                          size: 22.sp, color: const Color(0xFF364153))))),
          title: Text('Email Support', style: AppTextStyles.heading),

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Direct Email banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(17.5.w),
              decoration: BoxDecoration(
                color: const Color(0x3366B2A3),
                borderRadius: BorderRadius.circular(14.23.r),
                border: Border.all(color: AppColors.primary, width: 1.24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/email_outlined.svg', width: 20.sp, height: 20.sp,
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
                      SizedBox(width: 12.w),
                      Text('Direct Email',
                          style: AppTextStyles.display.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text('support@carpool.com',
                      style: AppTextStyles.school.copyWith(color: AppColors.primary)),
                  SizedBox(height: 8.h),
                  Text('Response time: Usually within 24 hours',
                      style: AppTextStyles.time.copyWith(color: AppColors.primary)),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            SizedBox(height: 24.h),

            // Form fields
            _buildLabel('Your Name'),
            SizedBox(height: 8.h),
            AppTextField(
              controller: _nameCtrl,
              hintText: 'Enter your name',
              fillColor:const Color(0xFFF9FAFB),
              borderColor:const Color(0xFFD1D5DC),
              prefixIcon: SvgPicture.asset(
                'assets/icons/person_outline.svg', width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn)),
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

            SizedBox(height: 16.h),

            _buildLabel('Your Email'),
            SizedBox(height: 8.h),
            AppTextField(
              controller: _emailCtrl,
              hintText: 'Enter your email',
              fillColor:const Color(0xFFF9FAFB),
              borderColor:const Color(0xFFD1D5DC),
              keyboardType: TextInputType.emailAddress,
              prefixIcon: SvgPicture.asset(
                'assets/icons/email_outlined.svg',
                width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn),
              ),
            ).animate().fadeIn(delay: 150.ms, duration: 300.ms),

            SizedBox(height: 16.h),

            _buildLabel('Subject'),
            SizedBox(height: 8.h),
            AppTextField(
              controller: _subjectCtrl,
              hintText: 'What is this about?',
              fillColor:const Color(0xFFF9FAFB),
              borderColor:const Color(0xFFD1D5DC),
              prefixIcon: SvgPicture.asset(
                'assets/icons/description_outlined.svg',
                width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

            SizedBox(height: 16.h),

            _buildLabel('Message'),
            SizedBox(height: 8.h),
            AppTextField(
              controller: _messageCtrl,
              hintText: 'Describe your issue or question in detail...',
              fillColor:const Color(0xFFF9FAFB),
              borderColor:const Color(0xFFD1D5DC),
              maxLines: 6,
            ).animate().fadeIn(delay: 250.ms, duration: 300.ms),

            SizedBox(height: 20.h),

            // Send Button
            PrimaryButton(
              text: 'Send Email',
              icon: SvgPicture.asset(
                'assets/icons/send.svg', width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              onPressed: _sendEmail,
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    //  bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.mark.copyWith(color:const Color(0xFF364153)));
  }

}