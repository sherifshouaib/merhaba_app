import 'package:go_router/go_router.dart';
import 'package:merhaba/features/home/presentation/views/new_post_view.dart';
import 'package:merhaba/features/login/presentation/manager/views/forget_password_view.dart';
import 'package:merhaba/features/login/presentation/manager/views/update_password_view.dart';
import 'package:merhaba/features/profile/presentation/views/app_settings_view.dart';
import 'package:merhaba/features/tabs/presentation/views/bottom_navbar_view.dart';
import 'package:merhaba/features/login/presentation/manager/views/login_view.dart';
import 'package:merhaba/features/create_account/presentation/views/create_account_view.dart';
import 'package:merhaba/features/welcome/presentation/views/welcome_view.dart';

abstract class AppRouter {
  static const kBottomNavigationPage = '/bottomNavigationPage';
  static const kLoginView = '/loginView';
  static const kCreateAccountView = '/createAccountView';
  static const kHomeView = '/homeView';
  static const kWelcomeView = '/welcomeView';
  static const kAppSettingsView = '/appSettingsView';
  static const kForgotPasswordView = '/forgotPasswordView';
  static const kUpdatePasswordView = '/updatePasswordView';
  static const kNewPostView = '/newPostView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(
        path: kCreateAccountView,
        builder: (context, state) => CreateAccountView(),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => BottomNavBarView()),
      GoRoute(
        path: kAppSettingsView,
        builder: (context, state) => AppSettingsView(),
      ),
      GoRoute(
        path: kForgotPasswordView,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: kUpdatePasswordView,
        builder: (context, state) => const UpdatePasswordView(),
      ),
      GoRoute(
        path: kNewPostView,
        builder: (context, state) => const NewPostView(),
      ),
    ],
  );
}
