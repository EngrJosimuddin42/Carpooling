import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_bottom_nav.dart';
import 'call_screen.dart';
import 'route_map_screen.dart';

class LiveTrackingScreen extends StatefulWidget {
  final Map<String, dynamic>? carpool;

  const LiveTrackingScreen({super.key, this.carpool});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  // 0=started, 1=picking sarah, 2=picking ahmed, 3=heading school, 4=reached
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
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: Scaffold(
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

                  // Top Overlay Bar (Back Button + Title)
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
                                MaterialPageRoute(builder: (_) => const RouteMapScreen()),
                              );
                            }
                          },
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          'Live Tracking',
                          style: AppTextStyles.heading.copyWith(
                            color: const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // LIVE badge (Top Left overlay)
                  Positioned(
                    top: 110.h,
                    left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC0000), // Vibrant Red
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Estimated arrival card (Top Right overlay)
                  Positioned(
                    top: 110.h,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Arrival',
                            style: AppTextStyles.medium.copyWith(
                              color: const Color(0xFF64748B),
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '12 min',
                            style: AppTextStyles.large.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D9488), // Brand Teal
                              fontSize: 22.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Driver info card (Middle Left overlay)
                  Positioned(
                    top: 170.h,
                    left: 16.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
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
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahmed Rahman',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'On the way',
                                style: AppTextStyles.medium.copyWith(
                                  color: const Color(0xFF0D9488),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Car icon on map
                  Positioned(
                    top: 230.h,
                    left: 180.w,
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5AB199), // Brand teal
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.w),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Icon(Icons.directions_car, color: Colors.white, size: 24.sp),
                    ),
                  ),

                  // Green stop dot on map
                  Positioned(
                    bottom: 75.h,
                    left: 80.w,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D9488),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.w),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, -6),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Drag Handle
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trip Progress',
                          style: AppTextStyles.large.copyWith(
                            color: const Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Timeline Progress List
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _steps.length,
                        itemBuilder: (_, i) => _buildTimelineItem(i),
                      ),
                    ),

                    // Action buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      child: Row(
                        children: [
                          _actionButton(
                            Icons.call_outlined,
                            'Call',
                            const Color(0xFFF0FDF4), // Light Green
                            const Color(0xFF16A34A),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CallScreen())),
                          ),
                          SizedBox(width: 12.w),
                          _actionButton(
                            Icons.chat_bubble_outline,
                            'Message',
                            const Color(0xFFEFF6FF), // Light Blue
                            const Color(0xFF2563EB),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Chat messages loading...')),
                              );
                            },
                          ),
                          SizedBox(width: 12.w),
                          _actionButton(
                            Icons.share_outlined,
                            'Share',
                            const Color(0xFFFAF5FF), // Light Purple
                            const Color(0xFF7C3AED),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Share link generated!')),
                              );
                            },
                          ),
                        ],
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

  Widget _buildTimelineItem(int index) {
    final step = _steps[index];
    final isDone = index <= _currentStep;
    final isLast = index == _steps.length - 1;

    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentStep = index;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dot + line
            SizedBox(
              width: 24.w,
              child: Column(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? const Color(0xFF0D9488) : Colors.transparent,
                      border: Border.all(
                        color: isDone ? const Color(0xFF0D9488) : const Color(0xFFCBD5E1),
                        width: 2,
                      ),
                    ),
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
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Label + time
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['label'],
                      style: AppTextStyles.title.copyWith(
                        color: isDone ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                        fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                        fontSize: 15.sp,
                      ),
                    ),
                    if (isDone && step['time'] != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        step['time'],
                        style: AppTextStyles.medium.copyWith(
                          color: const Color(0xFF64748B),
                          fontSize: 12.sp,
                        ),
                      ),
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

  Widget _actionButton(IconData icon, String label, Color bgColor, Color iconColor, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
              Text(
                label,
                style: AppTextStyles.navText.copyWith(
                  color: iconColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildMapPlaceholder() {
    return Container(
      color: const Color(0xFFF1F5F2), // Map background matching other maps
      child: CustomPaint(
        painter: _MapGridPainter(),
        child: Container(),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE2EAF0)
      ..strokeWidth = 1.0;

    const double gridSpacing = 40.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
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
    final vehicleShadow = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill;

    final List<Offset> vehicles = [
      Offset(size.width * 0.64, size.height * 0.23),
      Offset(size.width * 0.52, size.height * 0.46),
      Offset(size.width * 0.36, size.height * 0.61),
    ];

    for (final pos in vehicles) {
      canvas.drawCircle(pos + const Offset(0, 2), 9.0, vehicleShadow);
      canvas.drawCircle(pos, 9.0, vehiclePaint);
      canvas.drawCircle(pos, 9.0, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2.0);
    }

    // Text labels for roads (e.g. A620, A624, A628)
    const textStyle = TextStyle(
      color: Color(0xFF15803D), // Green text
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    _drawText(canvas, 'A620', Offset(size.width * 0.78, size.height * 0.06), textStyle);
    _drawText(canvas, 'A624', Offset(size.width * 0.16, size.height * 0.50), textStyle);
    _drawText(canvas, 'A628', Offset(size.width * 0.81, size.height * 0.59), textStyle);
    _drawText(canvas, 'A624', Offset(size.width * 0.77, size.height * 0.70), textStyle);
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}