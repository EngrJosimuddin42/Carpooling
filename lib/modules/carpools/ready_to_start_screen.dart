import 'package:carpooling/modules/carpools/trip_in_progress_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bottom_nav.dart';


class ReadyToStartScreen extends StatelessWidget {
  final Map<String, dynamic> carpool;
  const ReadyToStartScreen({super.key, required this.carpool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Ready to Start', style: AppTextStyles.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carpool header card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carpool['title'],
                      style: AppTextStyles.large.copyWith(color: Colors.white)),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12.sp, color: Colors.white70),
                      SizedBox(width: 4.w),
                      Text('May 14, 2026 • 7:30 AM',
                          style: AppTextStyles.medium.copyWith(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Route
            Text('Route', style: AppTextStyles.title),
            SizedBox(height: 12.h),
            _routeItem(Icons.circle, AppColors.primary, 'Pickup', '123 Main Street, Cityville'),
            Container(
              margin: EdgeInsets.only(left: 11.w),
              width: 2, height: 20.h,
              color: Colors.grey.withOpacity(0.3),
            ),
            _routeItem(Icons.location_on, Colors.red, 'Destination', 'Lincoln Elementary School'),
            SizedBox(height: 20.h),

            // Children
            Text('Children (3)', style: AppTextStyles.title),
            SizedBox(height: 12.h),
            ...['Ahmed', 'Sarah', 'Hasan'].map((name) => Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    child: Text(name[0],
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.primary)),
                  ),
                  SizedBox(width: 12.w),
                  Text(name, style: AppTextStyles.title),
                  const Spacer(),
                  Text('Not Yet',
                      style: AppTextStyles.medium.copyWith(color: Colors.grey)),
                ],
              ),
            )),
            SizedBox(height: 20.h),

            // Before Starting checklist
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.orange.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 18.sp),
                      SizedBox(width: 6.w),
                      Text('Before Starting',
                          style: AppTextStyles.title.copyWith(color: Colors.orange)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ...['Vehicle is ready and safe', 'All seat belts are working',
                    'Phone is charged', 'Route is planned']
                      .map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.orange, size: 14.sp),
                        SizedBox(width: 8.w),
                        Text(item, style: AppTextStyles.medium),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Start Trip Dialog trigger
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                icon: Icon(Icons.play_arrow, color: Colors.white, size: 20.sp),
                label: Text('Start Trip',
                    style: AppTextStyles.medium.copyWith(color: Colors.white)),
                onPressed: () => _showStartTripDialog(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  void _showStartTripDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_circle_outline, color: AppColors.primary, size: 48.sp),
              SizedBox(height: 12.h),
              Text('Ready to Start?', style: AppTextStyles.large),
              SizedBox(height: 8.h),
              Text(
                'Are you ready to start this carpool trip? All members will be notified and live tracking will begin.',
                textAlign: TextAlign.center,
                style: AppTextStyles.medium,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel', style: AppTextStyles.medium),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TripInProgressScreen(carpool: carpool)),
                        );
                      },
                      child: Text('Start Trip',
                          style: AppTextStyles.medium.copyWith(color: Colors.white)),
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

  Widget _routeItem(IconData icon, Color color, String label, String address) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            Text(address, style: AppTextStyles.title),
          ],
        ),
      ],
    );
  }
}