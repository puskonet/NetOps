import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.address,
    required super.status,
    required super.isSynced,
  });

  // Dari API
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      address: json['address'] ?? 'Lokasi belum ditentukan',
      status: json['status'] ?? 'New',
      isSynced: true, // data API dianggap sudah synced
    );
  }

  // Untuk simpan ke SQLite
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'status': status,
      'isSynced': isSynced ? 1 : 0, // SQLite simpan boolean → int
    };
  }

  // Dari SQLite ke Model
  factory TaskModel.fromTable(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'].toString(),
      title: map['title'],
      address: map['address'],
      status: map['status'],
      isSynced: map['isSynced'] == 1, // int → bool
    );
  }
}
