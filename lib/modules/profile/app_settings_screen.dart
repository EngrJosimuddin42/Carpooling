import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../widgets/app_bottom_nav.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  // Notifications
  bool _pushNotifications = true;
  bool _chatNotifications = true;
  bool _rideReminders = true;
  bool _soundVibration = true;

  // Live Tracking
  bool _childPickupDropoff = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor:const Color(0xFFF9FAFB),
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
              child: Icon( Icons.arrow_back, size: 22.sp,
                color: const Color(0xFF364153))))),

        title: Text( 'App Settings',
          style: AppTextStyles.heading)),

        body: Column(
          children: [
            SizedBox(height: 24.h),
            Divider(color: Colors.grey.shade300, height: 2, thickness: 2),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications
            _buildSection(
              svgIconPath: 'assets/icons/notification_outlined.svg',
              iconColor: const Color(0xFF66B2A3),
              title: 'Notifications',
              children: [
                _toggleItem('assets/icons/notification_outlined.svg', 'Push Notifications', _pushNotifications,
                        (v) => setState(() => _pushNotifications = v)),
                _toggleItem('assets/icons/chat.svg', 'Chat Notifications', _chatNotifications,
                        (v) => setState(() => _chatNotifications = v)),
                _toggleItem('assets/icons/clock.svg', 'Ride Reminders', _rideReminders,
                        (v) => setState(() => _rideReminders = v)),
                _toggleItem('assets/icons/volume.svg', 'Sound & Vibration', _soundVibration,
                        (v) => setState(() => _soundVibration = v)),
              ],
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Appearance
            _buildSection(
              svgIconPath: 'assets/icons/wb_sunny_outlined.svg',
              iconColor: const Color(0xFFE17100),
              title: 'Appearance',
              children: [ _arrowItem ('assets/icons/language.svg', 'Language', 'English')],
            ).animate().fadeIn(delay: 150.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Live Tracking
            _buildSection(
              iconColor: Colors.transparent,
              title: 'Live Tracking',
              titleColor: const Color(0xFF0C0C0C),
              titleBg: const Color(0xFFC8EBE4),
              children: [
                SizedBox(height: 24.h),
                _toggleItem(null, 'Child Pickup / Drop-off',
                    labelColor:const Color(0xFF0C0C0C),
                    _childPickupDropoff,
                        (v) => setState(() => _childPickupDropoff = v)),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Map Preferences
            _buildSection(
              svgIconPath: 'assets/icons/map_outlined.svg',
              iconColor:const Color(0xFF009966),
              title: 'Map Preferences',
              children: [
                _arrowItem('assets/icons/map_outlined.svg', 'Default Map Type', 'Standard'),
                _arrowItem('assets/icons/gps_fixed.svg', 'GPS Accuracy', 'High'),
              ],
            ).animate().fadeIn(delay: 250.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Account
            _buildSection(
              iconColor: Colors.transparent,
              title: 'Account',
              children: [
                _buildLogoutBtn(context),
                SizedBox(height: 8.h),
                _buildDeleteBtn(),
              ],
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    ),
    ],),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildSection({
    String? svgIconPath,
    required Color iconColor,
    required String title,
    required List<Widget> children,
    Color? titleColor,
    Color? titleBg,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow:const [
          // First Shadow
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1.02),
            blurRadius: 2.03,
            spreadRadius: -1.02),
          // Second Shadow
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1.02),
            blurRadius: 3.05,
            spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 12.h),
            decoration: BoxDecoration(
              color: titleBg ?? Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                if (svgIconPath != null && svgIconPath.isNotEmpty) ...[
                  SvgPicture.asset( svgIconPath, width: 22.sp, height: 22.sp,
                    colorFilter: ColorFilter.mode( iconColor, BlendMode.srcIn)),
                  SizedBox(width: 8.13.w),
                ],
                Text( title,
                  style: AppTextStyles.tagline),
              ],
            ),
          ),

          // Section body
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _toggleItem(
      String? svgIconPath,
      String label,
      bool value,
      ValueChanged<bool> onChanged, {
        Color? labelColor,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        children: [
          if (svgIconPath != null && svgIconPath.isNotEmpty) ...[
            SvgPicture.asset( svgIconPath, width: 22.sp, height: 22.sp,
              colorFilter: const ColorFilter.mode( Color(0xFF99A1AF), BlendMode.srcIn)),
            SizedBox(width: 12.w),
          ],
          Expanded(child: Text(label, style: AppTextStyles.display.copyWith(color: labelColor ?? const Color(0xFF101828)))),

          GestureDetector(
            onTap: () {
              onChanged(!value);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44.w,
              height: 22.h,
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: value ? AppColors.primary : const Color(0xFF8A8A8A),
                  width: .5),
                borderRadius: BorderRadius.circular(20.r),
                color: value ? AppColors.primary : Colors.white),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? Colors.white : const Color(0xFFB0B0B0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowItem(String? svgIconPath, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
      child: Row(
        children: [
          if (svgIconPath != null && svgIconPath.isNotEmpty) ...[
            SvgPicture.asset( svgIconPath, width: 22.sp, height: 22.sp,
              colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn)),
            SizedBox(width: 10.w),
          ],
          Expanded(child: Text(label, style: AppTextStyles.display.copyWith(color: const Color(0xFF101828)))),
          Text(value,
              style: AppTextStyles.display.copyWith(color: const Color(0xFF4A5565))),
          SizedBox(width: 5.w),
          Icon(Icons.arrow_forward_ios, size: 20.sp, color:const Color(0xFF99A1AF)),
        ],
      ),
    );
  }


  Widget _buildLogoutBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(AppRoutes.signIn);
      },
      child: Container(
        height: 49.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color:const Color(0xFFBB4D00), size: 22.sp),
            SizedBox(width: 8.w),
            Text('Logout',
                style: AppTextStyles.display.copyWith(color: const Color(0xFFBB4D00),fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteBtn() {
    return GestureDetector(
      onTap: () => _confirmDeleteAccount(),
      child: Container(
        height: 49.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color:const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/delete_account.svg', width: 22.sp, height: 22.sp,
              colorFilter: const ColorFilter.mode( Color(0xFFC10007), BlendMode.srcIn)),
            SizedBox(width: 8.w),
            Text('Delete Account',
                style: AppTextStyles.display.copyWith(color: const Color(0xFFC10007),fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber, color: Colors.red, size: 40.sp),
              SizedBox(height: 12.h),
              Text('Delete Account', style: AppTextStyles.large),
              SizedBox(height: 8.h),
              Text('Are you sure you want to delete your account? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: AppTextStyles.medium),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.withValues(alpha: 0.4)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel', style: AppTextStyles.medium))),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                      onPressed: () {
                        context.pop();
                        context.go(AppRoutes.welcome);
                      },
                      child: Text('Delete',
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.white)),
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