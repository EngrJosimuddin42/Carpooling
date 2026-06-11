import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/app_data.dart';
import '../../models/child_model.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/dashed_outline_button.dart';
import '../profile/manage_children/manage_children_screen.dart';
import 'child_card.dart';

class AddYourChildScreen extends StatefulWidget {
  const AddYourChildScreen({super.key});

  @override
  State<AddYourChildScreen> createState() => _AddYourChildScreenState();
}

class _AddYourChildScreenState extends State<AddYourChildScreen> {
  final List<ChildModel> _children = [];
  bool _showForm = false;

  // Form controllers
  final _nameCtrl  = TextEditingController();
  final _schoolCtrl = TextEditingController();
  final _gradeCtrl  = TextEditingController();


  String _relationship = 'Mother';
  String? _photoPath;

  final List<String> _relationships = ['Mother', 'Father', 'Guardian', 'Grandparent'];

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _photoPath = picked.path);
  }

  void _addChild() {
    if (_nameCtrl.text.isEmpty) return;
    final newChild = ChildModel(
      id: DateTime.now().toIso8601String(),
      fullName: _nameCtrl.text,
      schoolName: _schoolCtrl.text,
      grade: _gradeCtrl.text,
      relationship: _relationship,
      photoPath: _photoPath,
    );
    setState(() {
      _children.add(newChild);
      AppData().children.add(newChild);
      _showForm = false;
      _nameCtrl.clear();
      _schoolCtrl.clear();
      _gradeCtrl.clear();
      _photoPath = null;
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _schoolCtrl.dispose();
    _gradeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text('Add Your Child',
                  style:AppTextStyles.headlineMedium),
              SizedBox(height: 9.h),
              Text('Add at least one child to start using HadiKid',
                  style: AppTextStyles.emptyText.copyWith(color:const Color(0xFF4A5565))),

              SizedBox(height: 50.h),

              Expanded(
                  child: _showForm
                      ? _buildForm()
                      : _children.isEmpty
                      ? _buildEmptyState()
                      : _buildChildList()),

              SizedBox(height: 16.h),

              if (!_showForm)
                _children.isEmpty
                    ? Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 168.w,
                    height: 56.h,
                    child: DashedOutlineButton(
                      text: '+ Add Child',
                      borderColor: const Color(0xFF8EC5FF),
                      onPressed: () => setState(() => _showForm = true),
                    ),
                  ),
                )
                    : Row(
                  children: [
                    if (_children.isNotEmpty) ...[
                      Expanded(
                        child: PrimaryButton(
                          fontSize: 14.sp,
                          text: 'Continue to Home',
                          onPressed: () => context.go('/home'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: DashedOutlineButton(
                          text: '+ Add Another Child',
                          borderColor: const Color(0xFF8EC5FF),
                          onPressed: () => setState(() => _showForm = true),
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ── Empty state ────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 96.w, height: 96.w,
              alignment: Alignment.center,
              decoration:const BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                  'assets/icons/person_outline.svg', width: 48.w, height: 48.w)),
          SizedBox(height: 14.h),
          Text('No children added yet',
              style:AppTextStyles.emptyText),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  // ── Child card list ────────────────────────
  Widget _buildChildList() {
    return ListView.separated(
      itemCount: _children.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, i) {
        return ChildCard(
          child: _children[i],
          onDelete: () => setState(() => _children.removeAt(i)),
          onEdit: () {
            final c = _children[i];
            _nameCtrl.text   = c.fullName;
            _schoolCtrl.text = c.schoolName;
            _gradeCtrl.text  = c.grade;
            _relationship    = c.relationship;
            _photoPath       = c.photoPath;
            _children.removeAt(i);
            setState(() => _showForm = true);
          },
          onView: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ManageChildrenScreen(
                initialChildren: _children,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 60 * i), duration: 350.ms)
            .slideY(begin: 0.05);
      },
    );
  }

  // ── Add form ───────────────────────────────
  Widget _buildForm() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding:EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.05.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Photo picker
            GestureDetector(
              onTap: _pickPhoto,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3.31),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x1A000000),
                              offset: Offset(0, 3.61),
                              blurRadius: 5.41,
                              spreadRadius: -3.61),
                          BoxShadow(
                              color: Color(0x1A000000),
                              offset: Offset(0, 9.02),
                              blurRadius: 13.54,
                              spreadRadius: -2.71),
                        ],
                      ),
                      child: CircleAvatar(
                          radius: 58.r,
                          backgroundColor: const Color(0x3366B2A3),
                          backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
                          child: _photoPath == null
                              ? SvgPicture.asset(
                              'assets/icons/person_outline.svg', width: 58.w, height: 58.w,
                              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
                              : null)),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3.31),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 3.61),
                            blurRadius: 5.41,
                            spreadRadius: -3.61),
                        BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 9.02),
                            blurRadius: 13.54,
                            spreadRadius: -2.71),
                      ],
                    ),
                    child:Icon(Icons.camera_alt_outlined, size: 14.sp, color: AppColors.white),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Text("Add child's photo",
                style: AppTextStyles.small),

            SizedBox(height: 20.h),

            _fieldLabel("Child's Full Name"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _nameCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "Enter child's name",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/person_outline.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),
            _fieldLabel("School Name"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _schoolCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "Enter school name",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/school_outlined.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),
            _fieldLabel("Grade / Class"),
            SizedBox(height: 7.21.h),
            AppTextField(
                controller: _gradeCtrl,
                fillColor: Colors.white,
                borderColor:const Color(0xFFD1D5DC),
                hintText: "e.g., 3rd Grade",
                prefixIcon: SvgPicture.asset(
                    'assets/icons/school_outlined.svg', width: 20.sp, height: 20.sp,
                    colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn))),

            SizedBox(height: 16.h),
            _fieldLabel("Your Relationship"),
            SizedBox(height: 8.13.h),
            Container(
              decoration: BoxDecoration(
                  color:Colors.white,
                  border: Border.all(color:const Color(0xFFD1D5DC)),
                  borderRadius: BorderRadius.circular(14.r)),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/icons/group_outlined.svg', width: 20.sp, height: 20.sp,
                      colorFilter: const ColorFilter.mode(AppColors.muted, BlendMode.srcIn)),
                  SizedBox(width: 14.w),

                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _relationship,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF99A1AF)),
                        style:AppTextStyles.dropHitText,
                        borderRadius: BorderRadius.circular(14.r),
                        items: _relationships.map((r) =>
                            DropdownMenuItem(value: r, child: Text(r,style: AppTextStyles.dropHitText.copyWith(color: AppColors.heading),))).toList(),
                        onChanged: (v) => setState(() => _relationship = v ?? _relationship),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    backgroundColor:const Color(0xFFE5E7EB),
                    textColor: const Color(0xFF364153),
                    text: 'Cancel',
                    onPressed: () => setState(() => _showForm = false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    text: 'Add Child',
                    onPressed: _addChild,
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05),
    );
  }

  Widget _fieldLabel(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: AppTextStyles.textSmall),
  );
}
