import 'package:carpooling/modules/carpools/widgets/zoomable_map_painter.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_buttons.dart';
import 'live_tracking_screen.dart';

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
        backgroundColor: const Color(0xFFF9FAFB),
        body: Stack(
          children: [
            // ── Interactive Map Background ──
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _mapOffset += details.delta;
                });
              },
              child:Stack(
                  children: [
                    Container(
                color: const Color(0xFFF1F5F2), // Light map background color
                child: ClipRect(
                  child: CustomPaint(
                    painter: ZoomableMapPainter(
                      zoomFactor: _zoomFactor,
                      offset: _mapOffset,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
                    // ── Pickup Pin ──
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.15,
                      top: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Icon(Icons.location_on, color: Colors.green, size: 40.sp),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
                            child: Text("Pickup", style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
                          ),
                        ],
                      ),
                    ),

                 // ── Destination Pin ──
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.15,
                      bottom: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          Icon(Icons.location_on, color: Colors.red, size: 40.sp),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
                            child: Text("Destination",style: AppTextStyles.cs.copyWith(color: const Color(0xFF101828))),
                          ),
                        ],
                      ),
                    ),
              ]
            )
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
                    onTap: () => Navigator.pop(context)),
                  SizedBox(width: 16.w),
                  Text('Route Map',
                    style: AppTextStyles.tagline)
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
                      color: Colors.black.withValues(alpha: 0.08),
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
                      margin: EdgeInsets.symmetric(horizontal: 16.w)),
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
              bottom: 10,
              child: Container(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 32.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
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
                          radius: 32.r,
                          backgroundColor: Colors.grey.shade100,
                  backgroundImage: (widget.carpool?['driver_avatar'] != null)
                      ? AssetImage(widget.carpool!['driver_avatar'])
                      : const AssetImage('assets/images/avatar1.jpg')),

                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.carpool?['title'] ?? 'Morning School Run',
                                style: AppTextStyles.name),
                              SizedBox(height: 4.h),
                              Text( 'Driver: ${widget.carpool?['driver'] ?? 'Unknown Driver'}',
                                style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/clock.svg', width: 16.sp, height: 16.sp,
                                      colorFilter: const ColorFilter.mode(Color(0xFF009966), BlendMode.srcIn)),
                                  SizedBox(width: 6.w),
                                  Text( 'Arrives in 15 minutes',
                                    style: AppTextStyles.action.copyWith(
                                      color: const Color(0xFF009966))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Track Live button
                    PrimaryButton(
                      text: 'Track Live',
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      icon: SvgPicture.asset('assets/icons/send1.svg', width: 20.sp, height: 20.sp,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
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
          style: AppTextStyles.heading),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.notice.copyWith(
            color: const Color(0xFF4A5565))),
      ],
    );
  }

  Widget _circleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF364153)),
      ),
    );
  }

  Widget _mapControlButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF364153)),
      ),
    );
  }
}
