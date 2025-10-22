import 'book.dart';

class Student {
  final String id;
  final String name;
  List<Book> borrowedBooks;

  Student({
    required this.id,
    required this.name,
    required this.borrowedBooks,
  });
}
