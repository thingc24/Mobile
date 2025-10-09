import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Thuchanh02(),
    );
  }
}

class Thuchanh02 extends StatefulWidget {
  const Thuchanh02({super.key});

  @override
  State<Thuchanh02> createState() => _Thuchanh02State();
}

class _Thuchanh02State extends State<Thuchanh02> {
  final TextEditingController _controller = TextEditingController();
  List<int> numbers = [];
  String? errorMessage;

  void _generate() {
    setState(() {
      numbers.clear();
      errorMessage = null;
      try {
        int count = int.parse(_controller.text);
        if (count <= 0) {
          errorMessage = "Dữ liệu bạn nhập không hợp lệ";
        } else {
          numbers = List.generate(count, (index) => index + 1);
        }
      } catch (e) {
        errorMessage = "Dữ liệu bạn nhập không hợp lệ";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text(
                "Thực hành 02",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Nhập vào số lượng",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: _generate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                    ),
                    child: const Text(
                      "Tạo",
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        numbers[index].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
