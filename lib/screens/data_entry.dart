import 'package:asugs/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  // Text editing controllers
  final stringController = TextEditingController();
  final intController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final datetimeController = TextEditingController();
  final geoLocationController =
      TextEditingController(); // Geolocation controller

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Get geolocation when the page loads
  }

  // Method to determine the current position
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services are not enabled, do nothing
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied, do nothing
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Permissions are permanently denied, do nothing
    }

    // Get the current position and update the controller
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      geoLocationController.text =
          "${position.latitude}, ${position.longitude}";
    });
  }

  // Send data method
  void sendData() async {
    final url = Uri.parse('http://10.130.1.143:5000/send-data');
    final body =
        jsonEncode({'email': (), 'geolocation': geoLocationController.text});

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

  // Date picker
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

  // Time picker
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

                  // Date picker field
                  GestureDetector(
                    onTap: _selectDate,
                    child: _buildTextField(
                      controller: dateController,
                      hintText: 'Date (MM/DD/YYYY)',
                      enabled: false, // Disable manual editing
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Time picker field
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

                  // Geolocation field (read-only)
                  _buildTextField(
                    controller: geoLocationController,
                    hintText: 'Geo Location (Latitude, Longitude)',
                    enabled: false, // Read-only
                  ),
                  const SizedBox(height: 30),

                  // Send data button
                  _buildSendButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextField builder
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
