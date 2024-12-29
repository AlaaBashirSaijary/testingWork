import 'package:flutter/material.dart';
import 'taskList.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  final Function(Task) onSave;

  EditTaskScreen({required this.task, required this.onSave});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;
    descriptionController.text = task.description;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Edit Task: ',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 8), // Add a small space between the text
            Text(
              task.title, // Display the task title next to "Edit Task"
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: task.isCompleted,
                );
                onSave(updatedTask);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
