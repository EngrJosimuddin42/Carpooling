import 'package:carpooling/modules/carpools/widgets/carpool_action_buttons.dart';
import 'package:carpooling/modules/carpools/widgets/map_grid_painter.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LiveTrackingScreen extends StatefulWidget {
  final Map<String, dynamic>? carpool;

  const LiveTrackingScreen({super.key, this.carpool});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  int _currentStep = 1;

  final List<Map<String, dynamic>> _steps = [
    {'label': 'Driver started trip', 'time': '8:00 AM'},
    {'label': 'Picking up Sarah', 'time': '8:05 AM'},
    {'label': 'Picking up Ahmed', 'time': '8:12 AM'},
    {'label': 'Heading to school', 'time': '8:25 AM'},
    {'label': 'Reached destination', 'time': '8:35 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor:const Color(0xFFF9FAFB),
        body: Column(
          children: [
            // ── Top map section ──
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  _buildMapPlaceholder(),

                  // Top Bar
                  Positioned(
                    top: 50.h, left: 16.w, right: 16.w,
                    child: Row(
                      children: [
                        _circleButton(
                          Icons.arrow_back,
                        onTap: () => Navigator.pop(context)),

                        SizedBox(width: 16.w),
                        Text('Live Tracking',
                            style: AppTextStyles.tagline),
                      ],
                    ),
                  ),

                  // LIVE badge
                  Positioned(
                    top: 110.h, left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC0000),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 8.w, height: 8.w,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle)),
                          SizedBox(width: 6.w),
                          Text('LIVE',
                              style: AppTextStyles.action.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),

                  // Estimated arrival card
                  Positioned(
                    top: 110.h, right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric( horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.26.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 16, offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estimated Arrival',
                              style: AppTextStyles.notice.copyWith(
                                  color: const Color(0xFF4A5565))),
                          SizedBox(height: 2.h),
                          Text('12 min',
                              style: AppTextStyles.headlineMedium.copyWith(
                                  color: const Color(0xFF66B2A3))),
                        ],
                      ),
                    ),
                  ),

                  // Driver info card
                  Positioned(
                    top: 170.h, left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric( horizontal: 12.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.26.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 16, offset: const Offset(0, 4))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: (widget.carpool?['driver_avatar'] != null)
                                ? AssetImage(widget.carpool!['driver_avatar'])
                                : const AssetImage('assets/images/avatar.jpg')),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.carpool?['driver'] ?? 'Ahmed Rahman',
                                  style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
                              SizedBox(height: 2.h),
                              Text('On the way',
                                  style: AppTextStyles.textSmall.copyWith(color: const Color(0xFF009966))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Car icon on map
                  Positioned(
                    top: 230.h, left: 180.w,
                    child: Container(
                      width: 48.w, height: 48.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5AB199),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.w),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8, offset: Offset(0, 3))
                        ],
                      ),
                      child: Icon(Icons.directions_car,
                          color: Colors.white, size: 24.sp),
                    ),
                  ),

                  // Green stop dot
                  Positioned(
                    bottom: 75.h, left: 80.w,
                    child: Container(
                      width: 24.w, height: 24.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.w),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4, offset: Offset(0, 2))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom Sheet timeline panel ──
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 24, offset: const Offset(0, -6))
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Trip Progress',
                              style: AppTextStyles.name),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: List.generate(_steps.length, (i) => _buildTimelineItem(i)),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── CarpoolActionButtons ──
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: CarpoolActionButtons(carpool: widget.carpool ?? {}),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(int index) {
    final step = _steps[index];
    final isDone = index <= _currentStep;
    final isLast = index == _steps.length - 1;

    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () => setState(() => _currentStep = index),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( width: 24.w,
              child: Column(
                children: [
                  Container( width: 20.w, height: 20.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? const Color(0xFF0D9488)
                            : Colors.transparent,
                        border: Border.all(
                            color: isDone
                                ? const Color(0xFF0D9488)
                                : const Color(0xFFCBD5E1),
                            width: 2)),
                    child: isDone
                        ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                          width: 2.w,
                          color: isDone && index < _currentStep
                              ? const Color(0xFF0D9488)
                              : const Color(0xFFE2E8F0)),
                    ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step['label'],
                        style: AppTextStyles.social.copyWith(
                            color: isDone
                                ? const Color(0xFF101828)
                                : const Color(0xFF6A7282))),
                    if (isDone && step['time'] != null) ...[
                      SizedBox(height: 4.h),
                      Text(step['time'],
                          style: AppTextStyles.notice),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w, height: 44.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF0F172A)),
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      color: const Color(0xFFF1F5F2),
      child: CustomPaint(
        painter: MapGridPainter(),
        child: Container(),
      ),
    );
  }
}