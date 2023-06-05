import 'package:booksharing_service_app/models/user_model.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _phoneNumberController.text = widget.user.phoneNumber;
    _addressController.text = widget.user.address;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              controller: _phoneNumberController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              controller: _addressController,
            ),
            // Add other necessary form fields for editing account details
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateAccountDetails();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _updateAccountDetails() {
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneNumberController.text;
    String newAddress = _addressController.text;
    // Retrieve other updated values from the respective controllers

    // Validate the input and perform necessary checks

    // Update the user object with the new values
    widget.user.name = newName;
    widget.user.email = newEmail;
    widget.user.phoneNumber = newPhoneNumber;
    widget.user.address = newAddress;

    // Save the changes to the user object or update it in the database

    // Optionally, show a success message or navigate to a different page
  }
}
