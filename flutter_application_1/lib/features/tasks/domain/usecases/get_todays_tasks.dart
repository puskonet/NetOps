import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTodaysTasks {
  final TaskRepository repository;

  GetTodaysTasks(this.repository);

  Future<Either<Failure, List<Task>>> call() async {
    return await repository.getTodaysTasks();
  }
}
