import 'dart:convert';

import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/authentication/screen/welcome/welcome_screen.dart';
import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:compuvers/src/features/dashboard/screen/attandance/attendancelist.dart';
import 'package:compuvers/src/features/dashboard/screen/attandance/scannerpage.dart';
import 'package:compuvers/src/features/dashboard/screen/event/crud/edit_event.dart';
import 'package:compuvers/src/repository/attendance/attandance_repo.dart';
import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/image_strings.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthenticationRepository.instance;
    final controller = Get.put(EventController());
    final attendanceRepo = Get.put(AttendanceRepository());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cEventDetail,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Obx(() {
            final user = authRepo.firebaseUser.value;
            if (user != null && user.email == 'septiandwica@gmail.com') {
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => EditEventPage(eventId: event.id));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
      body: event.id != null
          ? FutureBuilder<EventModel>(
        future: controller.getEventData(event.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final eventData = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      eventData.imageUrl.isNotEmpty
                          ? eventData.imageUrl
                          : cEventBanner,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      eventData.eventType.isNotEmpty ? eventData.eventType : 'No Type',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    eventData.eventName.isNotEmpty ? eventData.eventName : 'No Title',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                          const SizedBox(width: 8.0),
                          Text(
                            eventData.eventDate.isNotEmpty
                                ? eventData.eventDate
                                : "No Date",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 16),
                          const SizedBox(width: 8.0),
                          Text(
                            eventData.location.isNotEmpty
                                ? eventData.location
                                : "No Location",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    eventData.eventDescription.isNotEmpty
                        ? eventData.eventDescription
                        : 'No Description',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      final userId = authRepo.firebaseUser.value?.uid;
                      if (userId != null && event.id != null) {
                        final qrData = {
                          'userId': userId,
                          'eventId': event.id,
                          'timestamp': DateTime.now().toIso8601String(),
                        };

                        // Tampilkan QR Code
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Your Attendance QR Code'),
                              content: SizedBox(
                                width: 320,
                                height: 320,
                                child: QrImageView(
                                  data: jsonEncode(qrData),
                                  version: QrVersions.auto,
                                  size: 320,
                                  gapless: false,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Error: Cannot generate QR code.")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('RSVP'),
                  ),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    final user = authRepo.firebaseUser.value;
                    if (user != null &&
                        user.email == 'septiandwica@gmail.com') {
                      return ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman daftar kehadiran
                          Get.to(() => AttendanceListPage(
                              eventId: event.id!));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('View Attendance List'),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No event details available"));
          }
        },
      )
          : const Center(child: Text("Invalid event ID")),
    );
  }
}
