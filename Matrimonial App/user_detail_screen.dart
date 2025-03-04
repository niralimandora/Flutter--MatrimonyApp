import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user['name']}'s Details"),
        actions: [
          // Favorite Button
          IconButton(
            icon: Icon(
              user['isFavorite'] ? Icons.favorite : Icons.favorite_border,
              color: user['isFavorite'] ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              // Toggle favorite status
            },
          ),
          // Delete Button
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("User ID: ${user['id']}"),
                ],
              ),
            ),
            Divider(height: 20, thickness: 1),

            // User Details Sections
            buildDetailSection("Personal Information", {
              "Full Name": user['name'],
              "Date of Birth": user['dateOfBirth'],
              "Age": "${user['age']} years",
              "Gender": user['gender'] == 0 ? "Male" : user['gender'] == 1 ? "Female" : "Other",
              "City": user['city'],
            }),

            buildDetailSection("Contact Details", {
              "Email": user['email'],
              "Phone": user['phone'],
            }),

            buildDetailSection("Hobbies", {
              "Hobbies": user['hobbies'].join(', '),
            }),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Edit User Screen
                },
                child: Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailSection(String title, Map<String, String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ...details.entries.map((entry) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text("${entry.key}: ${entry.value}"),
        )),
        SizedBox(height: 10),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to User List Screen
              // Perform deletion logic
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
