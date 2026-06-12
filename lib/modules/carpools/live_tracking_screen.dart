import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_bottom_nav.dart';

class LiveTrackingScreen extends StatefulWidget {
  final Map<String, dynamic> carpool;

  const LiveTrackingScreen({super.key, required this.carpool});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  // 0=started, 1=picking sarah, 2=picking ahmed, 3=heading school, 4=reached
  int _currentStep = 1;

  final List<Map<String, dynamic>> _steps = [
    {'label': 'Driver started trip', 'time': '8:00 AM'},
    {'label': 'Picking up Sarah', 'time': '8:05 AM'},
    {'label': 'Picking up Ahmed', 'time': null},
    {'label': 'Heading to school', 'time': null},
    {'label': 'Reached destination', 'time': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
      body: Column(
        children: [
          // ── Top map section ──
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                // Map background
                _buildMapPlaceholder(),

                // Back button
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6)
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 16.sp, color: const Color(0xFF0C0C0C)),
                      ),
                    ),
                  ),
                ),

                // Title
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Center(
                      child: Text('Live Tracking',
                          style: AppTextStyles.large
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),

                // LIVE badge
                Positioned(
                  top: 100.h,
                  left: 16.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        SizedBox(width: 4.w),
                        Text('LIVE',
                            style: AppTextStyles.medium.copyWith(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                // Estimated arrival card
                Positioned(
                  top: 94.h,
                  right: 16.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('Estimated Arrival',
                            style: AppTextStyles.medium.copyWith(
                                color: Colors.grey, fontSize: 10.sp)),
                        Text('12 min',
                            style: AppTextStyles.large.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 18.sp)),
                      ],
                    ),
                  ),
                ),

                // Driver info card
                Positioned(
                  top: 150.h,
                  left: 16.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8)
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          child: Icon(Icons.person,
                              color: AppColors.primary, size: 16.sp),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ahmed Rahman',
                                style: AppTextStyles.title
                                    .copyWith(fontSize: 13.sp)),
                            Text('On the way',
                                style: AppTextStyles.medium.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 11.sp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Car icon on map
                Positioned(
                  top: 180.h,
                  left: 160.w,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6)
                      ],
                    ),
                    child: Icon(Icons.directions_car,
                        color: AppColors.primary, size: 20.sp),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom panel ──
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -3))
                ],
              ),
              child: Column(
                children: [
                  // Handle
                  Container(
                    width: 36.w,
                    height: 4.h,
                    margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  // Trip Progress title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Trip Progress',
                          style: AppTextStyles.large
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Timeline
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _steps.length,
                      itemBuilder: (_, i) => _buildTimelineItem(i),
                    ),
                  ),

                  // Action buttons
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    child: Row(
                      children: [
                        _actionButton(Icons.call_outlined, 'Call',
                            AppColors.primary.withOpacity(0.08), AppColors.primary),
                        SizedBox(width: 12.w),
                        _actionButton(Icons.chat_bubble_outline, 'Message',
                            AppColors.primary.withOpacity(0.08), AppColors.primary),
                        SizedBox(width: 12.w),
                        _actionButton(Icons.share_outlined, 'Share',
                            Colors.purple.withOpacity(0.08), Colors.purple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(int index) {
    final step = _steps[index];
    final isDone = index <= _currentStep;
    final isLast = index == _steps.length - 1;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line
          SizedBox(
            width: 24.w,
            child: Column(
              children: [
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDone ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color:
                      isDone ? AppColors.primary : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: isDone
                      ? Icon(Icons.check, size: 10.sp, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isDone && index < _currentStep
                          ? AppColors.primary.withOpacity(0.4)
                          : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Label + time
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['label'],
                    style: AppTextStyles.title.copyWith(
                      color: isDone
                          ? const Color(0xFF0C0C0C)
                          : Colors.grey.shade400,
                      fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  if (step['time'] != null) ...[
                    SizedBox(height: 2.h),
                    Text(step['time'],
                        style: AppTextStyles.medium
                            .copyWith(color: Colors.grey, fontSize: 12.sp)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      IconData icon, String label, Color bgColor, Color iconColor) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 22.sp),
              SizedBox(height: 4.h),
              Text(label,
                  style:
                  AppTextStyles.medium.copyWith(color: iconColor, fontSize: 12.sp)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      color: const Color(0xFFE8F0E9),
      child: CustomPaint(
        painter: _MapGridPainter(),
        child: Stack(
          children: [
            Positioned(
              top: 260.0,
              left: 90.0,
              child: _dot(AppColors.primary),
            ),
            Positioned(
              bottom: 60.0,
              right: 80.0,
              child: _dot(Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(Color color) => Container(
    width: 14,
    height: 14,
    decoration:
    BoxDecoration(color: color, shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2)),
  );
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final thinPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (double y = 60; y < size.height; y += 80) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), roadPaint);
    }
    for (double x = 60; x < size.width; x += 90) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), roadPaint);
    }
    canvas.drawLine(
        Offset(0, size.height * 0.2), Offset(size.width, size.height * 0.7), thinPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.8), Offset(size.width * 0.9, size.height * 0.1), thinPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}