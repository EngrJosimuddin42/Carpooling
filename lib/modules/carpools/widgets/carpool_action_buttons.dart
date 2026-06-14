import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme/app_text_styles.dart';
import '../../inbox/chat_detail_screen.dart';
import '../call_screen.dart';
import '../route_map_screen.dart';


class CarpoolActionButtons extends StatelessWidget {
  final Map<String, dynamic> carpool;

  const CarpoolActionButtons({super.key, required this.carpool});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionBtn(
            svgPath: 'assets/icons/location.svg',
            label: 'Map',
            backgroundColor: const Color(0xFFFAF5FF),
            borderColor: const Color(0xFF8200DB),
            iconColor: const Color(0xFF8200DB),
            onTap: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            RouteMapScreen(carpool:carpool))),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _actionBtn(
            svgPath: 'assets/icons/phone_outlined.svg',
            label: 'Call',
            iconColor: const Color(0xFF007A55),
            backgroundColor: const Color(0xFFECFDF5),
            borderColor: const Color(0xFF007A55),
            onTap: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CallScreen())),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _actionBtn(
            svgPath: 'assets/icons/chat.svg',
            label: 'Message',
            backgroundColor: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF66B2A3),
            borderColor: const Color(0xFF66B2A3),
            onTap: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ChatDetailScreen(
                                chatName: carpool['title'] ??
                                    'Carpool Chat'))),
          ),
        ),
      ],
    );
  }

  Widget _actionBtn({
    required String svgPath,
    required String label,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 1.5.w),
            borderRadius: BorderRadius.circular(14.23.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(svgPath, width: 20.sp, height: 20.sp,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
            SizedBox(height: 8.h),
            Text(label,
                style: AppTextStyles.displaySmall.copyWith(color: iconColor)),
          ],
        ),
      ),
    );
  }
}