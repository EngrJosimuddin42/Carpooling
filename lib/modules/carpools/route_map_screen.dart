import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_bottom_nav.dart';
import 'live_tracking_screen.dart';
import 'trip_in_progress_screen.dart';

class RouteMapScreen extends StatefulWidget {
  final Map<String, dynamic>? carpool;

  const RouteMapScreen({super.key, this.carpool});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  double _zoomFactor = 1.0;
  Offset _mapOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const AppBottomNav(currentIndex: 1),
        body: Stack(
          children: [
            // ── Interactive Map Background ──
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _mapOffset += details.delta;
                });
              },
              child: Container(
                color: const Color(0xFFF1F5F2), // Light map background color
                child: ClipRect(
                  child: CustomPaint(
                    painter: _MapGridPainter(
                      zoomFactor: _zoomFactor,
                      offset: _mapOffset,
                    ),
                    child: Container(),
                  ),
                ),
              ),
            ),

            // ── Top Title Bar ──
            Positioned(
              top: 50.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                children: [
                  _circleButton(
                    Icons.arrow_back,
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => TripInProgressScreen(
                            carpool: widget.carpool ?? {},
                          )),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Route Map',
                    style: AppTextStyles.heading.copyWith(
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),
            ),

            // ── Distance & Time Card (Top Left) ──
            Positioned(
              top: 120.h,
              left: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _statChip('8.5 km', 'Distance'),
                    Container(
                      width: 1.w,
                      height: 32.h,
                      color: const Color(0xFFE2E8F0),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
                    _statChip('15 min', 'Travel Time'),
                  ],
                ),
              ),
            ),

            // ── Map Zoom/Location Controls (Top Right) ──
            Positioned(
              top: 120.h,
              right: 16.w,
              child: Column(
                children: [
                  _mapControlButton(
                    Icons.zoom_in,
                    onTap: () {
                      setState(() {
                        _zoomFactor = (_zoomFactor + 0.15).clamp(0.6, 2.5);
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  _mapControlButton(
                    Icons.zoom_out,
                    onTap: () {
                      setState(() {
                        _zoomFactor = (_zoomFactor - 0.15).clamp(0.6, 2.5);
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  _mapControlButton(
                    Icons.gps_fixed,
                    onTap: () {
                      setState(() {
                        _zoomFactor = 1.0;
                        _mapOffset = Offset.zero;
                      });
                    },
                  ),
                ],
              ),
            ),

            // ── Bottom Sheet Information Panel ──
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 32.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.grey.shade100,
                          backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.carpool?['title'] ?? 'Morning School Run',
                                style: AppTextStyles.heading.copyWith(
                                  color: const Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Driver: Ahmed Rahman',
                                style: AppTextStyles.medium.copyWith(
                                  color: const Color(0xFF64748B),
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16.sp,
                                    color: const Color(0xFF0D9488),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Arrives in 15 minutes',
                                    style: AppTextStyles.medium.copyWith(
                                      color: const Color(0xFF0D9488),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Track Live button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66B2A3), // Primary teal brand color
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          elevation: 0,
                        ),
                        icon: Icon(Icons.near_me_outlined, color: Colors.white, size: 20.sp),
                        label: Text(
                          'Track Live',
                          style: AppTextStyles.head.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LiveTrackingScreen(
                                carpool: widget.carpool ?? const {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──

  Widget _statChip(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.large.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.medium.copyWith(
            color: const Color(0xFF64748B),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF0F172A)),
      ),
    );
  }

  Widget _mapControlButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF0F172A)),
      ),
    );
  }
}

// Custom road network and map detail painter matching the screenshot
class _MapGridPainter extends CustomPainter {
  final double zoomFactor;
  final Offset offset;

  _MapGridPainter({required this.zoomFactor, required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    // Focus translation & zoom on center of map viewport
    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(center.dx + offset.dx, center.dy + offset.dy);
    canvas.scale(zoomFactor);
    canvas.translate(-center.dx, -center.dy);

    // Background Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE2EAF0)
      ..strokeWidth = 1.0;

    const double gridSpacing = 40.0;
    // Draw wide area grid
    for (double x = -size.width; x < size.width * 2; x += gridSpacing) {
      canvas.drawLine(Offset(x, -size.height), Offset(x, size.height * 2), gridPaint);
    }
    for (double y = -size.height; y < size.height * 2; y += gridSpacing) {
      canvas.drawLine(Offset(-size.width, y), Offset(size.width * 2, y), gridPaint);
    }

    // Road styling: casing border first, then pink/beige inner fill.
    final borderPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFFFEE2E2) // Light pink/beige road
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Define main route paths
    final path1 = Path();
    path1.moveTo(0, size.height * 0.15);
    path1.quadraticBezierTo(size.width * 0.4, size.height * 0.25, size.width * 0.6, size.height * 0.6);
    path1.quadraticBezierTo(size.width * 0.7, size.height * 0.85, size.width, size.height * 0.9);

    final path2 = Path();
    path2.moveTo(size.width * 0.1, size.height);
    path2.quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.45);
    path2.quadraticBezierTo(size.width * 0.75, size.height * 0.3, size.width, size.height * 0.2);

    final path3 = Path();
    path3.moveTo(0, size.height * 0.6);
    path3.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.5, size.height * 0.45);
    path3.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width, size.height * 0.7);

    final path4 = Path();
    path4.moveTo(size.width * 0.8, 0);
    path4.lineTo(size.width * 0.4, size.height);

    // Draw borders (casing)
    canvas.drawPath(path1, borderPaint);
    canvas.drawPath(path2, borderPaint);
    canvas.drawPath(path3, borderPaint);
    canvas.drawPath(path4, borderPaint);

    // Draw fills
    canvas.drawPath(path1, fillPaint);
    canvas.drawPath(path2, fillPaint);
    canvas.drawPath(path3, fillPaint);
    canvas.drawPath(path4, fillPaint);

    // Intersection Nodes (circles)
    final nodeBorderPaint = Paint()
      ..color = const Color(0xFF94A3B8)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final nodeFillPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.fill;

    final List<Offset> intersections = [
      Offset(size.width * 0.42, size.height * 0.32),
      Offset(size.width * 0.59, size.height * 0.36),
      Offset(size.width * 0.15, size.height * 0.44),
      Offset(size.width * 0.88, size.height * 0.66),
    ];

    for (final pos in intersections) {
      canvas.drawCircle(pos, 12.0, nodeFillPaint);
      canvas.drawCircle(pos, 12.0, nodeBorderPaint);
      
      // inner pink dot
      canvas.drawCircle(pos, 6.0, Paint()..color = const Color(0xFFFEE2E2));
      canvas.drawCircle(pos, 6.0, Paint()..color = const Color(0xFF94A3B8)..style = PaintingStyle.stroke..strokeWidth = 2.0);
    }

    // Vehicle dots (solid blue circles)
    final vehiclePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;

    final List<Offset> vehicles = [
      Offset(size.width * 0.35, size.height * 0.28),
      Offset(size.width * 0.65, size.height * 0.48),
      Offset(size.width * 0.22, size.height * 0.75),
    ];

    for (final pos in vehicles) {
      canvas.drawCircle(pos, 5.0, vehiclePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter oldDelegate) =>
      oldDelegate.zoomFactor != zoomFactor || oldDelegate.offset != offset;
}
