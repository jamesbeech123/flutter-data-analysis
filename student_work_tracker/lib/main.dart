import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> _tasks = [];

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void _addTask() async {
    final controller = TextEditingController();
    final newTask = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter task"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text("Add"),
          ),
        ],
      ),
    );

    if (newTask != null && newTask.trim().isNotEmpty) {
      setState(() {
        _tasks.add(newTask.trim());
      });

    // Log event to Google Analytics
    await analytics.logEvent(
      name: 'task_added',
      parameters: {'task_name': newTask.trim()},
    );


    }
  }

  void _editTask(int index) async {
    final controller = TextEditingController(text: _tasks[index]);
    final updatedTask = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Update task"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (updatedTask != null && updatedTask.trim().isNotEmpty) {
      setState(() {
        _tasks[index] = updatedTask.trim();
      });

    // Log event to Google Analytics
    await analytics.logEvent(
      name: 'task_updated',
      parameters: {'task_name': updatedTask.trim()},
    );
    }
  }

  void _deleteTask(int index) {
    final deletedTask = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
    });

    // Log event to Google Analytics
     analytics.logEvent(
      name: 'task_deleted',
      parameters: {'task_name': deletedTask},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text("No tasks yet. Add one!"))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_tasks[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editTask(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
