import 'package:flutter/material.dart';
import '../data/list_books.dart';
import '../models/book.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  void _addBook() {
    String newTitle = '';
    int newQuantity = 1;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white, // Đặt nền dialog là màu trắng
          title: Text('Thêm sách'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Tên sách'),
                onChanged: (value) => newTitle = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Số lượng'),
                keyboardType: TextInputType.number,
                onChanged: (value) => newQuantity = int.tryParse(value) ?? 1,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (newTitle.isNotEmpty) {
                  setState(() {
                    dummyBooks.add(Book(
                      id: DateTime.now().toString(),
                      title: newTitle,
                      quantity: newQuantity,
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

  void _deleteBook(Book book) {
    setState(() {
      dummyBooks.remove(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý Sách')),
      backgroundColor: Colors.white, // Set background to white
      body: ListView(
        children: dummyBooks.map((book) {
          return ListTile(
            title: Text('${book.title} (Còn ${book.quantity} quyển)'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteBook(book),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        child: Icon(Icons.add),
      ),
    );
  }
}
