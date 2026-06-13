import 'package:carpooling/modules/carpools/rating_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_bottom_nav.dart';
import '../profile/manage_children/custom_delete_dialog.dart';
import 'call_screen.dart';

class TripInProgressScreen extends StatefulWidget {
  final Map<String, dynamic> carpool;
  const TripInProgressScreen({super.key, required this.carpool});

  @override
  State<TripInProgressScreen> createState() => _TripInProgressScreenState();
}

class _TripInProgressScreenState extends State<TripInProgressScreen> {
  bool _isPickupPhase = true;

  final List<Map<String, dynamic>> _children = [
    {'name': 'Ahmed', 'status': 'Waiting for pickup', 'pickedUp': false, 'droppedOff': false},
    {'name': 'Sarah', 'status': 'Waiting for pickup', 'pickedUp': false, 'droppedOff': false, 'unattended': true},
    {'name': 'Hasan', 'status': 'Waiting for pickup', 'pickedUp': false, 'droppedOff': false},
  ];

  int get _pickedUpCount => _children.where((c) => c['pickedUp']).length;
  int get _droppedOffCount => _children.where((c) => c['droppedOff']).length;

  void _showDeleteConfirmation(BuildContext context, int index) {
    CustomDeleteDialog.show(
      context: context,
      title: 'Confirmation',
      message: 'Are you sure you want to remove this child from your Checklist? This action cannot be undone.',
      onConfirm: () {
        setState(() {
          _children.removeAt(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      extendBodyBehindAppBar: true,
      body: Column(
          children: [
            _buildTripHeader(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEmergencyButton(),
                      SizedBox(height: 12.h),
                      _buildMarkArrivedButton(),
                      SizedBox(height: 16.h),
                      _buildChecklist(context),
                      SizedBox(height: 16.h),
                      _buildActionButtons(context),
                      SizedBox(height: 16.h),
                      if (!_isPickupPhase && _droppedOffCount == _children.length)
                        _buildCompleteButton(context),
                    ],
                  ),
                ),
            ),
          ],
        ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildTripHeader() {
    return Container(
      padding: EdgeInsets.only(top: 60.h, bottom: 24.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF66B2A3), Color(0xFF2A8D79)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ব্যাক বাটন
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: const BoxDecoration(
                        color: Color(0x33FFFFFF), shape: BoxShape.circle),
                    child: Icon(Icons.arrow_back, size: 20.sp, color: Colors.white))),
                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 8.w, height: 8.w, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          SizedBox(width: 8.w),
                          Text('TRIP IN PROGRESS', style: AppTextStyles.action.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.carpool['title'] ?? 'Morning School Run',
                        style: AppTextStyles.heading.copyWith(color: Colors.white, fontSize: 24.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(child: _statItem('${_isPickupPhase ? _pickedUpCount : _droppedOffCount}/${_children.length}', _isPickupPhase ? 'Picked Up' : 'Dropped Off')),
                SizedBox(width: 12.w),
                Expanded(child: _statItem('12 min', 'ETA')),
                SizedBox(width: 12.w),
                Expanded(child: _statItem('5.2 km', 'Remaining')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(14.23.r)),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.heading.copyWith(color: Colors.white)),
          SizedBox(height: 2.h),
          Text(label, style: AppTextStyles.time.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        icon: Icon(Icons.warning, color: Colors.white, size: 18.sp),
        label: Text('Emergency',
            style: AppTextStyles.medium.copyWith(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }

  Widget _buildMarkArrivedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        icon: Icon(Icons.location_on, color: Colors.white, size: 18.sp),
        label: Text('Mark as Arrived',
            style: AppTextStyles.medium.copyWith(color: Colors.white)),
        onPressed: () => setState(() => _isPickupPhase = false),
      ),
    );
  }

  Widget _buildChecklist(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              _isPickupPhase ? Icons.radio_button_unchecked : Icons.check_circle,
              color: AppColors.primary, size: 18.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              _isPickupPhase ? 'Pickup Checklist' : 'Drop-off Checklist',
              style: AppTextStyles.title,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ..._children.asMap().entries.map((entry) {
          final i = entry.key;
          final child = entry.value;
          final isDone = _isPickupPhase ? child['pickedUp'] : child['droppedOff'];
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    if (_isPickupPhase) {
                      _children[i]['pickedUp'] = !_children[i]['pickedUp'];
                      _children[i]['status'] = _children[i]['pickedUp']
                          ? 'On board'
                          : 'Waiting for pickup';
                    } else {
                      _children[i]['droppedOff'] = !_children[i]['droppedOff'];
                    }
                  }),
                  child: Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                          color: isDone ? AppColors.primary : Colors.grey),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: isDone
                        ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                        : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child['name'], style: AppTextStyles.title),
                      Row(
                        children: [
                          Text(child['status'],
                              style: AppTextStyles.medium.copyWith(color: Colors.grey)),
                          if (child['unattended'] == true) ...[
                            SizedBox(width: 4.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text('Unattended',
                                  style: AppTextStyles.medium.copyWith(
                                      color: Colors.orange, fontSize: 10.sp)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDeleteConfirmation(context, i),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.red, size: 14.sp),
                  ),
                ),
                if (isDone)
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Icon(Icons.check_circle,
                        color: AppColors.primary, size: 18.sp),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _actionBtn(Icons.map_outlined, 'Map', AppColors.primary.withOpacity(0.1), AppColors.primary, () {})),
        SizedBox(width: 8.w),
        Expanded(child: _actionBtn(Icons.call_outlined, 'Call', AppColors.primary.withOpacity(0.1), AppColors.primary, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CallScreen())))),
        SizedBox(width: 8.w),
        Expanded(child: _actionBtn(Icons.chat_outlined, 'Message', AppColors.primary.withOpacity(0.1), AppColors.primary, () {})),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, Color bg, Color fg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: fg, size: 20.sp),
            SizedBox(height: 4.h),
            Text(label, style: AppTextStyles.medium.copyWith(color: fg)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        icon: Icon(Icons.check_circle_outline, color: Colors.white, size: 20.sp),
        label: Text('Complete Trip',
            style: AppTextStyles.medium.copyWith(color: Colors.white)),
        onPressed: () => _showCompleteTripDialog(context),
      ),
    );
  }

  void _showCompleteTripDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) =>
          Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, color: AppColors.primary,
                      size: 48.sp),
                  SizedBox(height: 12.h),
                  Text('Complete This Trip?', style: AppTextStyles.large),
                  SizedBox(height: 8.h),
                  Text(
                    'Are you sure you want to complete this carpool trip? This action will stop tracking and save the ride history.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.medium,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel', style: AppTextStyles.medium),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (
                                  _) => const RatingScreen()),
                            );
                          },
                          child: Text('Complete Trip',
                              style: AppTextStyles.medium.copyWith(
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}