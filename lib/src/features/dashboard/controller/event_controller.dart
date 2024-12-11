import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:compuvers/src/repository/event/event_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get instance => Get.find();

  // TextEditingControllers untuk form fields
  final eventType = TextEditingController();
  final eventName = TextEditingController();
  final eventDescription = TextEditingController();
  final imageUrl = TextEditingController();
  final eventDate = TextEditingController();  // Controller for event date
  final location = TextEditingController();   // Controller for location

  final _eventRepo = Get.put(EventRepository());

  // Fungsi untuk membuat event baru
  Future<void> createEvent(EventModel event) async {
    await _eventRepo.createEvent(event);
  }

  // Fungsi untuk memperbarui event yang sudah ada
  Future<void> updateEvent(String eventId, EventModel event) async {
    await _eventRepo.updateEvent(eventId, event);
  }

  // Fungsi untuk menambah event berdasarkan data form
  void addEvent(
      String eventDate,
      String eventDescription,
      String eventName,
      String eventType,
      String location,
      String imageUrl,
      ) {
    final newEvent = EventModel(
      eventDate: eventDate,
      eventDescription: eventDescription,
      eventName: eventName,
      eventType: eventType,
      location: location,
      imageUrl: imageUrl,
    );

    createEvent(newEvent);
  }

  // Fungsi untuk mendapatkan data event berdasarkan ID
  Future<EventModel> getEventData(String eventId) async {
    try {
      final event = await _eventRepo.getEventDetails(eventId);
      return event;
    } catch (e) {
      print('Error fetching event: $e');
      throw Exception('Event not found');
    }
  }

  // Fungsi untuk mendapatkan semua event
  Future<List<EventModel>> getAllEvents() async {
    return await _eventRepo.allEvents();
  }

  // Fungsi untuk menghapus event berdasarkan ID
  Future<void> deleteEvent(String eventId) async {
    await _eventRepo.deleteEvent(eventId);
  }
}