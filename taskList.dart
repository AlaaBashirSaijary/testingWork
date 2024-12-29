import 'package:flutter/material.dart';

import 'addtask.dart';
import 'edittask.dart';

class Task {
  String title;
  String description;
  bool isCompleted;

  Task({required this.title, required this.description, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(title: 'Go to market', description: 'Buy groceries'),
    Task(title: 'Going to Syria', description: 'Prepare trip'),
    Task(title: 'Do my code', description: 'Finish Flutter project'),
  ];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void editTask(int index, Task updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salam, Alaa Saijary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'alaa@gmail.com',
                  style: TextStyle(
                    color: Color.fromARGB(255, 247, 231, 231),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://user-images.githubusercontent.com/13468728/233847739-219cb494-c265-4554-820a-bd3424c59065.jpg'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Main Container for "Go Pro (No Ads)"
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFACEB5F),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: Colors.yellow[700],
                  size: 40.0,
                ),
                SizedBox(width: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Go Pro (No Ads)',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.0),
                        ],
                      ),
                      Text(
                        'No fuss, no ads, for only 5 TL a year',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                // Small container for "TL 5"
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                   
                  ),
                  child: Text(
                    'TL 5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Adding space between cards
                  child: Card(
                    elevation: 5, // Add shadow for better visibility
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0), // Add padding inside the card
                      leading: IconButton(
                        icon: Icon(
                          tasks[index].isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: tasks[index].isCompleted ? Colors.green : Colors.grey,
                          size: 30, // Increase icon size
                        ),
                        onPressed: () => toggleTaskCompletion(index),
                      ),
                      title: Text(
                        tasks[index].title,
                        style: TextStyle(
                          fontSize: 16.0, // Increase font size
                          fontWeight: FontWeight.bold, // Make title bold
                          decoration: tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        tasks[index].description,
                        style: TextStyle(fontSize: 14.0), // Increase subtitle font size
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTaskScreen(
                                    task: tasks[index],
                                    onSave: (updatedTask) =>
                                        editTask(index, updatedTask),
                                  ),
                                ),
                              );
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.black, fontSize: 14.0),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          MaterialButton(
                            onPressed: () => deleteTask(index),
                            color: const Color.fromARGB(255, 253, 250, 249),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.black, fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                onSave: (newTask) => addTask(newTask),
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
