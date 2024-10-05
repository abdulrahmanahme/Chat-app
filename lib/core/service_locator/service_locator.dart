import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/model/repositories/auth/auth_repo.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/model/repositories/chat_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    /// Auth repo
    getIt.registerLazySingleton<AuthRepo>(() => AuthRepo());

    //// Auth chat
    getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));

    //// Cubit chat
    getIt.registerLazySingleton<ChatRepo>(() => ChatRepo());

    ///Chat repo
    getIt.registerLazySingleton<ChatCubit>(() => ChatCubit(getIt()));
  }
}
