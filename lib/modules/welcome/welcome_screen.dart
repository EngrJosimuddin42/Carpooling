import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_buttons.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
               SizedBox(height: 200.h),
              // Title
              Text('Welcome to HadiKid',
                style: AppTextStyles.displayMedium,
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

               SizedBox(height: 24.h),

              // Subtitle
              Text("Let's get you started. No carpools yet! Get started by creating a carpool and sending invite.",
                style: AppTextStyles.medium,
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

              SizedBox(height: 48.h),
              // Logo
              SvgPicture.asset('assets/images/hadikid_logo.svg', width: 330.w)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.2, duration: 500.ms),

               SizedBox(height: 48.h),

              // Explore + How It Works row
              Row(
                children: [
                  Expanded(
                    child: OutlineButton2(
                      text: 'Explore',
                      onPressed: () => context.push(AppRoutes.explore),
                    ),
                  ),

                  SizedBox(width: 12.h),

                  Expanded(
                    child: OutlineButton2(
                      text: 'How It Works',
                      onPressed: () => context.push(AppRoutes.howItWorks),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

               SizedBox(height: 12.h),

              // Let's get started
              PrimaryButton(
                text: "Let's get started",
                onPressed: () => context.push(AppRoutes.signUp),
              ).animate().fadeIn(delay: 500.ms, duration: 500.ms),

               SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}