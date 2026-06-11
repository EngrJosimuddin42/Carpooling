import 'package:carpooling/modules/profile/payment_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Subscription', style: AppTextStyles.title),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          labelStyle: AppTextStyles.medium,
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
            buttonLabel: 'Upgrade to HadiKid For No Ads',
          ),
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
      bottomNavigationBar: _buildBottomNav(),
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
          SizedBox(height: 8.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                Icon(Icons.check, color: AppColors.primary, size: 16.sp),
                SizedBox(width: 10.w),
                Text(f, style: AppTextStyles.medium),
              ],
            ),
          )),
          SizedBox(height: 16.h),
          Text(
            'Choose between montly or yearly billing and start enjoying your premium features.',
            style: AppTextStyles.medium.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isYearly = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: _isYearly ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: _isYearly ? AppColors.primary : const Color(0xFFE0E0E0),
                        width: _isYearly ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(yearlyPrice,
                          style: AppTextStyles.title.copyWith(
                              color: _isYearly ? AppColors.primary : Colors.grey)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isYearly = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: !_isYearly ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: !_isYearly ? AppColors.primary : const Color(0xFFE0E0E0),
                        width: !_isYearly ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(monthlyPrice,
                          style: AppTextStyles.title.copyWith(
                              color: !_isYearly ? AppColors.primary : Colors.grey)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentScreen()),
              ),
              child: Text(buttonLabel,
                  style: AppTextStyles.medium.copyWith(color: Colors.white)),
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: Text("You're currently using HadiKid Free",
                style: AppTextStyles.medium.copyWith(color: Colors.grey)),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {},
              child: Text('Package Detail Page',
                  style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: 4,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Carpools'),
        BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}