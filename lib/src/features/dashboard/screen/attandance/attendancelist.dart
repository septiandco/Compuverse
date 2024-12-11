import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceListPage extends StatelessWidget {
  final String eventId;

  AttendanceListPage({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance List'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Events")
            .doc(eventId)
            .collection("Attendance")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading attendance list'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No attendance data found'));
          }

          final attendanceDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: attendanceDocs.length,
            itemBuilder: (context, index) {
              final doc = attendanceDocs[index];
              final userId = doc['userId'];
              final timestamp = doc['timestamp'] != null
                  ? (doc['timestamp'] as Timestamp).toDate()
                  : null;

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(userId),
                subtitle: timestamp != null
                    ? Text("Checked in: ${timestamp.toLocal()}")
                    : const Text("Timestamp not available"),
              );
            },
          );
        },
      ),
    );
  }
}
