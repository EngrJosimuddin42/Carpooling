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
            _buildHeader(context),
            _buildStats(),
            _buildPremiumBanner(context),
            SizedBox(height: 16.h),
            _buildMyChildren(context),
            SizedBox(height: 8.h),
            _buildSection('Account', [
              _menuItem(Icons.person_outline, 'Edit Profile',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()))),

              _menuItem(Icons.contacts_outlined, 'My Contact List',
                  onTap: () =>  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ContactListScreen()))),

              _menuItem(Icons.child_care, 'Manage Children',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ManageChildrenScreen(
                        initialChildren: AppData().children,
                      )))),

              _menuItem(Icons.verified_outlined, 'Verification Status', trailing: _verifiedBadge()),
            ]),
            SizedBox(height: 8.h),
            _buildSection('Preferences', [
              _menuItem( Icons.notifications_outlined, 'Notifications',
                trailing: _toggle(
                  _isNotificationOn,
                      (newValue) {
                    setState(() {
                      _isNotificationOn = newValue;
                    });
                  },
                ),
              ),
              _menuItem(Icons.settings_outlined, 'App Settings',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AppSettingsScreen()))),
              _menuItem(Icons.lock_outline, 'Password Change',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()))),
            ]),
            SizedBox(height: 8.h),
            _buildSection('Community', [
              _menuItem(Icons.star_outline, 'Reviews & Ratings',
                  trailing: _ratingBadge(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ReviewsRatingsScreen()))),
              _menuItem(Icons.subscriptions_outlined, 'Subscriptions',
                  trailing: _upgradeBadge(context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()))),
            ]),
            SizedBox(height: 8.h),
            _buildSection('Support', [
              _menuItem(Icons.help_outline, 'Help & Support',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HelpSupportScreen()))),
            ]),
            SizedBox(height: 16.h),
            _buildLogout(context),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      bottomNavigationBar:const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 50.h, bottom: 20.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Icon(Icons.person, size: 32.sp, color: Colors.white),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.edit, size: 12.sp, color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: AppTextStyles.large.copyWith(color: Colors.white)),
              Text('john.doe@email.com', style: AppTextStyles.medium.copyWith(color: Colors.white70)),
              Text('Greenfield International School', style: AppTextStyles.medium.copyWith(color: Colors.white60)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildStats() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('24', 'Total Rides'),
          _vDivider(),
          _statItem('4.8', 'Rating'),
          _vDivider(),
          _statItem('2', 'Children'),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTextStyles.large.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
        Text(label, style: AppTextStyles.medium.copyWith(color: Colors.grey)),
      ],
    );
  }

  Widget _vDivider() => Container(width: 1, height: 36.h, color: Colors.grey.withOpacity(0.2));

  Widget _buildPremiumBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.amber.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.workspace_premium, color: Colors.amber, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(child: Text('Premium Membership', style: AppTextStyles.title)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20.r)),
              child: Text('Upgrade', style: AppTextStyles.medium.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyChildren(BuildContext context) {
    final children = [
      {'name': 'Emma Johnson', 'age': 'Age 8 • Grade 3rd'},
      {'name': 'Liam Johnson', 'age': 'Age 6 • Grade 1st'},
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Children', style: AppTextStyles.title),
              Text('Manage', style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 12.h),
          ...children.map((c) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(Icons.child_care, color: AppColors.primary, size: 18.sp),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['name']!, style: AppTextStyles.title),
                    Text(c['age']!, style: AppTextStyles.medium.copyWith(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          )),
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
            child: Text(title, style: AppTextStyles.title.copyWith(color: Colors.grey)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, {Widget? trailing, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 20.sp),
            SizedBox(width: 14.w),
            Expanded(child: Text(label, style: AppTextStyles.medium)),
            trailing ?? Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _verifiedBadge() => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
    child: Text('Verified', style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
  );

  Widget _toggle(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
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
            width: .5,
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: value ? AppColors.primary : Colors.white,
        ),
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
    );
  }

  Widget _ratingBadge() => Row(
    children: [
      Icon(Icons.star, color: Colors.amber, size: 14.sp),
      SizedBox(width: 4.w),
      Text('4.8', style: AppTextStyles.medium),
      SizedBox(width: 6.w),
      Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
    ],
  );

  Widget _upgradeBadge(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20.r)),
    child: Text('Upgrade', style: AppTextStyles.medium.copyWith(color: Colors.white)),
  );

  Widget _buildLogout(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.red, size: 18.sp),
          SizedBox(width: 8.w),
          Text('Logout', style: AppTextStyles.medium.copyWith(color: Colors.red)),
        ],
      ),
    );
  }
}