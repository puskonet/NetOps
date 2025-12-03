import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getAllTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio client;

  TaskRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      // SET timeout HARUS pakai Duration
      final response = await client.get(
        'https://jsonplaceholder.typicode.com/todos',
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;

        return jsonList.take(5).map((json) {
          return TaskModel(
            id: json['id'].toString(),
            title: json['title'],
            address: "Lokasi belum set",
            status: json['completed'] == true ? "Completed" : "New",
            isSynced: true, // harus boolean bukan int
          );
        }).toList();
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
