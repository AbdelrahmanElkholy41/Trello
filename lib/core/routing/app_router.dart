// // core/routing/app_router.dart
// import 'package:flutter/material.dart';
//
//
// class AppRouter {
//   Route generateRoute(RouteSettings settings) {
//     //this arguments to be passed in any screen like this ( arguments as ClassName )
//     final arguments = settings.arguments;
//
//     switch (settings.name) {
//       case Routes.onBoardingScreen:
//         return MaterialPageRoute(
//           builder: (_) => const OnboardingScreen(),
//         );
//       case Routes.loginScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider(
//               create: (context) => getIt<LoginCubit>(),
//               child: const LoginScreen()),
//         );
//
//       case Routes.homeScreen:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//       case Routes.signUpScreen:
//         return MaterialPageRoute(builder: (_) => const SignUpScreen());
//
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
