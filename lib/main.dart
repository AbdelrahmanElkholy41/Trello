import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trello/Feature/HomeProjects/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://imsnygprhtjicswjqhva.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc255Z3ByaHRqaWNzd2pxaHZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxNjc4MTIsImV4cCI6MjA3MDc0MzgxMn0.71itxd88DHE2Bu1jFuFlkEn3RPTQSgGh8GCLJobP_KE',
  );
  print('Supabase initialized successfully');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // مقاسات التصميم الأساسي
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: Homepage(),
    );
  }
}
