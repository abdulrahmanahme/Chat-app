// import 'package:chat_app/core/service_locator/service_locator.dart';
// import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
// import 'package:chat_app/feature/auth/view/login_screen.dart';
// import 'package:chat_app/feature/auth/view/signup_screen.dart';
// import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
// import 'package:chat_app/feature/chat/view/all_users_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../feature/chat/view/home/chat_screen_home.dart';

// class AppRouter {
//   static Route generateRout(RouteSettings routeSettings) {
//     var args = routeSettings.arguments;

//     switch (routeSettings.name) {
//       case Routes.loginScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider(
//             create: (context) => getIt<AuthCubit>(),
//             child: LoginScreen(),
//           ),
//         );
//       case Routes.chatScreen:
//         // final String userName;
//         return MaterialPageRoute(
//           builder: (_) => ChatScreenHome(),
//         );
//       case Routes.signUpScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider(
//             create: (context) => getIt<AuthCubit>(),
//             child: SignUpScreen(),
//           ),
//         );
//         case Routes.allUsersScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider(
//             create: (context) => getIt<ChatCubit>(),
//             child:const AllUsersScreen(),
//           ),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child:
//                   Text('No routes defined for this page ${routeSettings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }
