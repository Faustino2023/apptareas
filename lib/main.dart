import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: TaskList(tasks: tasks, onToggle: toggleTask),
          ),
          TaskInput(onAddTask: addTask),
        ],
      ),
    );
  }

  void addTask(String newTaskTitle) {
    setState(() {
      tasks.add(Task(title: newTaskTitle));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onToggle;

  TaskList({required this.tasks, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(
          title: task.title,
          isDone: task.isDone,
          onToggle: () {
            onToggle(index);
          },
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;

  TaskTile({required this.title, required this.isDone, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isDone,
        onChanged: (newValue) {
          onToggle();
        },
      ),
    );
  }
}

class TaskInput extends StatelessWidget {
  final Function(String) onAddTask;

  TaskInput({required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                newTaskTitle = value;
              },
              decoration: InputDecoration(
                hintText: 'Ingrese una nueva tarea',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onAddTask(newTaskTitle);
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
