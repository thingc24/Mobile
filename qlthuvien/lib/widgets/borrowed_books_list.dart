import 'package:flutter/material.dart';
import '../models/book.dart';

class BorrowedBooksList extends StatelessWidget {
  final List<Book> books;
  final Function(Book)? onRemove;

  const BorrowedBooksList({required this.books, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? Center(child: Text('Bạn chưa mượn quyển sách nào'))
        : ListView(
      children: books.map((book) {
        return ListTile(
          leading: Icon(Icons.check_box, color: Colors.blue),
          title: Text(book.title),
          trailing: onRemove != null
              ? IconButton(
            icon: Icon(Icons.delete, color: Colors.blue),
            onPressed: () => onRemove!(book),
          )
              : null,
        );
      }).toList(),
    );
  }
}
