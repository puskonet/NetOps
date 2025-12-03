import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../datasources/task_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Task>>> getTodaysTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final tasks = await remoteDataSource.getAllTasks();
        await localDataSource.cacheTasks(tasks);
        return Right(tasks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final tasks = await localDataSource.getLastTasks();
        return Right(tasks);
      } catch (_) {
        return Left(CacheFailure());
      }
    }
  }
}
