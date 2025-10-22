import 'package:flutter/material.dart';
import '../data/list_books.dart';
import '../data/list_students.dart';
import '../models/student.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  Student? selectedStudent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hệ thống Quản lý Thư viện'),
      ),
      backgroundColor: Colors.white, // Set background to white
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Chọn sinh viên', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 56, // Chiều cao cho dropdown
                child: DropdownButton<Student>(
                  isExpanded: true,
                  value: selectedStudent,
                  hint: Text('Chọn sinh viên'),
                  dropdownColor: Colors.white,
                  items: dummyStudents
                      .map((student) {
                        return DropdownMenuItem<Student>(
                          value: student,
                          child: Text(student.name),
                        );
                      })
                      .toList(),
                  onChanged: (Student? newValue) {
                    setState(() {
                      selectedStudent = newValue;
                    });
                  },
                  underline: SizedBox(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Danh sách sách đã mượn', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 180,
                child: selectedStudent == null
                    ? Center(child: Text('Chọn sinh viên để xem sách đã mượn'))
                    : ListView.builder(
                        itemCount: selectedStudent!.borrowedBooks.length,
                        itemBuilder: (context, index) {
                          final book = selectedStudent!.borrowedBooks[index];
                          return Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blue, width: 1),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                            child: ListTile(
                              title: Text(
                                book.title,
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.blue),
                                onPressed: () {
                                  setState(() {
                                    selectedStudent!.borrowedBooks.remove(book);
                                    book.quantity += 1;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedStudent == null) return;
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      final availableBooks = dummyBooks.where((b) => b.quantity > 0).toList();
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text('Chọn sách để mượn'),
                        content: Container(
                          color: Colors.white,
                          width: double.maxFinite,
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: availableBooks.length,
                            itemBuilder: (context, index) {
                              final book = availableBooks[index];
                              return ListTile(
                                title: Text('${book.title} (Còn ${book.quantity} quyển)'),
                                onTap: () {
                                  setState(() {
                                    selectedStudent!.borrowedBooks.add(book);
                                    book.quantity -= 1;
                                  });
                                  Navigator.of(ctx).pop();
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Mượn sách'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
