import 'package:carpooling/theme/app_colors.dart';
import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/app_data.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';
import 'checkbox_list_item.dart';
import 'contact_list_screen.dart';
import 'nearby_families_screen.dart';

class CreateCarpoolScreen extends StatefulWidget {
  final Map<String, dynamic>? carpoolToEdit;
  final int? index;

  const CreateCarpoolScreen({super.key, this.carpoolToEdit, this.index});

  @override
  State<CreateCarpoolScreen> createState() => _CreateCarpoolScreenState();
}

class _CreateCarpoolScreenState extends State<CreateCarpoolScreen> {
  final _titleCtrl = TextEditingController();
  final _pickupCtrl = TextEditingController();
  final _destCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  bool get _isEditing => widget.carpoolToEdit != null;

  String _selectedSchedule = '';
  final List<String> _schedules = ['Once', 'Daily','Custom'];
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final Set<String> _selectedDays = {};

  final List<Map<String, String>> _children = [
    {'name': 'Emma Johnson', 'age': 'Grade 3rd'},
    {'name': 'Liam Johnson', 'age': 'Grade 1st'},
  ];

  final Set<String> _selectedChildren = {};

  // Invited parents
  final List<Map<String, dynamic>> _invitedParents = [];

  String _selectedDate = '';
  String _selectedStartTime = '';
  String _selectedArrivalTime = '';


  void _createCarpool() {
    if (_titleCtrl.text.trim().isEmpty) {
      AppSnackBar.show(context: context, message: 'Please enter a carpool title', backgroundColor: Colors.redAccent);
      return;
    }
    if (_pickupCtrl.text.trim().isEmpty) {
      AppSnackBar.show(context: context, message: 'Please enter pickup location', backgroundColor: Colors.redAccent);
      return;
    }
    if (_destCtrl.text.trim().isEmpty) {
      AppSnackBar.show(context: context, message: 'Please enter destination', backgroundColor: Colors.redAccent);
      return;
    }

    final newCarpool = {
      'title': _titleCtrl.text.trim(),
      'status': widget.carpoolToEdit?['status'] ?? 'Pending',
      'date': _selectedDate.isEmpty
          ? (widget.carpoolToEdit?['date'] ?? 'Date TBD')
          : '$_selectedDate • $_selectedStartTime',
      'from': _pickupCtrl.text.trim(),
      'to': _destCtrl.text.trim(),
      'parents': widget.carpoolToEdit?['parents'] ?? 1,
      'children': _selectedChildren.isEmpty ? (widget.carpoolToEdit?['children'] ?? 0) : _selectedChildren.length,
      'driver': widget.carpoolToEdit?['driver'] ?? 'You',
      'driverColor': widget.carpoolToEdit?['driverColor'] ?? Colors.green,
      'notes': _notesCtrl.text.trim(),
    };

    if (_isEditing) {
      AppData().carpools.value[widget.index!] = newCarpool;
      AppData().carpools.notifyListeners();
    } else {
      AppData().addCarpool(newCarpool);
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.carpoolToEdit != null) {
      _titleCtrl.text = widget.carpoolToEdit!['title'] ?? '';
      _pickupCtrl.text = widget.carpoolToEdit!['from'] ?? '';
      _destCtrl.text = widget.carpoolToEdit!['to'] ?? '';
      _notesCtrl.text = widget.carpoolToEdit!['notes'] ?? '';
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _pickupCtrl.dispose();
    _destCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate =
      '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}');
    }
  }

  Future<void> _pickTime(bool isArrival) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formatted =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        if (isArrival) {
          _selectedArrivalTime = formatted;
        } else {
          _selectedStartTime = formatted;
        }
      });
    }
  }

  void _inviteNearbyParents() {
    if (_invitedParents.isEmpty) {
      setState(() {
        _invitedParents.add({
          'name': 'Sarah Ahmed',
          'children': '2 children',
          'status': 'Pending',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF9FAFB),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          leadingWidth: 72.w,
          titleSpacing: 8.w,
          leading: Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back, size: 22.sp, color: const Color(0xFF364153))))),
          title: Text(_isEditing ? 'Edit Carpool' : 'Create Carpool', style: AppTextStyles.heading),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25.11.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Title
              _buildLabel('Event Title'),
              SizedBox(height: 8.36.h),
              AppTextField(
                controller: _titleCtrl,
                hintText: 'E.g., Morning School Run',
                fillColor: const Color(0xFFF9FAFB),
                borderColor: const Color(0xFFD1D5DC),
                borderRadius: 14.66.r),
              SizedBox(height: 20.h),

              // Pickup Location
              _buildLabel('Pickup Location'),
              SizedBox(height: 8.36.h),
              AppTextField(
                controller: _pickupCtrl,
                hintText: 'Enter pickup address',
                fillColor: const Color(0xFFF9FAFB),
                borderRadius: 14.66.r,
                borderColor: const Color(0xFFD1D5DC),
                prefixIcon: SvgPicture.asset(
                  'assets/icons/location.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(Color(0xFF009966), BlendMode.srcIn)),
                suffixIcon: SvgPicture.asset(
                  'assets/icons/send1.svg', width: 20.sp, height: 20.sp,
                  colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))),
              SizedBox(height: 20.h),

              // Destination
              _buildLabel('Destination'),
              SizedBox(height: 8.36.h),
              AppTextField(
                  controller: _destCtrl,
                  hintText: 'Enter destination address',
                  fillColor: const Color(0xFFF9FAFB),
                  borderRadius: 14.66.r,
                  borderColor: const Color(0xFFD1D5DC),
                  prefixIcon: SvgPicture.asset(
                      'assets/icons/location.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFFE7000B), BlendMode.srcIn)),
                  suffixIcon: SvgPicture.asset(
                      'assets/icons/send1.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))),
              SizedBox(height: 20.h),

              // Date & Start Time
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Date'),
                        SizedBox(height: 8.36.h),
                        AppTextField(
                          hintText: _selectedDate.isEmpty ? 'mm/dd/yyyy' : _selectedDate,
                          readOnly: true,
                          onTap: _pickDate,
                          fillColor: const Color(0xFFF9FAFB),
                          borderRadius: 14.66.r,
                          borderColor: const Color(0xFFD1D5DC),
                          prefixIcon: SvgPicture.asset(
                              'assets/icons/calender.svg', width: 20.sp, height: 20.sp,
                              colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn))),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.75.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Start Time'),
                        SizedBox(height: 8.36.h),
                        AppTextField(
                          hintText: _selectedStartTime.isEmpty ? '--/--/--' : _selectedStartTime,
                          readOnly: true,
                          onTap: () => _pickTime(false),
                          fillColor: const Color(0xFFF9FAFB),
                          borderRadius: 14.66.r,
                          borderColor: const Color(0xFFD1D5DC),
                            prefixIcon: SvgPicture.asset(
                                'assets/icons/clock.svg', width: 20.sp, height: 20.sp,
                                colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Estimated Arrival Time
              _buildLabel('Estimated Arrival Time'),
              SizedBox(height: 8.36.h),
              AppTextField(
                hintText: _selectedArrivalTime.isEmpty ? '--/--/--' : _selectedArrivalTime,
                readOnly: true,
                onTap: () => _pickTime(true),
                fillColor: const Color(0xFFF9FAFB),
                borderRadius: 14.66.r,
                borderColor: const Color(0xFFD1D5DC),
                  prefixIcon: SvgPicture.asset(
                      'assets/icons/clock.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFF99A1AF), BlendMode.srcIn))),
              SizedBox(height: 20.h),

              // Calendar
              _buildLabel('Calendar'),
              SizedBox(height: 12.56.h),
              _buildScheduleSelector(),
              SizedBox(height: 16.h),

              // Custom days
              if (_selectedSchedule == 'Custom') ...[
                _buildDaysSelector(),
                SizedBox(height: 20.h),
              ],

              // Select Children
              _buildLabel('Select Children Attending'),
              SizedBox(height: 12.56.h),
              _buildChildrenSelector(),
              SizedBox(height: 20.h),

              // Notes
              _buildLabel('Notes (Optional)'),
              SizedBox(height: 8.36.h),
              AppTextField(
                controller: _notesCtrl,
                hintText: 'Add any additional information...',
                maxLines: 4,
                fillColor: const Color(0xFFF9FAFB),
                borderRadius: 14.66.r,
                borderColor: const Color(0xFFD1D5DC)),
              SizedBox(height: 20.h),

              // Invite Nearby Parents button
              if (_invitedParents.isEmpty) ...[
                OutlineButton2(
                  text: 'Invite Nearby Parents',
                  onPressed: _inviteNearbyParents,
                  borderColor:const Color(0xFF66B2A3),
                  fontWeight: FontWeight.w600,
                  icon:SvgPicture.asset(
                      'assets/icons/carpool_outlined.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFF66B2A3), BlendMode.srcIn))),

                SizedBox(height: 8.h),
                Text( 'You can only select contacts who have child(ren) under their profile',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.notice),
                SizedBox(height: 24.h),
              ],

              if (_invitedParents.isNotEmpty) ...[
                Text('Invited Parents (${_invitedParents.length})',
                    style: AppTextStyles.mark.copyWith(color: const Color(0xFF364153))),
                SizedBox(height: 12.h),
                ..._invitedParents.asMap().entries.map((e) =>
                    _invitedParentCard(e.value, e.key)),

                OutlineButton2(
                  text: 'Add to the Contact List',
                  borderColor:const Color(0xFF66B2A3),
                  fontWeight: FontWeight.w600,
                  icon: SvgPicture.asset(
                   'assets/icons/carpool_outlined.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(Color(0xFF66B2A3), BlendMode.srcIn)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactListScreen(isFromCreateCarpool: true),
                      ),
                    );
                  },
                ),

                SizedBox(height: 8.h),
                PrimaryButton(
                  text: 'Find Families',
                  fontWeight: FontWeight.w600,
                  icon: SvgPicture.asset(
                      'assets/icons/carpool_outlined.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(Color(0xFFFCFCFC), BlendMode.srcIn)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NearbyFamiliesScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 8.h),
                Text( 'You can only select contacts who have child(ren) under their profile',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.notice),
                SizedBox(height: 24.h),
              ],

              PrimaryButton(
                text: _isEditing ? 'Update Carpool' : 'Create Carpool',
                fontWeight: FontWeight.w600,
                onPressed: _createCarpool,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: AppTextStyles.carpool);


  Widget _buildScheduleSelector() {
    return Column(
      children: _schedules.map((s) => CheckboxListItem(
        label: s,
        selected: _selectedSchedule == s,
        showArrow: s == 'Custom',
        onTap: () => setState(() => _selectedSchedule = s),
      )).toList(),
    );
  }

  Widget _buildDaysSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Select Days'),
        SizedBox(height: 12.56.h),
        ..._days.map((d) => CheckboxListItem(
          label: d,
          selected: _selectedDays.contains(d),
          onTap: () => setState(() {
            _selectedDays.contains(d)
                ? _selectedDays.remove(d)
                : _selectedDays.add(d);
          }),
        )),
      ],
    );
  }

  Widget _buildChildrenSelector() {
    return Column(
      children: _children.map((child) => CheckboxListItem(
        label: child['name']!,
        subtitle: child['age'],
        selected: _selectedChildren.contains(child['name']),
        onTap: () => setState(() {
          _selectedChildren.contains(child['name'])
              ? _selectedChildren.remove(child['name'])
              : _selectedChildren.add(child['name']!);
        }),
      )).toList(),
    );
  }


  Widget _invitedParentCard(Map<String, dynamic> parent, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage('assets/images/avatar.jpg'),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parent['name'],
                    style: AppTextStyles.display.copyWith(color: const Color(0xFF101828))),
                Text(parent['children'],
                    style: AppTextStyles.school.copyWith(color: const Color(0xFF4A5565))),
              ],
            ),
          ),

          // ── Spinning pending badge ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                    'assets/icons/pending.svg', width: 20.sp, height: 20.sp),
                SizedBox(width: 6.w),
                Text('Pending',
                    style: AppTextStyles.mark.copyWith(color: const Color(0xFFD08700))),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // ── Close in circle ──
          GestureDetector(
            onTap: () => setState(() => _invitedParents.removeAt(index)),
            child: Container(width: 32.w, height: 32.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF3F4F6)),
              child: Icon(Icons.close, size: 16.sp, color:const Color(0xFF4A5565)),
            ),
          ),
        ],
      ),
    );
  }
}