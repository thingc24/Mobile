import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'get_api.dart';
import 'data_api.dart';
import 'task_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskDetail> allTasks = [];
  List<TaskDetail> displayedTasks = [];
  Map<int, bool> checkboxStates = {}; // Track checkbox states locally
  int nextTaskIndex = 1;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
    try {
      final tasks = await fetchAllTasks();
      setState(() {
        allTasks = tasks;
        displayedTasks = tasks.isNotEmpty ? [tasks.first] : [];
        // Initialize checkbox states
        checkboxStates = {};
        for (var task in displayedTasks) {
          checkboxStates[task.id] = task.statusText.toLowerCase() == 'completed';
        }
        nextTaskIndex = 1;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void addNextTask() {
    if (nextTaskIndex < allTasks.length) {
      setState(() {
        final newTask = allTasks[nextTaskIndex];
        displayedTasks.add(newTask);
        checkboxStates[newTask.id] = newTask.statusText.toLowerCase() == 'completed';
        nextTaskIndex++;
      });
    }
  }

  void toggleCheckbox(int taskId) {
    setState(() {
      checkboxStates[taskId] = !(checkboxStates[taskId] ?? false);
    });
  }

  void deleteTask(int taskId) {
    setState(() {
      allTasks.removeWhere((task) => task.id == taskId);
      displayedTasks.removeWhere((task) => task.id == taskId);
      checkboxStates.remove(taskId);
      // Adjust nextTaskIndex if a task before it was deleted
      if (nextTaskIndex > displayedTasks.length) {
        nextTaskIndex = displayedTasks.length; // Prevent index out of bounds
      }
    });
  }

  Color getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return const Color(0xFFE3BFC2);
      case 'personal':
        return const Color(0xFFE7E8C3);
      case 'fitness':
        return const Color(0xFFC7E7F3);
      case 'travel':
        return const Color(0xFFE8D4F0);
      case 'finance':
        return const Color(0xFFF0E6CC);
      case 'hobby':
        return const Color(0xFFCCE8F0);
      case 'education':
        return const Color(0xFFD4F0E8);
      default:
        return const Color(0xFFE3BFC2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(0),
              child: Image.asset('assets/images/logo-uth.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('SmartTasks', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24)),
                SizedBox(height: 2),
                Text('A simple and efficient to-do app', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications, color: Colors.amber, size: 32),
                    Positioned(
                      right: 0,
                      top: -2,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text('Error: $error'))
              : displayedTasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        ...displayedTasks.map((task) => buildTaskCard(
                          task: task,
                          title: task.title,
                          description: task.description,
                          status: checkboxStates[task.id] == true ? 'Completed' : task.statusText,
                          date: DateFormat('HH:mm yyyy-MM-dd').format(task.dueDateTime),
                          color: getColorForCategory(task.category),
                          isChecked: checkboxStates[task.id] ?? false,
                          onCheckboxChanged: () => toggleCheckbox(task.id),
                          onDelete: () => deleteTask(task.id),
                        )),
                        const SizedBox(height: 12),
                      ],
                    ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          height: 50,
          child: BottomAppBar(
            color: Colors.transparent,
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home, color: Colors.blue, size: 32),
                Icon(Icons.calendar_today, color: Colors.grey, size: 28),
                SizedBox(width: 48),
                Icon(Icons.description, color: Colors.grey, size: 28),
                Icon(Icons.settings, color: Colors.grey, size: 28),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNextTask,
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildTaskCard({
    required String title,
    required String description,
    required String status,
    required String date,
    required Color color,
    required bool isChecked,
    required VoidCallback onCheckboxChanged,
    TaskDetail? task,
    VoidCallback? onDelete,
  }) {
    return GestureDetector(
      onTap: task != null
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetailPage(task: task, onDelete: onDelete!),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckbox(
                  isChecked: isChecked,
                  onChanged: onCheckboxChanged,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(description, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status: $status', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(date, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onChanged;
  const CustomCheckbox({super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.5),
          borderRadius: BorderRadius.circular(6),
          color: isChecked ? Colors.black : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(Icons.check, size: 20, color: Colors.white)
            : null,
      ),
    );
  }
}