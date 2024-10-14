import 'package:asugs/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  //text editing controllers
  final stringController = TextEditingController();
  final intController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final datetimeController = TextEditingController();

  //sendData method
  void sendData() async {
    // Define the API endpoint
    final url = Uri.parse('http://10.130.1.143:5000/send-data');

    // Create the request body
    final body = jsonEncode({'email': ()});

    //send the POST request
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Data sent successfully!');
      } else {
        print('Failed to send data. Error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Date Picker
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  // Time Picker
  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context); // Format as HH:MM
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Image.asset(
          'assets/images/banner_logo_maroon.png',
          fit: BoxFit.contain,
          height: 40,
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "Add New Data Entry",
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  // String data field
                  _buildTextField(
                    controller: stringController,
                    hintText: 'String Data',
                  ),
                  const SizedBox(height: 30),

                  // Int data field
                  _buildTextField(
                    controller: intController,
                    hintText: 'Int Data',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),

                  // Date Picker field
                  GestureDetector(
                    onTap: _selectDate,
                    child: _buildTextField(
                      controller: dateController,
                      hintText: 'Date (MM/DD/YYYY)',
                      enabled: false, // Disable manual editing
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Time Picker field
                  GestureDetector(
                    onTap: _selectTime,
                    child: _buildTextField(
                      controller: timeController,
                      hintText: 'Time (12:15 PM)',
                      enabled: false, // Disable manual editing
                    ),
                  ),
                  const SizedBox(height: 30),

                  // DateTime data field
                  _buildTextField(
                    controller: datetimeController,
                    hintText: 'DateTime (MM-DD-YYYY 00:00:00)',
                  ),
                  const SizedBox(height: 30),

                  // Send Data Button
                  _buildSendButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextField builder with theme alignment
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Custom Send Data Button
  Widget _buildSendButton() {
    return ElevatedButton(
      onPressed: sendData,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        backgroundColor: kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Send Data',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
