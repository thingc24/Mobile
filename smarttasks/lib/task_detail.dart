import 'package:flutter/material.dart';
import 'data_api.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskDetail task;
  final VoidCallback onDelete;
  const TaskDetailPage({super.key, required this.task, required this.onDelete});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late Map<int, bool> subtaskStates;

  @override
  void initState() {
    super.initState();
    subtaskStates = {
      for (var sub in widget.task.subtasks)
        sub.id is int ? sub.id as int : int.tryParse(sub.id.toString()) ?? 0: sub.isCompleted
    };
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detail', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  widget.onDelete();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          const SizedBox(height: 6),
          Text(task.description, style: const TextStyle(fontSize: 18, color: Colors.black54)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iconText(Icons.apps, 'Category', task.category),
                _iconText(Icons.assignment, 'Status', task.statusText),
                _iconText(Icons.emoji_events, 'Priority', task.priority),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Subtasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          ...task.subtasks.map((sub) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final id = sub.id is int ? sub.id as int : int.tryParse(sub.id.toString()) ?? 0;
                      subtaskStates[id] = !(subtaskStates[id] ?? false);
                    });
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.5),
                      borderRadius: BorderRadius.circular(6),
                      color: (subtaskStates[sub.id is int ? sub.id as int : int.tryParse(sub.id.toString()) ?? 0] ?? false)
                          ? Colors.black
                          : Colors.transparent,
                    ),
                    child: (subtaskStates[sub.id is int ? sub.id as int : int.tryParse(sub.id.toString()) ?? 0] ?? false)
                        ? const Icon(Icons.check, size: 20, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(sub.titleString, style: const TextStyle(fontSize: 16))),
              ],
            ),
          )),
          if (task.attachments.isNotEmpty) ...[
            const SizedBox(height: 18),
            const Text('Attachments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 8),
            ...task.attachments.map((att) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, size: 26),
                  const SizedBox(width: 10),
                  Expanded(child: Text(att.fileName, style: const TextStyle(fontSize: 16))),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.black87),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
} 