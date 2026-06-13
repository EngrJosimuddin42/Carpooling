import 'dart:io';

import 'package:carpooling/modules/profile/reviews_ratings_screen.dart';
import 'package:carpooling/modules/profile/subscription_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../data/app_data.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bottom_nav.dart';
import '../carpools/contact_list_screen.dart';
import 'app_settings_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'help_support_screen.dart';
import 'manage_children/manage_children_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── One gradient card (header + stats + premium) ──
            _buildTopCard(context),

            SizedBox(height: 24.h),

            // ── Body sections ──
            _buildMyChildren(context),
            SizedBox(height: 24.h),
            _buildSection('Account', [
              _menuItem('assets/icons/person_outline.svg', 'Edit Profile',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
              _menuItem('assets/icons/contact_outlined.svg', 'My Contact List',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ContactListScreen()))),
              _menuItem('assets/icons/carpool_outlined.svg','Manage Children',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => ManageChildrenScreen(
                            initialChildren: AppData().children,
                          )))),
              _menuItem('assets/icons/shield_outlined.svg', 'Verification Status',
                  trailing: _verifiedBadge()),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Preferences', [
              _menuItem( 'assets/icons/notification_outlined.svg', 'Notifications',
                trailing: _toggle( _isNotificationOn,
                      (v) => setState(() => _isNotificationOn = v))),
              _menuItem('assets/icons/setting_outlined.svg', 'App Settings',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AppSettingsScreen()))),
              _menuItem('assets/icons/lock.svg', 'Password Change',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()))),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Community', [
              _menuItem('assets/icons/star_border.svg', 'Reviews & Ratings',
                  trailing: _ratingBadge(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ReviewsRatingsScreen()))),
              _menuItem('assets/icons/premium.svg', 'Subscriptions',
                  trailing: _upgradeBadge(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SubscriptionScreen()))),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Support', [
              _menuItem('assets/icons/help_outline.svg', 'Help & Support',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HelpSupportScreen()))),
            ]),
            SizedBox(height: 20.h),
            _buildLogout(context),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  // TOP GRADIENT CARD  (header + stats + premium banner)

  Widget _buildTopCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 48.h,
        left: 24.w,
        right: 24.w,
        bottom: 24.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [ Color(0xFF66B2A3), Color(0xFF2A8D79),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r)),
        boxShadow:AppColors.shadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileRow(),
          SizedBox(height: 24.h),
          _buildStatsRow(),
          SizedBox(height: 24.h),
          _buildPremiumBanner(context),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  // ── Profile row (avatar + name + email + verified badge) ──────────────────

  Widget _buildProfileRow() {
    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: AppData().userProfile,
      builder: (context, profile, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: const Color(0x3366B2A3),
                  backgroundImage: profile['avatar']!.isNotEmpty
                      ? (profile['avatar']!.startsWith('assets/')
                      ? AssetImage(profile['avatar']!) as ImageProvider
                      : FileImage(File(profile['avatar']!)))
                      : null,
                  child: profile['avatar']!.isEmpty
                      ? SvgPicture.asset('assets/icons/person_outline.svg',
                      width: 40.w, height: 40.w,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))
                      : null),
                Positioned(
                  top: 52.h, left: 52.w,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                    child: Container(
                        width: 28.w, height: 28.w,
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.2.w)),
                        child: SvgPicture.asset('assets/icons/edit_outlined.svg',
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile['name']!,
                      style: AppTextStyles.heading.copyWith(color: Colors.white)),
                  SizedBox(height: 4.h),
                  Text(profile['phone']!,
                      style: AppTextStyles.dropHitText.copyWith(color: Colors.white)),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFF6BB2A4),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/shield_outlined.svg',
                            width: 16.sp, height: 16.sp,
                            colorFilter: const ColorFilter.mode(Color(0xFF5EE9B5), BlendMode.srcIn)),
                        SizedBox(width: 4.w),
                        Text('Verified Parent',
                            style: AppTextStyles.mark.copyWith(color: const Color(0xFF5EE9B5))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Stats row (3 frosted-glass cards) ─────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statCard('24', 'Total Rides'),
        SizedBox(width: 12.w),
        _statCard('4.8', 'Rating'),
        SizedBox(width: 12.w),
        _statCard('2', 'Children'),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color:const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(14.r)),
        child: Column(
          children: [
            Text(value,
              style: AppTextStyles.heading.copyWith(color: Colors.white)),
            SizedBox(height: 2.h),
            Text(label,
              style: AppTextStyles.time.copyWith(
                color:const Color(0xFFDBEAFE))),
          ],
        ),
      ),
    );
  }

  // ── Premium banner (inside the card) ──────────────────────────────────────

  Widget _buildPremiumBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(16.r)),
        child: Row(
          children: [
            // Crown icon in a circle
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(10.w),
              decoration:const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle),
              child: SvgPicture.asset('assets/icons/premium.svg', width: 19.sp, height: 19.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn))),
            SizedBox(width: 16.w),
            Expanded(
              child: Text('Premium Membership',
                style: AppTextStyles.cs.copyWith(color: Colors.white, fontWeight: FontWeight.w700))),
            // Upgrade pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C6),
                borderRadius: BorderRadius.circular(20.r)),
              child: Text('Upgrade',
                style: AppTextStyles.status.copyWith(color: const Color(0xFFBB4D00)))),
          ],
        ),
      ),
    );
  }

  // BODY SECTIONS
  Widget _buildMyChildren(BuildContext context) {
    final children = [
      {'name': 'Emma Johnson', 'grade': 'Grade 3rd'},
      {'name': 'Liam Johnson', 'grade': 'Grade 1st'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Children',
                    style: AppTextStyles.name),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManageChildrenScreen(
                        initialChildren: AppData().children,
                      ),
                    ),
                  ),
                  child: Text('Manage',
                      style: AppTextStyles.mark.copyWith(color: AppColors.primary))),
              ],
            ),
          ),

          // ── child card ──
          Column(
            children: [
              for (int i = 0; i < children.length; i++)
                Container(
                  margin: EdgeInsets.only(bottom: i < children.length - 1 ? 10.h : 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withValues(alpha: 0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor:const Color(0x336DB3A5),
                          child: SvgPicture.asset('assets/icons/person_outline.svg', width: 24.sp, height: 24.sp,
                              colorFilter: const ColorFilter.mode(Color(0xFF66B2A3), BlendMode.srcIn))),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(children[i]['name']!, style: AppTextStyles.name.copyWith(height: 1.5)),
                            SizedBox(height: 1.h),
                            Text(children[i]['grade']!,
                                style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(title,
                style: AppTextStyles.name)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: AppColors.softCardShadow),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i < items.length - 1)
                    Divider(color: Colors.grey.shade300, height: 2, thickness: 1),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String svgIcon, String label,
      {Widget? trailing, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration:const BoxDecoration(
                color: Color(0xFFF3F4F6),
                shape: BoxShape.circle),
              child: SvgPicture.asset(svgIcon,height: 20.sp, width: 20.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn))),
            SizedBox(width: 16.w),
            Expanded(child: Text(label, style: AppTextStyles.display.copyWith(color: const Color(0xFF101828)))),
            trailing ??
                Icon(Icons.arrow_forward_ios, size: 20.sp, color: const Color(0xFF99A1AF)),
          ],
        ),
      ),
    );
  }

  // ─── Trailing helpers ─────────────────────────────────────────────────────

  Widget _verifiedBadge() => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: const Color(0xFFD0FAE5),
      borderRadius: BorderRadius.circular(20.r)),
    child: Text('Verified',
        style: AppTextStyles.status.copyWith(color: AppColors.primary)),
  );


  Widget _toggle(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44.w,
        height: 24.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: value ? AppColors.primary : const Color(0xFF8A8A8A),
            width: .5,
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: value ? AppColors.primary : Colors.white,
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 17.w,
          height: 17.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? Colors.white : const Color(0xFFB0B0B0),
          ),
        ),
      ),
    );
  }

  Widget _ratingBadge() => Row(
    children: [
      SvgPicture.asset('assets/icons/star_filled.svg', width: 16.sp, height: 16.sp,
          colorFilter: const ColorFilter.mode(Color(0xFFFE9A00), BlendMode.srcIn)),
      SizedBox(width: 4.w),
      Text('4.8', style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
      SizedBox(width: 12.w),
      Icon(Icons.arrow_forward_ios, size: 20.sp, color:const Color(0xFF99A1AF)),
    ],
  );

  Widget _upgradeBadge() => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
    decoration: BoxDecoration(
      color:const Color(0xFFFEF3C6),
      borderRadius: BorderRadius.circular(20.r)),
    child: Text('Upgrade',
        style: AppTextStyles.status.copyWith(color:const Color(0xFFBB4D00))),
  );

  // ─── Logout ───────────────────────────────────────────────────────────────

  Widget _buildLogout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(AppRoutes.signIn);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/logout.svg', width: 20.sp, height: 20.sp,
                colorFilter: const ColorFilter.mode(Color(0xFFFE9A00), BlendMode.srcIn)),
            SizedBox(width: 7.w),
            Text('Logout',
                style: AppTextStyles.cs.copyWith(color:const Color(0xFFE7000B))),
          ],
        ),
      ),
    );
  }
}