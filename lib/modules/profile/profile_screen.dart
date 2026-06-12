import 'package:carpooling/modules/profile/reviews_ratings_screen.dart';
import 'package:carpooling/modules/profile/subscription_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/app_data.dart';
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
            // ── One big gradient card (header + stats + premium) ──
            _buildTopCard(context),

            SizedBox(height: 20.h),

            // ── Body sections ──
            _buildMyChildren(context),
            SizedBox(height: 12.h),
            _buildSection('Account', [
              _menuItem(Icons.person_outline, 'Edit Profile',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
              _menuItem(Icons.contacts_outlined, 'My Contact List',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ContactListScreen()))),
              _menuItem(Icons.child_care, 'Manage Children',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => ManageChildrenScreen(
                            initialChildren: AppData().children,
                          )))),
              _menuItem(Icons.verified_outlined, 'Verification Status',
                  trailing: _verifiedBadge()),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Preferences', [
              _menuItem(
                Icons.notifications_outlined,
                'Notifications',
                trailing: _toggle(
                  _isNotificationOn,
                      (v) => setState(() => _isNotificationOn = v),
                ),
              ),
              _menuItem(Icons.settings_outlined, 'App Settings',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AppSettingsScreen()))),
              _menuItem(Icons.lock_outline, 'Password Change',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()))),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Community', [
              _menuItem(Icons.star_outline, 'Reviews & Ratings',
                  trailing: _ratingBadge(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ReviewsRatingsScreen()))),
              _menuItem(Icons.subscriptions_outlined, 'Subscriptions',
                  trailing: _upgradeBadge(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SubscriptionScreen()))),
            ]),
            SizedBox(height: 12.h),
            _buildSection('Support', [
              _menuItem(Icons.help_outline, 'Help & Support',
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

  // ═══════════════════════════════════════════════════════════════════════════
  // TOP GRADIENT CARD  (header + stats + premium banner)
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTopCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 48.h,
        left: 24.w,
        right: 24.w,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          colors: [
            Color(0xFF66B2A3), // 135deg start
            Color(0xFF2A8D79), // 135deg end
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        boxShadow:AppColors.shadow
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileRow(),
          SizedBox(height: 24.h),
          _buildStatsRow(),
          SizedBox(height: 16.h),
          _buildPremiumBanner(context),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  // ── Profile row (avatar + name + email + verified badge) ──────────────────

  Widget _buildProfileRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 2.w),
                image: const DecorationImage(
                  // Replace with real asset/network image
                  image: AssetImage('assets/images/avatar_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Edit button
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 26.w,
                  height: 26.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5.w),
                  ),
                  child: Icon(Icons.edit, size: 12.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),
        // Name + email + badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: AppTextStyles.large.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'john.doe@email.com',
                style: AppTextStyles.medium.copyWith(
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              SizedBox(height: 8.h),
              // Verified badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_outlined,
                        size: 13.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      'Verified Parent',
                      style: AppTextStyles.medium.copyWith(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.large.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.medium.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11.sp,
              ),
            ),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            // Crown icon in a circle
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.workspace_premium,
                  color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Premium Membership',
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Upgrade pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFABF3B),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Upgrade',
                style: AppTextStyles.medium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BODY SECTIONS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildMyChildren(BuildContext context) {
    final children = [
      {'name': 'Emma Johnson', 'grade': 'Age 8 • Grade 3rd'},
      {'name': 'Liam Johnson', 'grade': 'Age 6 • Grade 1st'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Children', style: AppTextStyles.title),
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
                    style:
                    AppTextStyles.medium.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...children.map(
                (c) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.child_care,
                        color: AppColors.primary, size: 18.sp),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['name']!, style: AppTextStyles.title),
                      Text(c['grade']!,
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(title,
                style:
                AppTextStyles.title.copyWith(color: Colors.grey.shade600)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04), blurRadius: 6)
              ],
            ),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  items[i],
                  if (i < items.length - 1)
                    Divider(
                        height: 1,
                        indent: 50.w,
                        color: Colors.grey.withOpacity(0.12)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label,
      {Widget? trailing, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade500, size: 20.sp),
            SizedBox(width: 14.w),
            Expanded(child: Text(label, style: AppTextStyles.medium)),
            trailing ??
                Icon(Icons.arrow_forward_ios,
                    size: 14.sp, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // ─── Trailing helpers ─────────────────────────────────────────────────────

  Widget _verifiedBadge() => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text('Verified',
        style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
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
      Icon(Icons.star, color: Colors.amber, size: 14.sp),
      SizedBox(width: 4.w),
      Text('4.8', style: AppTextStyles.medium),
      SizedBox(width: 6.w),
      Icon(Icons.arrow_forward_ios,
          size: 14.sp, color: Colors.grey.shade400),
    ],
  );

  Widget _upgradeBadge() => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text('Upgrade',
        style: AppTextStyles.medium.copyWith(color: Colors.white)),
  );

  // ─── Logout ───────────────────────────────────────────────────────────────

  Widget _buildLogout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: logout logic
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.red.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.red, size: 18.sp),
            SizedBox(width: 8.w),
            Text('Logout',
                style: AppTextStyles.medium.copyWith(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}