import 'dart:io';

import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditAccountPage extends StatefulWidget {
  final UserModel user;

  EditAccountPage({required this.user});

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  File? _coverImageFile;
  File? _profileImageFile;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _phoneNumberController.text = widget.user.phoneNumber;
    _addressController.text = widget.user.address;
    _bioController.text = widget.user.bio;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Account Details',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              controller: _nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
              controller: _bioController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              controller: _phoneNumberController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
              controller: _addressController,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                _selectCoverImage();
              },
              child: const Text('Change Cover Image'),
            ),
            TextButton(
              onPressed: () {
                _selectProfileImage();
              },
              child: const Text('Change Profile Image'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        onPressed: () {
          _updateAccountDetails();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  void _selectCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _coverImageFile = File(pickedFile.path);
      });
    }
  }

  void _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImageToStorage(File file) async {
    final imageUrl = await FirebaseStorageService.uploadFile(file);
    return imageUrl;
  }

  void _updateAccountDetails() async {
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newAddress = _addressController.text;
    String newBio = _bioController.text;

    if (_coverImageFile != null) {
      // Upload cover image to storage
      final coverImageUrl = await _uploadImageToStorage(_coverImageFile!);
      widget.user.coverImageUrl = coverImageUrl;
    }

    if (_profileImageFile != null) {
      // Upload profile image to storage
      final profileImageUrl = await _uploadImageToStorage(_profileImageFile!);
      widget.user.profilePictureUrl = profileImageUrl;
    }

    // Update the user object with the new values
    UserModel _user = UserModel(
      id: widget.user.id,
      name: newName,
      email: newEmail,
      phoneNumber: newPhoneNumber,
      address: newAddress,
      coverImageUrl: widget.user.coverImageUrl,
      profilePictureUrl: widget.user.profilePictureUrl,
      isAdmin: false,
      bio: newBio,
    );

    // Save the changes to the user object or update it in the firestore database
    try {
      // Update the user object in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.id)
          .update(_user.toMap());

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account details updated successfully!'),
        ),
      );

      // Navigate back to the previous page
      Navigator.of(context).pop();
    } catch (error) {
      // Handle the error
      print('Error updating user: $error');
    }
    // Navigate back to the previous page
    Navigator.of(context).pop();
  }
}
