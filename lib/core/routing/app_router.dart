// core/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello/Feature/add_boarder/add_boarder_screen.dart';
import 'package:trello/Feature/meanu/meanu_screen.dart';
import 'package:trello/core/routing/routes.dart';

import '../../Feature/HomeProjects/homePage.dart';
import '../../Feature/HomeProjects/logic/board_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => BoardCubit()..getBoards(),
                child: const Homepage()),
              );

    // case Routes.loginScreen:
    //   return MaterialPageRoute(
    //     builder: (_) => BlocProvider(
    //         create: (context) => getIt<LoginCubit>(),
    //         child: const LoginScreen()),
    //   );
      case Routes.addBoarderScreen:
        return MaterialPageRoute(
          builder: (_) => const AddBoarderScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const MeanuScreen());


      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}

