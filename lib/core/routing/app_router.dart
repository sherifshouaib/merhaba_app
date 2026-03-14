import 'package:go_router/go_router.dart';
import 'package:merhaba/features/login/presentation/manager/views/login_view.dart';
import 'package:merhaba/features/register/presentation/views/register_view.dart';
import 'package:merhaba/features/welcome/presentation/views/welcome_view.dart';

abstract class AppRouter {
  static const kBottomNavigationPage = '/bottomNavigationPage';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kHomeView = '/homeView';
  static const kWelcomeView = '/welcomeView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(path: kRegisterView, builder: (context, state) => RegisterView()),
    ],
  );
}



// class AppRouter {    
  
//    // you can use gorouter or generaterouter to navigate between screens
//    //,but omar ahmed used generaterouter and said it's up to you 

//   Route generateRoute(RouteSettings settings){
//     switch (settings.name) {
//       // case Routes.loginScreen:
//       //   return MaterialPageRoute(builder: (_) => const LoginScreen());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }