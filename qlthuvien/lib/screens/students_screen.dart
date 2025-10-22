import 'package:flutter/material.dart';
import '../data/list_students.dart';
import '../models/student.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  void _addStudent() {
    String newName = '';

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Thêm sinh viên'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Tên sinh viên'),
            onChanged: (value) => newName = value,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (newName.isNotEmpty) {
                  setState(() {
                    dummyStudents.add(Student(
                      id: DateTime.now().toString(),
                      name: newName,
                      borrowedBooks: [],
                    ));
                  });
                }
                Navigator.of(ctx).pop();
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(Student student) {
    setState(() {
      dummyStudents.remove(student);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý Sinh viên')),
      body: ListView(
        children: dummyStudents.map((student) {
          return ListTile(
            title: Text(student.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteStudent(student),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        child: Icon(Icons.add),
      ),
    );
  }
}
