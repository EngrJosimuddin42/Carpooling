import 'dart:async';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SupportCallScreen extends StatefulWidget {
  const SupportCallScreen({super.key});

  @override
  State<SupportCallScreen> createState() => _SupportCallScreenState();
}

class _SupportCallScreenState extends State<SupportCallScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isMuted = false;
  bool _isSpeaker = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  String get _formattedTime {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF66B2A3), // 0%
                Color(0xFF2A8D79), // 100%
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration:const BoxDecoration(
                          color: Color(0x33FFFFFF),
                          shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back,
                            color: Colors.white, size: 20.sp)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),


            const Spacer(),

            // Avatar with pulse
            _buildAvatar()
                .animate(onPlay: (c) => c.repeat())
                .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.05, 1.05),
              duration: 1000.ms,
              curve: Curves.easeInOut,
            )
                .then()
                .scale(
              begin: const Offset(1.05, 1.05),
              end: const Offset(1.0, 1.0),
              duration: 1000.ms,
              curve: Curves.easeInOut,
            ),

            SizedBox(height: 28.h),

            // Name
            Text(
              'Customer Support',
              style: AppTextStyles.large.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            SizedBox(height: 6.h),

            // Status
            Text(
              'Calling...',
              style: AppTextStyles.medium.copyWith(color: Colors.white70),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            SizedBox(height: 4.h),

            // Phone number
            Text(
              '+880 1712-345678',
              style: AppTextStyles.medium.copyWith(color: Colors.white60),
            ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

            SizedBox(height: 16.h),

            // Timer
            Text(
              _formattedTime,
              style: AppTextStyles.large.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
                letterSpacing: 2,
              ),
            ),

            SizedBox(height: 20.h),

            // Support note
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14.23.r),
              ),
              child: Text(
                'Support available 24/7 to assist you',
                style: AppTextStyles.medium.copyWith(color: Colors.white70),
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

            const Spacer(),

            // Call controls
            _buildControls()
                .animate()
                .fadeIn(delay: 500.ms, duration: 400.ms)
                .slideY(begin: 0.2),

            SizedBox(height: 40.h),
          ],
        ),
      ),
        ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer pulse ring
        Container(
          width: 130.w,
          height: 130.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        // Inner ring
        Container(
          width: 110.w,
          height: 110.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
          ),
        ),
        // Avatar
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(color: Colors.white30, width: 2),
          ),
          child: Icon(Icons.headset_mic_outlined,
              color: Colors.white, size: 44.sp),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _controlBtn(
              icon: _isMuted ? Icons.mic_off : Icons.mic_outlined,
              active: _isMuted,
              onTap: () => setState(() => _isMuted = !_isMuted),
            ),
            SizedBox(width: 24.w),
            _controlBtn(
              icon: _isSpeaker ? Icons.volume_up : Icons.volume_down_outlined,
              active: _isSpeaker,
              onTap: () => setState(() => _isSpeaker = !_isSpeaker),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        // End call button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.call_end, color: Colors.white, size: 28.sp),
          ),
        ),
      ],
    );
  }

  Widget _controlBtn({
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52.w,
        height: 52.w,
        decoration: BoxDecoration(
          color: active
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }
}