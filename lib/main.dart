import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_bloc.dart';
import 'package:petapp/bloc/theme_bloc/theme_bloc.dart';
import 'package:petapp/bloc/theme_bloc/theme_state.dart';
import 'package:petapp/core/theme/theme_data.dart';
import 'package:petapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true, 
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(create: (_) => AdoptionBloc()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: state.themeMode,
                title: 'Pet Adoption App',
                debugShowCheckedModeBanner: false,
                home:  HomeScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
