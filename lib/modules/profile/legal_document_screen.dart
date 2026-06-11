import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_bottom_nav.dart';

class LegalDocumentScreen extends StatelessWidget {
  final String title;
  const LegalDocumentScreen({super.key, required this.title});

  static const Map<String, List<Map<String, String>>> _content = {
    'Terms of Service': [
      {
        'heading': '1. Types of Data We Collect',
        'body':'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      },
      {
        'heading': '2. Use of Your Personal Data',
        'body':'Magna etiam tempor orci eu lobortis elementum nibh. Vulputate enim nulla aliquet porttitor lacus. Orci sagittis eu volutpat odio. Cras semper auctor neque vitae tempus quam pellentesque nec. Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Commodo elit at imperdiet dui. Nisi vitae suscipit tellus mauris a diam. Erat pellentesque adipiscing commodo elit at imperdiet dui. Mi ipsum faucibus vitae aliquet nec ullamcorper. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et.'
      },
      {
        'heading': '3. Disclosure of Your Personal Data',
        'body':'Consequat id porta nibh venenatis cras sed. Ipsum nunc aliquet bibendum enim facilisis gravida neque. Nibh tellus molestie nunc non blandit massa. Quam pellentesque nec nam aliquam sem et tortor consequat id. Faucibus vitae aliquet nec ullamcorper sit amet risus. Nunc consequat interdum varius sit amet. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pulvinar pellentesque habitant morbi tristique senectus et. Lorem donec massa sapien faucibus et molestie. Massa tempor nec feugiat nisl pretium fusce id. Lacinia at quis risus sed vulputate odio. Integer vitae justo eget magna fermentum iaculis. Eget gravida cum sociis natoque penatibus et magnis.'
      },
    ],
    'Privacy Policy': [
      {
        'heading': '1. Types of Data We Collect',
        'body':'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      },
      {
        'heading': '2. Use of Your Personal Data',
        'body':'Magna etiam tempor orci eu lobortis elementum nibh. Vulputate enim nulla aliquet porttitor lacus. Orci sagittis eu volutpat odio. Cras semper auctor neque vitae tempus quam pellentesque nec. Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Commodo elit at imperdiet dui. Nisi vitae suscipit tellus mauris a diam. Erat pellentesque adipiscing commodo elit at imperdiet dui. Mi ipsum faucibus vitae aliquet nec ullamcorper. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et.'
      },
      {
        'heading': '3. Disclosure of Your Personal Data',
        'body':'Consequat id porta nibh venenatis cras sed. Ipsum nunc aliquet bibendum enim facilisis gravida neque. Nibh tellus molestie nunc non blandit massa. Quam pellentesque nec nam aliquam sem et tortor consequat id. Faucibus vitae aliquet nec ullamcorper sit amet risus. Nunc consequat interdum varius sit amet. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pulvinar pellentesque habitant morbi tristique senectus et. Lorem donec massa sapien faucibus et molestie. Massa tempor nec feugiat nisl pretium fusce id. Lacinia at quis risus sed vulputate odio. Integer vitae justo eget magna fermentum iaculis. Eget gravida cum sociis natoque penatibus et magnis.'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    if (title == 'Community Guidelines') {
      return const _CommunityGuidelinesScreen();
    }

    final sections = _content[title] ?? _content['Terms of Service']!;

    return Scaffold(
      backgroundColor:const Color(0xFFF9FAFB),
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
        title: Text(title, style: AppTextStyles.heading),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.33.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sections.asMap().entries.map((e) {
            final section = e.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( section['heading']!,
                    style: AppTextStyles.title.copyWith(color:const Color(0xFF212121)),
                  ).animate().fadeIn(delay: (e.key * 100).ms, duration: 400.ms),
                  SizedBox(height: 16.h),
                  Text( section['body']!,
                    style: AppTextStyles.hintText.copyWith(color: const Color(0xFF424242)),
                  ).animate().fadeIn( delay: (e.key * 100 + 50).ms, duration: 400.ms),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }
}

// ─── Community Guidelines Screen ────────────────────────────────
class _CommunityGuidelinesScreen extends StatelessWidget {
  const _CommunityGuidelinesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF9FAFB),
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
                      child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF364153))))),
          title: Row(
            children: [
              SvgPicture.asset('assets/icons/carpool_outlined.svg', width: 24.sp, height: 24.sp,
                colorFilter: const ColorFilter.mode(Color(0xFF66B2A3), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Community Guidelines', style: AppTextStyles.heading),
            ],
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2A8D79),
                borderRadius: BorderRadius.circular(16.26.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to Our\nCommunity!',
                      style: AppTextStyles.heading.copyWith(color: Colors.white)),
                  SizedBox(height: 10.61.h),
                  Text('Our carpool community is built on trust, respect, and safety. These guidelines help create a positive experience for all parents and children.',
                    style: AppTextStyles.label),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            SizedBox(height: 24.38.h),

            // Be Respectful
            _guidelineCard(
              svgPath: 'assets/icons/favorite_outlined.svg',
              iconColor: AppColors.primary,
              bgColor: const Color(0xFFDBEAFE),
              title: 'Be Respectful',
              points: [
                'Treat all community members with kindness and respect',
                'Use polite language in all communications',
                'Be understanding of different parenting styles',
                'Respect others` time and commitments'
              ],
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

            SizedBox(height: 10.h),

            // Prioritize Safety
            _guidelineCard(
              svgPath: 'assets/icons/shield_outlined.svg',
              iconColor: const Color(0xFF009966),
              bgColor:const Color(0xFFD0FAE5),
              title: 'Prioritize Safety',
              points: [
                'Always verify driver credentials before carpooling',
                'Ensure vehicles are safe and properly maintained',
                'Use proper car seats and seat belts for all children',
                'Follow all traffic laws and speed limits',
                'Never use phone while driving (except hands-free)',
              ],
            ).animate().fadeIn(delay: 150.ms, duration: 300.ms),

            SizedBox(height: 10.h),

            // Be Reliable
            _guidelineCard(
              svgPath: 'assets/icons/carpool_outlined.svg',
              iconColor:const Color(0xFF9810FA),
              bgColor:const Color(0xFFF3E8FF),
              title: 'Be Reliable',
              points: [
                'Arrive on time for pickups and drop-offs',
                'Notify others immediately if you`re running late',
                'Cancel in advance if you cannot make it',
                'Honor your commitments to drive when scheduled',
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

            SizedBox(height: 10.h),

            // Prohibited Behavior
            _guidelineCard(
              svgPath: 'assets/icons/block.svg',
              iconColor: const Color(0xFFE7000B),
              bgColor: const Color(0xFFFFE2E2),
              borderColor: const Color(0xFFFFC9C9),
              isCrossMarker: true,
              title: 'Prohibited Behavior',
              points: [
                'Harassment, bullying, or threatening behavior',
                'Discrimination based on race, religion, gender, etc.',
                'Sharing false or misleading information',
                'Driving under the influence of alcohol or drugs',
                'Inappropriate behavior around children',
                'Spam, scams, or commercial solicitation',
              ],
            ).animate().fadeIn(delay: 250.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Reporting Violations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.33.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.23.r),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 1.02),
                    blurRadius: 2.03,
                    spreadRadius: -1.02),
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
                  Text('Reporting Violations', style: AppTextStyles.tagline.copyWith(height: 1.39)),
                  SizedBox(height: 12.h),
                  Text('If you witness behavior that violates these guidelines, please report it immediately through:',
                    style: AppTextStyles.school),
                  SizedBox(height: 12.19.h),
                  _reportBtn('Report a User',const Color(0xFFFEF2F2),const Color(0xFFC10007)),
                  SizedBox(height: 8.h),
                  _reportBtn('Report Abuse', const Color(0xFFFFFBEB),const Color(0xFFBB4D00)),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

            SizedBox(height: 24.h),

            // Consequences
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.33.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.23.r),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 1.02),
                      blurRadius: 2.03,
                      spreadRadius: -1.02),
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
                  Text('Consequences', style: AppTextStyles.tagline.copyWith(height: 1.39)),
                  SizedBox(height: 12.h),
                  Text('Violations of these guidelines may result in warnings, temporary suspension, or permanent account termination depending on severity. We take all reports seriously and investigate thoroughly.',
                      style: AppTextStyles.school),
                ],
              ),
            ).animate().fadeIn(delay: 350.ms, duration: 300.ms),

            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _guidelineCard({
    required String svgPath,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required List<String> points,
    Color borderColor = const Color(0xFFFFFFFF),
    bool isCrossMarker = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white, //  white background
        borderRadius: BorderRadius.circular(14.23.r),
        border: Border.all(color: borderColor, width: 1.24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 1.02),
            blurRadius: 2.03,
            spreadRadius: -1.02),
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
          Row(
            children: [
              //  Icon circle background
              Container( width: 48.w,  height: 48.w,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    svgPath, width: 24.w, height: 24.w,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)))),
              SizedBox(width: 12.w),
              Text(title,
                  style: AppTextStyles.tagline.copyWith(height: 1.39)),
            ],
          ),
          SizedBox(height: 12.h),
          ...points.map((p) => Padding(
            padding: EdgeInsets.only(left: 57.3.w, bottom:8.13.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 18.w,
                    alignment: Alignment.center,
                  child: isCrossMarker
                      ? Text('×', style: AppTextStyles.school.copyWith(color: iconColor))
                      : Container(width: 6.w, height: 6.w, decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle))),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(p,
                      style: AppTextStyles.school),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _reportBtn(String label, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.23.r)),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          backgroundColor: bgColor),
        onPressed: () {},
        child: Text(
          label,
          style: AppTextStyles.display.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}