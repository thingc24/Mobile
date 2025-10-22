import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentTile extends StatelessWidget {
  final Student student;
  final VoidCallback? onTap;

  const StudentTile({required this.student, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(student.name),
      subtitle: Text('Đã mượn ${student.borrowedBooks.length} sách'),
      onTap: onTap,
    );
  }
}
