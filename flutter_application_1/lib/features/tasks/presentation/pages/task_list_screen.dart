import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Service Locator (Mundur 4 folder ke root)
import '../../../../injection_container.dart';

// Import Bloc (Sesama fitur tasks)
import '../bloc/task_bloc.dart';

// Import Widget (Sesama fitur tasks)
import '../widgets/task_card.dart';

// Import Detail Screen (Satu folder)
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo, Teknisi",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              "Dashboard Tugas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TaskBloc>().add(GetTasksEvent());
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocProvider(
        create: (_) => sl<TaskBloc>()..add(GetTasksEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Daftar Pekerjaan Hari Ini",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TaskLoaded) {
                      if (state.tasks.isEmpty) {
                        return const Center(child: Text("Tidak ada tugas."));
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<TaskBloc>().add(GetTasksEvent());
                        },
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: state.tasks[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      task: state.tasks[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is TaskError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
