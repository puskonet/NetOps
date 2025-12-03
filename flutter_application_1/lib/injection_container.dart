import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:dio/dio.dart';

import 'core/network/network_info.dart';
import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/data/datasources/task_remote_data_source.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/task_repository.dart';
import 'features/tasks/domain/usecases/get_todays_tasks.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print("🔵 [DEBUG] 1. Memulai init()...");
  sl.allowReassignment = true;

  //! --------------------- FEATURE: TASKS ---------------------
  print("🔵 [DEBUG] 2. Registering Bloc...");
  sl.registerFactory(() => TaskBloc(getTodaysTasks: sl()));

  print("🔵 [DEBUG] 3. Registering UseCase...");
  sl.registerLazySingleton(() => GetTodaysTasks(sl()));

  print("🔵 [DEBUG] 4. Registering Repository...");
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  print("🔵 [DEBUG] 5. Registering Remote Data Source...");
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(client: sl()),
  );

  print("🔵 [DEBUG] 6. Registering Local Data Source...");
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );

  //! ------------------------- CORE ---------------------------
  print("🔵 [DEBUG] 7. Registering Network Info...");
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! ------------------------ EXTERNAL ------------------------
  print("🔵 [DEBUG] 8. Registering Dio...");
  sl.registerLazySingleton(() => Dio());

  print("🔵 [DEBUG] 9. Registering InternetConnection...");
  // KITA PAKAI INSTANCE LANGSUNG UNTUK TES
  // Jika macet di sini, berarti library ini masalahnya
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

  print("🟢 [DEBUG] 10. SELESAI INIT! (Harusnya masuk UI)");
}
