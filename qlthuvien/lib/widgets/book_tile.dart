import 'package:flutter/material.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookTile({required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(book.quantity > 0 ? Icons.book : Icons.cancel, color: Colors.blue),
      title: Text(book.title),
      subtitle: Text('Còn ${book.quantity} quyển'),
      trailing: onTap != null ? Icon(Icons.add, color: Colors.blue) : null,
      onTap: onTap,
    );
  }
}
