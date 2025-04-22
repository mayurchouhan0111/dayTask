import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool completed;
  final VoidCallback? onDelete;
  final VoidCallback? onToggle;

  const TaskTile({
    Key? key,
    required this.title,
    required this.completed,
    this.onDelete,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              decoration: completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.check,
                color: completed ? Colors.green : Colors.grey),
            onPressed: onToggle,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
