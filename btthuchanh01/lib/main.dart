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
      home: Thuchanh01(),
    );
  }
}

class Thuchanh01 extends StatefulWidget {
  const Thuchanh01({super.key});

  @override
  State<Thuchanh01> createState() => _Thuchanh01State();
}

class _Thuchanh01State extends State<Thuchanh01> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? result;

  void _checkAge() {
    FocusScope.of(context).unfocus();
    String name = _nameController.text.trim();
    String ageText = _ageController.text.trim();

    if (name.isEmpty || ageText.isEmpty) {
      setState(() {
        result = "Vui lòng nhập đầy đủ thông tin!";
      });
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null || age < 0) {
      setState(() {
        result = "Tuổi không hợp lệ!";
      });
      return;
    }

    String type;
    if (age > 65) {
      type = "Người già";
    } else if (age > 6) {
      type = "Người lớn";
    } else if (age > 2) {
      type = "Trẻ em";
    } else {
      type = "Em bé";
    }

    setState(() {
      result = "$name là $type ($age tuổi)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "THỰC HÀNH 01",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Họ và tên + Tuổi
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Họ và tên
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Họ và tên:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tuổi
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Tuổi:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Nút kiểm tra
                ElevatedButton(
                  onPressed: _checkAge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Kiểm tra",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                // Hiển thị kết quả
                if (result != null)
                  Text(
                    result!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: result!.contains("không hợp lệ") ||
                          result!.contains("Vui lòng")
                          ? Colors.red
                          : Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
