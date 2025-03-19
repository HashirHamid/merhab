import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileField('First Name', 'John'),
          const Divider(color: Color.fromARGB(255, 218, 218, 218)),
          _buildProfileField('Last Name', 'Doe'),
          const Divider(color: Color.fromARGB(255, 218, 218, 218)),
          _buildProfileField('Email', 'john.doe@example.com'),
          const Divider(color: Color.fromARGB(255, 218, 218, 218)),
          _buildProfileField('Phone', '+1234567890'),
          const Divider(color: Color.fromARGB(255, 218, 218, 218)),
          _buildProfileField('Gender', 'Male'),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
