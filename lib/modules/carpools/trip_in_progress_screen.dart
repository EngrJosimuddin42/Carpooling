import 'package:carpooling/modules/carpools/rating_screen.dart';
import 'package:carpooling/modules/carpools/route_map_screen.dart';
import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/app_buttons.dart';
import '../inbox/chat_detail_screen.dart';
import '../../widgets/custom_delete_dialog.dart';
import 'call_screen.dart';

class TripInProgressScreen extends StatefulWidget {
  final Map<String, dynamic> carpool;
  const TripInProgressScreen({super.key, required this.carpool});

  @override
  State<TripInProgressScreen> createState() => _TripInProgressScreenState();
}

class _TripInProgressScreenState extends State<TripInProgressScreen> {
  bool _isPickupPhase = true;
  bool _arrivedManually = false;

  final List<Map<String, dynamic>> _children = [
    {
      'name': 'Ahmed',
      'status': 'Waiting for pickup',
      'pickedUp': false,
      'droppedOff': false
    },
    {
      'name': 'Sarah',
      'status': 'Waiting for pickup',
      'pickedUp': false,
      'droppedOff': false,
      'unattended': true
    },
    {
      'name': 'Hasan',
      'status': 'Waiting for pickup',
      'pickedUp': false,
      'droppedOff': false
    },
  ];

  int get _pickedUpCount =>
      _children
          .where((c) => c['pickedUp'] == true)
          .length;

  int get _droppedOffCount =>
      _children
          .where((c) => c['droppedOff'] == true)
          .length;

  bool get _allDroppedOff => _droppedOffCount == _children.length;

  bool get _showMarkArrived =>
      !_isPickupPhase && !_allDroppedOff && !_arrivedManually;

  bool get _showCompleteTrip => !_isPickupPhase && _allDroppedOff;

  void _showDeleteConfirmation(BuildContext context, int index) {
    CustomDeleteDialog.show(
      context: context,
      title: 'Confirmation',
      message: 'Are you sure you want to remove this child from your Checklist? This action cannot be undone.',
      onConfirm: () => setState(() => _children.removeAt(index)),
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
                  if (_showMarkArrived) ...[
                    _buildMarkArrivedButton(),
                    SizedBox(height: 16.h),
                  ],
                  _buildChecklist(context),
                  SizedBox(height: 16.h),
                  _buildActionButtons(context),
                  if (_showCompleteTrip) ...[
                    SizedBox(height: 16.h),
                    _buildCompleteButton(context),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
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
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: const BoxDecoration(
                            color: Color(0x33FFFFFF), shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back, size: 20.sp,
                            color: Colors.white))),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 8.w, height: 8.w,
                              decoration: const BoxDecoration(color: Colors
                                  .white, shape: BoxShape.circle)),
                          SizedBox(width: 8.w),
                          Text('TRIP IN PROGRESS',
                              style: AppTextStyles.action.copyWith(color: Colors
                                  .white)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(widget.carpool['title'] ?? 'Morning School Run',
                          style: AppTextStyles.heading.copyWith(
                              color: Colors.white)),
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
                Expanded(child: _statItem(
                    '${_isPickupPhase
                        ? _pickedUpCount
                        : _droppedOffCount}/${_children.length}',
                    _isPickupPhase ? 'Picked Up' : 'Dropped Off')),
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
          Text(value,
              style: AppTextStyles.heading.copyWith(color: Colors.white)),
          SizedBox(height: 2.h),
          Text(label,
              style: AppTextStyles.time.copyWith(color: Colors.white)),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.symmetric(vertical: 12.h)),
        icon: SvgPicture.asset(
            'assets/icons/shield_outlined.svg', width: 20.sp, height: 20.sp,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        label: Text('Emergency', style: AppTextStyles.cs),
        onPressed: () {},
      ),
    );
  }

  Widget _buildMarkArrivedButton() {
    return PrimaryButton(
      text: 'Mark as Arrived',
      icon: SvgPicture.asset(
          'assets/icons/flag.svg', width: 20.sp, height: 20.sp,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      onPressed: () =>
          setState(() {
            _arrivedManually = true;
            _isPickupPhase = false;
          }),
    );
  }

  Widget _buildChecklist(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: AppColors.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Row(
            children: [
              if (_isPickupPhase)
                Container(
                  width: 22.w, height: 22.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                          color: AppColors.primary, width: 1.69.w)),
                )
              else
                SvgPicture.asset(
                    'assets/icons/flag.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF9810FA), BlendMode.srcIn)),
              SizedBox(width: 8.w),
              Text(
                  _isPickupPhase ? 'Pickup Checklist' : 'Drop-off Checklist',
                  style: AppTextStyles.name),
            ],
          ),
          SizedBox(height: 16.h),

          // ── Children list ──
          ..._children
              .asMap()
              .entries
              .map((entry) {
            final i = entry.key;
            final child = entry.value;
            final isDone = _isPickupPhase
                ? child['pickedUp'] == true
                : child['droppedOff'] == true;

            return GestureDetector(
              onTap: () =>
                  setState(() {
                    if (_isPickupPhase) {
                      _children[i]['pickedUp'] =
                      !(_children[i]['pickedUp'] == true);
                      _children[i]['status'] =
                      _children[i]['pickedUp'] == true
                          ? 'On board'
                          : 'Waiting for pickup';
                      // সব picked up হলে auto dropoff phase
                      if (_children.every((c) => c['pickedUp'] == true)) {
                        _isPickupPhase = false;
                      }
                    } else {
                      _children[i]['droppedOff'] =
                      !(_children[i]['droppedOff'] == true);
                    }
                  }),
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                    color: isDone ? const Color(0xFFFAF5FF) : const Color(
                        0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(14.23.r),
                    border: Border.all(
                        color: isDone
                            ? const Color(0xFFDAB2FF)
                            : const Color(0xFFE5E7EB),
                        width: 1.w)),
                child: Row(
                  children: [
                    // ── Checkbox ──
                    Container(
                      width: 25.w, height: 25.w,
                      decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFF9810FA)
                              : const Color(0xFF141414),
                          borderRadius: BorderRadius.circular(7.r)),
                      child: isDone
                          ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                          : null,
                    ),
                    SizedBox(width: 12.w),

                    // ── Name + Status ──
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(child['name'],
                              style: AppTextStyles.cs.copyWith(
                                  color: const Color(0xFF101828))),
                          SizedBox(height: 2.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: isDone
                                        ? (_isPickupPhase
                                        ? 'On Board'
                                        : 'Dropped Off')
                                        : (_isPickupPhase
                                        ? 'Waiting for pickup'
                                        : 'On Board'),
                                    style: AppTextStyles.status.copyWith(
                                        color: const Color(0xFF4A5565))),
                                if (_isPickupPhase && !isDone &&
                                    child['unattended'] == true) ...[
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                      text: '(Unattended)',
                                      style: AppTextStyles.cs.copyWith(
                                          color: const Color(0xFFFF0000))),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Delete button ──
                    GestureDetector(
                      onTap: () {
                        if (isDone) {
                          setState(() {
                            if (_isPickupPhase) {
                              _children[i]['pickedUp'] = false;
                              _children[i]['status'] = 'Waiting for pickup';
                            } else {
                              _children[i]['droppedOff'] = false;
                            }
                          });
                        } else {
                          _showDeleteConfirmation(context, i);
                        }
                      },
                      child: isDone
                          ? SvgPicture.asset(
                          'assets/icons/check1.svg', width: 24.sp, height: 24
                          .sp,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF9810FA), BlendMode.srcIn))
                          : Container(width: 24.w, height: 24.w,
                          decoration: const BoxDecoration(
                              color: Color(0xFFFF0000),
                              shape: BoxShape.circle),
                          child: Icon(
                              Icons.close, color: Colors.white, size: 14.sp)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
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
                            RouteMapScreen(carpool: widget.carpool))),
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
                                chatName: widget.carpool['title'] ??
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

  Widget _buildCompleteButton(BuildContext context) {
    return PrimaryButton(
      text: 'Complete Trip',
      icon: SvgPicture.asset(
          'assets/icons/complete.svg', width: 24.sp, height: 24.sp,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      onPressed: () => _showCompleteTripDialog(context),
    );
  }


  void _showCompleteTripDialog(BuildContext context) {
    final String driverName = widget.carpool['driver'] ?? 'Unknown Driver';
    final String driverAvatar = widget.carpool['driver_avatar'] ??
        'assets/images/avatar1.jpg';
    final String tripTitle = widget.carpool['title'] ?? 'Carpool Trip';
    final String tripDate = widget.carpool['date'] ?? 'June 14, 2026';

    CustomDeleteDialog.show(
      context: context,
      title: 'Complete This Trip?',
      message: 'Are you sure you want to complete this carpool trip? This action will stop tracking and save the ride history.',
      confirmText: 'Complete Trip',
      confirmColor: AppColors.primary,
      icon: Container(
          width: 64.w, height: 64.w,
          decoration: const BoxDecoration(
              color: Color(0xFFD0FAE5),
              shape: BoxShape.circle),
          child: Center(
              child: SvgPicture.asset(
                  'assets/icons/check1.svg', width: 32.sp, height: 32.sp,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF009966), BlendMode.srcIn)))),
      onConfirm: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  RatingScreen(
                    driverInfo: {
                      'name': driverName,
                      'avatar': driverAvatar,
                    },
                    tripTitle: tripTitle,
                    date: tripDate,
                  ),
            ),
          ),
    );
  }
}