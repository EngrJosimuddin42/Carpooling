import 'package:go_router/go_router.dart';
import '../modules/carpools/my_carpools_screen.dart';
import '../modules/carpools/nearby_families_screen.dart';
import '../modules/child/add_your_child_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/inbox/messages_screen.dart';
import '../modules/notifications/notifications_screen.dart';
import '../modules/onboarding/explore_screen.dart';
import '../modules/auth/forgot_password_screen.dart';
import '../modules/onboarding/how_it_works_screen.dart';
import '../modules/auth/otp_screen.dart';
import '../modules/auth/sign_in_screen.dart';
import '../modules/auth/sign_up_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/welcome/welcome_screen.dart';

class AppRoutes {
  static const splash          = '/';
  static const welcome         = '/welcome';
  static const howItWorks      = '/how-it-works';
  static const explore         = '/explore';
  static const signUp          = '/sign-up';
  static const signIn          = '/sign-in';
  static const otp             = '/otp';
  static const forgotPassword  = '/forgot-password';
  static const addChild        = '/add-child';
  static const nearbyFamilies  = '/nearby-families';
  static const home           = '/home';
  static const carpools       = '/carpools';
  static const messages       = '/messages';
  static const notifications  = '/notifications';
  static const profile        = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.profile,
  routes: [
    GoRoute(path: AppRoutes.splash,         builder: (c, s) => const SplashScreen()),
    GoRoute(path: AppRoutes.welcome,        builder: (c, s) => const WelcomeScreen()),
    GoRoute(path: AppRoutes.howItWorks,     builder: (c, s) => const HowItWorksScreen()),
    GoRoute(path: AppRoutes.explore,        builder: (c, s) => const ExploreScreen()),
    GoRoute(path: AppRoutes.signUp,         builder: (c, s) => const SignUpScreen()),
    GoRoute(path: AppRoutes.signIn,         builder: (c, s) => const SignInScreen()),
    GoRoute(path: AppRoutes.forgotPassword, builder: (c, s) => const ForgotPasswordScreen()),
    GoRoute(path: AppRoutes.addChild,       builder: (c, s) => const AddYourChildScreen()),
    GoRoute(path: AppRoutes.nearbyFamilies, builder: (c, s) => const NearbyFamiliesScreen()),
    GoRoute(path: AppRoutes.home,           builder: (c, s) => const HomeScreen()),
    GoRoute(path: AppRoutes.carpools,       builder: (c, s) => const MyCarpoolsScreen()),
    GoRoute(path: AppRoutes.messages,       builder: (c, s) => const MessagesScreen()),
    GoRoute(path: AppRoutes.notifications,  builder: (c, s) => const NotificationsScreen()),
    GoRoute(path: AppRoutes.profile,        builder: (c, s) => const ProfileScreen()),
    GoRoute(path: AppRoutes.otp,            builder: (c, s) {
      final extra = s.extra as Map<String, dynamic>? ?? {};
      return OtpScreen(phone: extra['phone'] ?? '', isSignUp: extra['isSignUp'] ?? true);
    }),
  ],
);