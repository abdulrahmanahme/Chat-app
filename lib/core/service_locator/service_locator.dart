import 'package:chat_app/feature/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/feature/auth/model/repositories/auth/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
 static void setup() {
    getIt.registerLazySingleton<AuthRepo>(()=>AuthRepo());
    getIt.registerLazySingleton<AuthCubit>(()=>AuthCubit(getIt()));

  }
  
}
