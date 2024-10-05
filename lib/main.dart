import 'package:chat_app/core/service_locator/service_locator.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/view/login_screen.dart';
import 'package:chat_app/feature/auth/view/signup_screen.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/view/all_users_screen.dart';

import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var globleKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServiceLocator.setup();
  runApp(MultiBlocListener(listeners: [
    BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: LoginScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: SignUpScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<ChatCubit>()..fetchAllUsers(),
      child: AllUsersScreen(),
    ),
   
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chap App',
          navigatorKey: globleKey,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              fontFamily: 'inter'),
          home: child,
        );
      },
      child: LoginScreen(),
    );
  }
}
