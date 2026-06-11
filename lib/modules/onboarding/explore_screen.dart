import 'package:carpooling/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_buttons.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const _menuItems = [
    ('Home:', 'Quick access to create carpools, manage invitations, view upcoming rides, find HadiKid parents, and track your child\'s trip in real time.'),
    ('Carpool:', 'Create carpools and invite trusted parents from your contact list to coordinate safe rides for school and activities.'),
    ('Inbox:', 'Send and receive messages, manage contact requests, and respond to carpool invitations.'),
    ('Notifications:', 'Stay updated on upcoming carpools, trip activity, invitations, and important alerts.'),
    ('Profile:', 'Manage your account, children\'s information, preferences, subscriptions, support, and more.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 40.h, 19.h, 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore',
                  style: AppTextStyles.headlineLarge),

               SizedBox(height: 19.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bodyText('Plan your child\'s school and activity rides safely and affordably with trusted parents through your shared ride network.'),
                       SizedBox(height: 12.h),
                      _bodyText('Only parents from your contact list can participate in carpools and volunteer as drivers.'),
                      SizedBox(height: 12.h),
                      RichText(
                        text: TextSpan(
                          style:AppTextStyles.medium,
                          children: [
                            const TextSpan(text: 'For additional details, please visit our '),
                            TextSpan(
                              text: 'Support',
                              style:AppTextStyles.medium.copyWith(color: AppColors.primary,decoration: TextDecoration.underline),
                            ),
                            const TextSpan(text: ' page.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _bodyText('Below you will find the names of the main menu buttons along with their use cases.'),
                       SizedBox(height: 20.h),

                      ..._menuItems.asMap().entries.map((entry) {
                        final (title, desc) = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 19.h),
                          child: RichText(
                            text: TextSpan(
                              style:AppTextStyles.medium,
                              children: [
                                TextSpan(
                                  text: title,
                                  style:AppTextStyles.medium.copyWith(color: AppColors.primary),
                                ),
                                TextSpan(text: ' $desc'),
                              ],
                            ),
                          )
                              .animate()
                              .fadeIn(delay: Duration(milliseconds: 80 * entry.key), duration: 400.ms)
                              .slideX(begin: 0.05),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              PrimaryButton(
                text: 'Next',
                onPressed: () => context.push(AppRoutes.signUp)),
               SizedBox(height: 20.h),
              PrimaryButton(
                text: 'How IT Works',
                onPressed: () => context.push(AppRoutes.howItWorks),
              ),
               SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyText(String text) => Text( text,
    style:AppTextStyles.medium,
  );
}