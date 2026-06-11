import 'package:carpooling/modules/carpools/ready_to_start_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDriverScreen extends StatefulWidget {
  final Map<String, dynamic> carpool;
  const SelectDriverScreen({super.key, required this.carpool});

  @override
  State<SelectDriverScreen> createState() => _SelectDriverScreenState();
}

class _SelectDriverScreenState extends State<SelectDriverScreen> {
  String? _selectedDriver;

  final List<Map<String, dynamic>> _members = [
    {'name': 'You', 'children': ['Emma, 8 years', 'Liam, 6 years']},
    {'name': 'Sarah Johnson', 'children': ['Olivia, 7 years']},
    {'name': 'Mike Thompson', 'children': ['Noah, 9 years', 'Sophia, 7 years']},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF0C0C0C)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.edit_outlined, size: 20.sp), onPressed: () {}),
          IconButton(icon: Icon(Icons.delete_outline, size: 20.sp, color: Colors.red), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.carpool['title'], style: AppTextStyles.large),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text('Upcoming',
                      style: AppTextStyles.medium.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text('May 14, 2026 • 7:30 AM - 8:00 AM',
                    style: AppTextStyles.medium.copyWith(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 16.h),

            // Driver assigned banner
            if (_selectedDriver != null)
              Container(
                padding: EdgeInsets.all(14.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          child: Text(_selectedDriver![0],
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColors.primary)),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_selectedDriver!, style: AppTextStyles.title),
                            Text('May 14, 2026',
                                style: AppTextStyles.medium
                                    .copyWith(color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text('Driver',
                              style: AppTextStyles.medium
                                  .copyWith(color: Colors.white, fontSize: 11.sp)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text("You are the driver",
                        style: AppTextStyles.title
                            .copyWith(color: AppColors.primary)),
                    Text("You've been assigned as the driver for this carpool.",
                        style: AppTextStyles.medium),
                    SizedBox(height: 10.h),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      onPressed: () => setState(() => _selectedDriver = null),
                      child: Text('Remove Myself as Driver',
                          style: AppTextStyles.medium.copyWith(color: Colors.red)),
                    ),
                  ],
                ),
              ),

            // Route
            Text('Route', style: AppTextStyles.title),
            SizedBox(height: 12.h),
            _routeItem(Icons.circle, AppColors.primary, 'Pickup', '123 Main Street, Cityville'),
            Container(
              margin: EdgeInsets.only(left: 11.w),
              width: 2, height: 20.h,
              color: Colors.grey.withOpacity(0.3),
            ),
            _routeItem(Icons.location_on, Colors.red, 'Destination',
                'Lincoln Elementary School, 456 Oak Avenue'),
            SizedBox(height: 16.h),

            // Map button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                icon: Icon(Icons.map_outlined, color: Colors.white, size: 18.sp),
                label: Text('View on Map',
                    style: AppTextStyles.medium.copyWith(color: Colors.white)),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20.h),

            // Members
            Text('Members (${_members.length})', style: AppTextStyles.title),
            SizedBox(height: 12.h),
            ..._members.map((m) => GestureDetector(
              onTap: () => setState(() => _selectedDriver = m['name']),
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: _selectedDriver == m['name']
                        ? AppColors.primary
                        : const Color(0xFFE0E0E0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor:
                          AppColors.primary.withOpacity(0.15),
                          child: Text(m['name'][0],
                              style: AppTextStyles.medium
                                  .copyWith(color: AppColors.primary)),
                        ),
                        SizedBox(width: 10.w),
                        Text(m['name'], style: AppTextStyles.title),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ...(m['children'] as List<String>).map((child) => Padding(
                      padding: EdgeInsets.only(left: 42.w, bottom: 2.h),
                      child: Text(child,
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.grey)),
                    )),
                  ],
                ),
              ),
            )),
            SizedBox(height: 20.h),

            // Notes
            Text('Notes', style: AppTextStyles.title),
            SizedBox(height: 8.h),
            Text("Please be on time. Kids should bring their backpacks.",
                style: AppTextStyles.medium),
            SizedBox(height: 20.h),

            // Start Trip
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                icon: Icon(Icons.play_arrow, color: Colors.white, size: 20.sp),
                label: Text('Start Trip',
                    style: AppTextStyles.medium.copyWith(color: Colors.white)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReadyToStartScreen(carpool: widget.carpool)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    icon: Icon(Icons.chat_outlined,
                        color: AppColors.primary, size: 18.sp),
                    label: Text('Chat',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.primary)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    icon: Icon(Icons.location_on, color: Colors.white, size: 18.sp),
                    label: Text('Track Live',
                        style: AppTextStyles.medium.copyWith(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _routeItem(IconData icon, Color color, String label, String address) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.medium.copyWith(color: Colors.grey)),
            Text(address, style: AppTextStyles.title),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Carpools'),
        BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}