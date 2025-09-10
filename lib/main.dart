import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Feature/HomeProjects/data/board_modal.dart';
import 'Feature/meanu/invite_persone_screen.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://imsnygprhtjicswjqhva.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc255Z3ByaHRqaWNzd2pxaHZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxNjc4MTIsImV4cCI6MjA3MDc0MzgxMn0.71itxd88DHE2Bu1jFuFlkEn3RPTQSgGh8GCLJobP_KE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: Routes.splashScreen,
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
