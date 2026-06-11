import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/app_data.dart';
import '../../../models/child_model.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_bottom_nav.dart';
import 'custom_delete_dialog.dart';
import '../../child/child_card.dart';
import 'add_child_screen.dart';
import 'child_detail_screen.dart';
import 'edit_child_screen.dart';

class ManageChildrenScreen extends StatefulWidget {
  final List<ChildModel> initialChildren;
  const ManageChildrenScreen({super.key, this.initialChildren = const []});

  @override
  State<ManageChildrenScreen> createState() => _ManageChildrenScreenState();
}

class _ManageChildrenScreenState extends State<ManageChildrenScreen> {
  List<ChildModel> _children = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _children = widget.initialChildren.isNotEmpty
        ? widget.initialChildren
        : AppData().children;
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
          title: Text('My Children', style: AppTextStyles.heading),

        actions: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddChildScreen()));

              if (result != null && result is ChildModel) {
                setState(() {
                  AppData().children.add(result);
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: 24.38.w),
              padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFF6900),
                    Color(0xFFF54900),
                  ],
                ),
                borderRadius: BorderRadius.circular(14.26.r),

                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 2.04),
                    blurRadius: 4.07,
                    spreadRadius: -2.04),
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 4.07),
                    blurRadius: 6.11,
                    spreadRadius: -1.02),
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/icons/carpool_outlined.svg', width: 24.sp, height: 24.sp,
                      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                  SizedBox(width: 4.w),
                  Text('Add Child',
                      style: AppTextStyles.action.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Divider(color: Colors.grey.shade300, height: 2, thickness: 2))),

      body: _children.isEmpty
          ? Center(
        child: Text('No children added yet',
            style: AppTextStyles.medium.copyWith(color: Colors.grey)))
          : ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _children.length,
        itemBuilder: (_, i) {
          final child = _children[i];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: ChildCard(
              child: child,

              // View button
              onView: () async {
                final childToEdit = child;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChildDetailScreen(
                      child: childToEdit,
                      onEdit: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditChildScreen(child: childToEdit)));

                        if (result != null && result is ChildModel) {
                          setState(() {
                            final index = AppData().children.indexWhere((c) => c.id == childToEdit.id);
                            if (index != -1) AppData().children[index] = result;
                          });
                        }
                      },
                      onDelete: () => _confirmDeleteChild(i, isFromDetailScreen: true),
                    ),
                  ),
                );
                setState(() {});
              },


              // edit button
              onEdit: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditChildScreen(child: child)),
                );
                if (result != null)
                  setState(() => _children[i] = result);
              },

            //Delete button
              onDelete: () => _confirmDeleteChild(i,isFromDetailScreen: false),


            ).animate().fadeIn(delay: (i * 80).ms, duration: 300.ms),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  void _confirmDeleteChild(int index, {bool isFromDetailScreen = false}) {
    CustomDeleteDialog.show(
      context: context,
      title: 'Delete Child',
      message:
      'Are you sure you want to remove this child from your profile? This action cannot be undone.',
      onConfirm: () {
        setState(() {
          _children.removeAt(index);
          AppData().children.removeAt(index);
        });
        if (isFromDetailScreen) {
          Navigator.pop(context);
        }
      },
    );
  }
}