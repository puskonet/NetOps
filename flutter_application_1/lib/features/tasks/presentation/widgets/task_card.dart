import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Logic warna status
    Color statusColor = task.status == 'Completed'
        ? Colors.green
        : Colors.orange;

    if (!task.isSynced) statusColor = Colors.grey;

    // 🔥 FIX RangeError di sini
    final String shortId = (task.id.isNotEmpty)
        ? task.id.substring(0, task.id.length >= 4 ? 4 : task.id.length)
        : "----"; // fallback kalau id kosong

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER: ID & STATUS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "#$shortId",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),

                  _buildStatusChip(context, task.status, statusColor),
                ],
              ),

              const SizedBox(height: 12),

              // JUDUL TUGAS
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // ALAMAT
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      task.address,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const Divider(height: 24),

              // FOOTER SYNC STATUS
              Row(
                children: [
                  Icon(
                    task.isSynced ? Icons.cloud_done : Icons.cloud_off,
                    size: 14,
                    color: task.isSynced ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    task.isSynced ? "Data Terkirim" : "Belum Sinkron (Offline)",
                    style: TextStyle(
                      fontSize: 12,
                      color: task.isSynced ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
