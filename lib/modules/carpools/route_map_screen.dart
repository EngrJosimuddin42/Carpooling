import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bottom_nav.dart';
import 'live_tracking_screen.dart';

class RouteMapScreen extends StatelessWidget {
  final Map<String, dynamic> carpool;

  const RouteMapScreen({super.key, required this.carpool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
      body: Stack(
        children: [
          // ── Map placeholder (replace with google_maps_flutter or flutter_map) ──
          _buildMapPlaceholder(),

          // ── Top bar ──
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  _circleButton(
                    Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 12.w),
                  Text('Route Map',
                      style: AppTextStyles.large
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // ── Distance / time card (top right) ──
          Positioned(
            top: 100.h,
            right: 16.w,
            child: Column(
              children: [
                _mapControlButton(Icons.add),
                SizedBox(height: 8.h),
                _mapControlButton(Icons.remove),
                SizedBox(height: 8.h),
                _mapControlButton(Icons.my_location),
              ],
            ),
          ),

          // ── Stats card ──
          Positioned(
            top: 80.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08), blurRadius: 8)
                ],
              ),
              child: Row(
                children: [
                  _statChip('8.5 km', 'Distance'),
                  SizedBox(width: 16.w),
                  _statChip('15 min', 'Travel Time'),
                ],
              ),
            ),
          ),

          // ── Bottom sheet ──
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, -4)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    width: 36.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  // Trip info row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: AppColors.primary.withOpacity(0.12),
                        child:
                        Icon(Icons.person, color: AppColors.primary, size: 22.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              carpool['title'] ?? 'Morning School Run',
                              style: AppTextStyles.title
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(Icons.person_outline,
                                    size: 12.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text('Driver: Ahmed Rahman',
                                    style: AppTextStyles.medium
                                        .copyWith(color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 12.sp, color: AppColors.primary),
                                SizedBox(width: 4.w),
                                Text('Arrives in 15 minutes',
                                    style: AppTextStyles.medium
                                        .copyWith(color: AppColors.primary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Track Live button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r)),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                      ),
                      icon: Icon(Icons.near_me, color: Colors.white, size: 18.sp),
                      label: Text('Track Live',
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.white, fontSize: 15.sp)),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                LiveTrackingScreen(carpool: carpool)),
                      ),
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

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildMapPlaceholder() {
    return Container(
      color: const Color(0xFFE8F0E9),
      child: CustomPaint(
        painter: _MapGridPainter(),
        child: Stack(
          children: [
            // Pickup marker
            Positioned(
              top: 220.0,
              left: 80.0,
              child: _mapMarker(AppColors.primary, 'Pickup'),
            ),
            // Destination marker
            Positioned(
              bottom: 240.0,
              right: 100.0,
              child: _mapMarker(Colors.red, 'Destination'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapMarker(Color color, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
            ],
          ),
          child: Text(label,
              style: AppTextStyles.medium.copyWith(fontSize: 11.sp)),
        ),
        SizedBox(height: 4.h),
        Icon(Icons.location_on, color: color, size: 32.sp),
      ],
    );
  }

  Widget _statChip(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: AppTextStyles.large
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp)),
        Text(label,
            style:
            AppTextStyles.medium.copyWith(color: Colors.grey, fontSize: 11.sp)),
      ],
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)
          ],
        ),
        child: Icon(icon, size: 18.sp, color: const Color(0xFF0C0C0C)),
      ),
    );
  }

  Widget _mapControlButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)
        ],
      ),
      child: Icon(icon, size: 18.sp, color: const Color(0xFF0C0C0C)),
    );
  }
}

// Simple grid painter to simulate a map background
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Horizontal roads
    for (double y = 60; y < size.height; y += 80) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), roadPaint);
    }
    // Vertical roads
    for (double x = 60; x < size.width; x += 90) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), roadPaint);
    }
    // Diagonal roads
    canvas.drawLine(
        Offset(0, size.height * 0.2), Offset(size.width, size.height * 0.6), thinRoadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7), Offset(size.width * 0.8, size.height * 0.1), thinRoadPaint);

    // Blue dots (other cars)
    final dotPaint = Paint()..color = Colors.blue.shade400;
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.35), 6, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.6), 6, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.55), 6, dotPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}