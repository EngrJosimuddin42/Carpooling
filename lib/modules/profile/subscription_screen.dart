import 'package:carpooling/modules/profile/payment_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isYearly = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                        color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                    child: Icon(Icons.arrow_back, size: 22.sp,
                        color: const Color(0xFF364153))))),
        title: Text('Subscription', style: AppTextStyles.heading),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppColors.primary,
          unselectedLabelColor: const Color(0xFF707070),
          indicatorColor: AppColors.primary,
          labelStyle: AppTextStyles.display,
          unselectedLabelStyle: AppTextStyles.display,
          tabs: const [
            Tab(text: 'HadiKid No Ads'),
            Tab(text: 'HadiKid Premium'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPlanTab(
            features: [
              'Invitation and approval system',
              'Event creation and participation',
              'Standard messaging',
              'Standard notifications',
              'Ad-free experience',
            ],
            yearlyPrice: '249.99₺ / yıl',
            monthlyPrice: '24.99₺ / ay',
            buttonLabel: 'Upgrade to HadiKid For No Ads'),
          _buildPlanTab(
            features: [
              'HadiKid No Ads',
              'Live tracking',
              'Added notification',
              'Added messaging',
            ],
            yearlyPrice: '799.99₺ / yıl',
            monthlyPrice: '74.99₺ / ay',
            buttonLabel: 'Upgrade to HadiKid Premium',
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildPlanTab({
    required List<String> features,
    required String yearlyPrice,
    required String monthlyPrice,
    required String buttonLabel,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/tick.svg', width: 24.sp, height: 24.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF3B8677), BlendMode.srcIn)),
                SizedBox(width: 12.w),
                Text(f, style: AppTextStyles.social.copyWith(color:const Color(0xFF0C0C0C))),
              ],
            ),
          )),
          SizedBox(height: 20.h),
          Text('Choose between montly or yearly billing and start enjoying your premium features.',
            style: AppTextStyles.social.copyWith(color:const Color(0xFF424242))),
          SizedBox(height: 32.h),
          Row(
            children: [
              // ── Yearly Container ──
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isYearly = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCFCFC),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: _isYearly ? AppColors.primary : const Color(0xFFE0E0E0),
                        width: _isYearly ? 2 : 1,
                      ),
                      boxShadow: _isYearly ? [
                        BoxShadow(
                          color: const Color(0xFF3E9987).withValues(alpha: 0.15),
                          offset: const Offset(2, 4),
                          blurRadius: 20,
                          spreadRadius: 0,
                        )
                      ] : [],
                    ),
                    child: Center(
                      child: Text(yearlyPrice,
                          style: AppTextStyles.social.copyWith(color: const Color(0xFF0C0C0C), fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // ── Monthly Container ──
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isYearly = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCFCFC),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: !_isYearly ? AppColors.primary : const Color(0xFFE0E0E0),
                        width: !_isYearly ? 2 : 1,
                      ),
                      boxShadow: !_isYearly ? [
                        BoxShadow(
                          color: const Color(0xFF3E9987).withValues(alpha: 0.15),
                          offset: const Offset(2, 4),
                          blurRadius: 20,
                          spreadRadius: 0,
                        )
                      ] : [],
                    ),
                    child: Center(
                      child: Text(monthlyPrice,
                          style: AppTextStyles.social.copyWith(color: const Color(0xFF0C0C0C), fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          PrimaryButton(
            text: buttonLabel,
            textColor:const Color(0xFFFCFCFC),
            height: 56.h,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentScreen()),
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: Text("You're currently using HadiKid Free",
                style: AppTextStyles.title.copyWith(color: const Color(0xFF424242)))),
          SizedBox(height: 20.h),
          PrimaryButton(
            text: 'Package Detail Page',
            textColor:const Color(0xFFFCFCFC),
            isUnderlined: true,
            height: 56.h,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}