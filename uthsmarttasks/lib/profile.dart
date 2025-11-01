import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String dateOfBirth;
  final String avatarUrl;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.avatarUrl,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  File? _avatarImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    dobController = TextEditingController(text: widget.dateOfBirth);
    _loadDateOfBirthFromFirestore();
    _ensureUserDocument();
  }

  Future<void> _loadDateOfBirthFromFirestore() async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.email);
    final docSnapshot = await userDoc.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null && data['dateOfBirth'] != null && data['dateOfBirth'].toString().isNotEmpty) {
        setState(() {
          dobController.text = data['dateOfBirth'];
        });
      }
    }
  }

  Future<void> _ensureUserDocument() async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.email);
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'name': widget.name,
        'email': widget.email,
        'avatarUrl': widget.avatarUrl,
        'dateOfBirth': widget.dateOfBirth,
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveDateOfBirthToFirestore(String dob) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.email);
      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'name': widget.name,
          'email': widget.email,
          'avatarUrl': widget.avatarUrl,
          'dateOfBirth': dob,
        });
      } else {
        await userDoc.set({'dateOfBirth': dob}, SetOptions(merge: true));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save date of birth: $e')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: _avatarImage != null
                              ? FileImage(_avatarImage!)
                              : NetworkImage(widget.avatarUrl) as ImageProvider,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter your name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter your email',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  const Text('Date of Birth', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 36),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(widget.dateOfBirth.split('/').reversed.join('-')) ?? DateTime(1995, 5, 23),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        final formattedDate = '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
                        setState(() {
                          dobController.text = formattedDate;
                        });
                        await _saveDateOfBirthToFirestore(formattedDate);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
