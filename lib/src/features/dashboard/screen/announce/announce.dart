import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compuvers/src/features/authentication/screen/welcome/welcome_screen.dart';

class AnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Announcements')),  // Optional: Add an app bar title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Optional: Add padding for better UI
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Announcement Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),  // Space between Text and ListTile
            ListTile(
              onTap: () async {
                await AuthenticationRepository.instance.logout();
                Get.offAll(() => const WelcomeScreen());
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue.withOpacity(0.1), // Or any color for the circle
                ),
                child: const Icon(Icons.logout_outlined),
              ),
              title: Text(
                'Logout', // Change 'cLogout' to a string if necessary
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
