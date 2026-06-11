import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_buttons.dart';


class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  static const _steps = [
    ('Step - 01:', 'Create a carpool between two points.'),
    ('Step - 02:', 'Invite your friends to carpool with you.'),
    ('Step - 03:', 'Friends join and add their child\'s location.'),
    ('Step - 04:', 'Parents Volunteer to Drive. We Send reminders and optimized routes.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text('How It Works',
                  style: AppTextStyles.headlineLarge.copyWith(height: 1.2)),

              SizedBox(height: 16.h),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                  itemCount: _steps.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, i) {
                    final (title, desc) = _steps[i];
                    return _StepTile(title: title, description: desc, index: i)
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 100 * i), duration: 400.ms)
                        .slideX(begin: 0.1);
                  },
                ),

              SizedBox(height: 20.h),

              PrimaryButton(
                text: 'Next',
                  onPressed: () => context.push(AppRoutes.signUp)),

              SizedBox(height: 20.h),
              PrimaryButton(
                text: 'Explore',
                onPressed: () => context.push(AppRoutes.explore),
              ),
               SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final String title;
  final String description;
  final int index;

  const _StepTile({
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.title),
         SizedBox(height: 8.h),
        Text(description,
            style: AppTextStyles.medium),
      ],
    );
  }
}