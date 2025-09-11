// core/routing/app_router.dart
import 'package:PlanMate/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Feature/Auth/logic/login_cubit.dart';
import '../../Feature/Auth/login_screen.dart';
import '../../Feature/Auth/sign_up_screen.dart';
import '../../Feature/Auth/widget/fake_splash_screen.dart';
import '../../Feature/HomeProjects/data/board_modal.dart';
import '../../Feature/HomeProjects/homePage.dart';
import '../../Feature/HomeProjects/logic/board_cubit.dart';
import '../../Feature/ProjectDetails/ProjectDetails.dart';
import '../../Feature/ProjectDetails/logic/list_cubit.dart';
import '../../Feature/add_boarder/add_boarder_screen.dart';
import '../../Feature/add_boarder/logic/add_poard_cubit.dart';
import '../../Feature/meanu/logic/menu_cubit/menu_cubit.dart';
import '../../Feature/meanu/meanu_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BoardCubit()..getBoards(),
            child: const Homepage(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case Routes.addBoarderScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddPoardCubit(),
            child: const AddBoarderScreen(),
          ),
        );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const SplashScreen(),
          ),
        );
      case Routes.projectDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(),
            child: ProjectDetails(boardId: arguments as Board),
          ),
        );
      case Routes.meanuScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BoardMembersCubit(),
            child: MeanuScreen(boardId: arguments as Board),
          ),
        );
      default:

        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
