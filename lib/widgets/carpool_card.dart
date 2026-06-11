import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../modules/carpools/carpool_detail_screen.dart';

class CarpoolCard extends StatelessWidget {
  final Map<String, dynamic> carpool;

  const CarpoolCard({super.key, required this.carpool});

  @override
  Widget build(BuildContext context) {
    final c = carpool;
    final isActive = c['status'] == 'Active';
    final statusColor = isActive ? const Color(0xFF007A55) : const Color(0xFFC10007);
    final iconColor = isActive ? const Color(0xFF009966) : const Color(0xFFE7000B);
    final backgroundColor = isActive ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CarpoolDetailScreen(carpool: c),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: AppColors.softCardShadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(c['title'], style: AppTextStyles.name),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFD0FAE5)
                          : const Color(0xFFFFEDD4),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text(c['status'],
                      style: AppTextStyles.status.copyWith(
                        color: isActive ? const Color(0xFF007A55) :const Color(0xFFCA3500),
                      )),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/clock.svg', width: 16.sp, height: 16.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF4A5565), BlendMode.srcIn)),
                SizedBox(width: 4.w),
                Text(c['date'], style: AppTextStyles.school.copyWith(color:const Color(0xFF4A5565))),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/location.svg', width: 16.sp, height: 16.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF009966), BlendMode.srcIn)),
                SizedBox(width: 6.w),
                Text(c['from'], style: AppTextStyles.school.copyWith(color:const Color(0xFF364153))),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/location.svg', width: 16.sp, height: 16.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFFE7000B), BlendMode.srcIn)),
                SizedBox(width: 6.w),
                Text(c['to'], style: AppTextStyles.school.copyWith(color:const Color(0xFF364153))),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/carpool_outlined.svg', width: 16.sp, height: 16.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF6A7282), BlendMode.srcIn)),
                SizedBox(width: 5.w),
                Text('${c['parents']} parents',
                    style: AppTextStyles.school.copyWith(color:const Color(0xFF364153))),
                SizedBox(width: 12.w),
                SvgPicture.asset(
                    'assets/icons/carpool_outlined.svg', width: 16.sp, height: 16.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF6A7282), BlendMode.srcIn)),
                SizedBox(width: 5.w),
                Text('${c['children']} children',
                    style: AppTextStyles.school.copyWith(color:const Color(0xFF364153))),
                const Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                              'assets/icons/car.svg', width: 16.sp, height: 24.sp,
                              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
                          SizedBox(width: 4.w),
                          Text(c['driver'],
                              style: AppTextStyles.school
                                  .copyWith(color: statusColor))])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}