import 'package:flutter/material.dart';

class CareerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Daftar karir
    final List<Map<String, String>> careers = [
      {'title': 'Software Engineer', 'location': 'Jakarta, Indonesia', 'company': 'TechCorp'},
      {'title': 'Product Manager', 'location': 'Bandung, Indonesia', 'company': 'InnovaTech'},
      {'title': 'UI/UX Designer', 'location': 'Surabaya, Indonesia', 'company': 'Creative Studio'},
      {'title': 'Data Scientist', 'location': 'Yogyakarta, Indonesia', 'company': 'DataLab'},
      {'title': 'Mobile Developer', 'location': 'Bali, Indonesia', 'company': 'AppWorld'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Career Page'),
      ),
      body: ListView.builder(
        itemCount: careers.length,
        itemBuilder: (context, index) {
          final career = careers[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.business, color: Colors.blue),
                ],
              ),
              title: Text(
                career['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(career['location']!),
                  Text(
                    'Company: ${career['company']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      // Aksi untuk membuka link "More"
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('More about ${career['title']}'),
                          content: Text('Company: ${career['company']}\nLocation: ${career['location']}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
              onTap: () {
                // Navigasi ke halaman detail karir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CareerDetailPage(career: career),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CareerDetailPage extends StatelessWidget {
  final Map<String, String> career;

  CareerDetailPage({required this.career});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${career['title']} Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              career['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Location: ${career['location']}'),
            SizedBox(height: 8),
            Text('Company: ${career['company']}'),
          ],
        ),
      ),
    );
  }
}
