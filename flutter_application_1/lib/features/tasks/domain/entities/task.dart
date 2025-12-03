import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String address;
  final String status; // New, Completed, In Progress
  final bool isSynced; // true = sudah sinkron ke server

  const Task({
    required this.id,
    required this.title,
    required this.address,
    required this.status,
    this.isSynced = true,
  });

  @override
  List<Object?> get props => [id, title, address, status, isSynced];
}
