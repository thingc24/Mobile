import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data_api.dart';

List<TaskDetail> allTasks = [];

Future<List<TaskDetail>> fetchAllTasks() async {
  try {
    final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/tasks'));

    print('Response status code: ${response.statusCode}');
    print('Response body length: ${response.body.length}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['isSuccess'] == true && jsonData['data'] != null) {
        final tasksList = jsonData['data'] as List;
        allTasks = tasksList.map((taskJson) => TaskDetail.fromJson(taskJson)).toList();
        // Sort tasks by ID to ensure order
        allTasks.sort((a, b) => a.id.compareTo(b.id));
        print('Fetched ${allTasks.length} tasks');
        return allTasks;
      } else {
        throw Exception('API returned success: false or no data');
      }
    } else {
      throw Exception('Failed to fetch tasks. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching tasks: $e');
    throw Exception('Network error: $e');
  }
}

// Fetch a single task by ID
Future<TaskDetail> fetchTaskById(int id) async {
  try {
    final response = await http.get(Uri.parse('https://amock.io/api/researchUTH/task/$id'));

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['isSuccess'] == true && jsonData['data'] != null) {
        return TaskDetail.fromJson(jsonData['data']);
      } else {
        throw Exception('API returned success: false or no data');
      }
    } else {
      throw Exception('Failed to fetch task $id. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching task $id: $e');
    throw Exception('Network error: $e');
  }
}

// Get next task in order from the loaded list
TaskDetail? getNextTask() {
  if (allTasks.isEmpty) {
    return null;
  }
  
  // Find current task index
  int currentIndex = 0;
  if (currentTask != null) {
    currentIndex = allTasks.indexWhere((task) => task.id == currentTask!.id);
    if (currentIndex == -1) currentIndex = 0;
  }
  
  // Get next task (cycle back to first if at end)
  int nextIndex = (currentIndex + 1) % allTasks.length;
  return allTasks[nextIndex];
}

// Get previous task in order from the loaded list
TaskDetail? getPreviousTask() {
  if (allTasks.isEmpty) {
    return null;
  }
  
  // Find current task index
  int currentIndex = 0;
  if (currentTask != null) {
    currentIndex = allTasks.indexWhere((task) => task.id == currentTask!.id);
    if (currentIndex == -1) currentIndex = 0;
  }
  
  // Get previous task (cycle to last if at beginning)
  int prevIndex = (currentIndex - 1 + allTasks.length) % allTasks.length;
  return allTasks[prevIndex];
}

// Keep track of current task for navigation
TaskDetail? currentTask;

// Keep the old function for backward compatibility
Future<TaskDetail> fetchTaskDetail() async {
  final tasks = await fetchAllTasks();
  if (tasks.isNotEmpty) {
    return tasks.first;
  }
  throw Exception('No tasks available');
}
