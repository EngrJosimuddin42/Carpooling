import 'package:carpooling/modules/carpools/trip_in_progress_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_buttons.dart';

class ReadyToStartScreen extends StatelessWidget {
  final Map<String, dynamic> carpool;
  const ReadyToStartScreen({super.key, required this.carpool});

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
          title: Text('Ready to Start', style: AppTextStyles.heading),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(
                  color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.38.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Carpool header card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.38.w),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF155DFC), Color(0xFF9810FA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(16.26.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carpool['title'],
                      style: AppTextStyles.heading.copyWith(
                          color: Colors.white)),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/clock.svg',
                          width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFDBEAFE), BlendMode.srcIn)),
                      SizedBox(width: 8.w),
                      Text(carpool['date'] ?? 'Date & Time TBD',
                          style: AppTextStyles.medium.copyWith(
                              color: const Color(0xFFDBEAFE))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // ── Route ──
            _buildRoute(context),
            SizedBox(height: 20.h),

            // ── Children ──
          _buildChildrenList(['Ahmed', 'Sarah', 'Hasan']),
            SizedBox(height: 20.h),

            // ── Before Starting checklist ──
            Container(
              padding: EdgeInsets.all(24.38.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(14.23.r),
                  border: Border.all(color:const Color(0xFFFEE685))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/info_outline.svg', width: 20.sp, height: 20.sp,
                          colorFilter: const ColorFilter.mode( Color(0xFFE17100), BlendMode.srcIn)),
                      SizedBox(width: 8.w),
                      Text('Before Starting',
                          style: AppTextStyles.head.copyWith(color: const Color(0xFF7B3306))),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ...[
                    'Vehicle is ready and safe',
                    'All seat belts are working',
                    'Phone is charged',
                    'Route is planned',
                  ].map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/tick.svg', width: 20.sp, height: 20.sp,
                            colorFilter: const ColorFilter.mode( Color(0xFF973C00), BlendMode.srcIn)),
                        SizedBox(width: 8.w),
                        Text(item, style: AppTextStyles.school.copyWith(color: const Color(0xFF973C00))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // ── Start Trip button ──
            PrimaryButton(
              text: 'Start Trip',
              icon: SvgPicture.asset('assets/icons/arrow_send.svg', width: 24.sp, height: 24.sp,
                  colorFilter: const ColorFilter.mode( Colors.white, BlendMode.srcIn)),
              onPressed: () => _showStartTripDialog(context),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showStartTripDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 32.r,
                  backgroundColor: const Color(0xFFD0FAE5),
                  child: SvgPicture.asset('assets/icons/arrow_send.svg', width: 32.sp, height: 32.sp,
                      colorFilter: const ColorFilter.mode( Color(0xFF2A8D79), BlendMode.srcIn))),
              SizedBox(height: 12.h),
              Text('Ready to Start?', style: AppTextStyles.tagline),
              SizedBox(height: 12.h),
              Text('Are you ready to start this carpool trip? All members will be notified and live tracking will begin.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium.copyWith(color:const Color(0xFF4A5565))),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Expanded(
                    child: OutlineButton2(
                      text: 'Cancel',
                      backgroundColor: const Color(0xFFE5E7EB),
                      height: 44.h,
                      textColor: const Color(0xFF364153),
                      onPressed: () => Navigator.pop(context))),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Start Trip',
                      textColor: Colors.white,
                      height: 44.h,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TripInProgressScreen(carpool: carpool),
                          ),
                        );
                      },
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

  Widget _buildRoute(BuildContext context) {
    final pickupAddress = carpool['from'] ?? 'No pickup address';
    final destinationAddress = carpool['to'] ?? 'No destination address';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.32.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.23.r),
          boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Route', style: AppTextStyles.message),
          SizedBox(height: 16.h),

          // Pickup
          Row(
            children: [
              Container(
                  width: 33.w, height: 33.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD0FAE5), shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset('assets/icons/location.svg',
                          width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primary, BlendMode.srcIn)))),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup',
                      style: AppTextStyles.mark.copyWith(
                          color: const Color(0xFF101828))),
                  SizedBox(height: 2.h),
                  Text(pickupAddress,
                      style: AppTextStyles.school.copyWith(
                          color: const Color(0xFF4A5565))),
                ],
              ),
            ],
          ),

          // dotted line
          Padding(
            padding: EdgeInsets.only(left: 17.w, top: 4.h, bottom: 4.h),
            child: Column(
              children: List.generate(10, (i) => Container(
                width: 2, height: 5.h,
                margin: EdgeInsets.only(bottom: 3.h),
                decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(2)),
              )),
            ),
          ),

          // Destination
          Row(
            children: [
              Container(
                  width: 33.w, height: 33.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFE2E2), shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset('assets/icons/location.svg',
                          width: 16.sp, height: 16.sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFE7000B), BlendMode.srcIn)))),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Destination',
                        style: AppTextStyles.mark.copyWith(
                            color: const Color(0xFF101828))),
                    SizedBox(height: 2.h),
                    Text(destinationAddress,
                        style: AppTextStyles.school.copyWith(
                            color: const Color(0xFF4A5565))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChildrenList(List<String> childrenNames) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.38.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.23.r),
        boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/carpool_outlined.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode( Color(0xFF101828), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text('Children (${childrenNames.length})', style: AppTextStyles.name.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 16.h),

          ...childrenNames.map((name) => Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10.16.r)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFDBEAFE),
                  child: Text(name[0],
                      style: AppTextStyles.cs.copyWith(color: AppColors.primary))),
                SizedBox(width: 12.w),
                Text(name, style: AppTextStyles.display.copyWith(color:const Color(0xFF101828))),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(20.r)),
                  child: Text('Waiting',
                      style: AppTextStyles.time.copyWith(color: const Color(0xFF364153))),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}