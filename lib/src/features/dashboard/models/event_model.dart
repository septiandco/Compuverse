import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? id;
  final String eventDate;  // Add eventDate as String
  final String eventDescription;
  final String eventName;
  final String eventType;
  final String location;
  final String imageUrl;
  // Add location as String

  const EventModel({
    this.id,
    required this.eventDate,  // Add eventDate to the constructor
    required this.eventDescription,
    required this.eventName,
    required this.eventType,
    required this.location,   // Add location to the constructor
    required this.imageUrl,
  });

  // Convert EventModel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      "EventDate": eventDate,  // Include eventDate in JSON
      "EventDescription": eventDescription,
      "EventName": eventName,
      "EventType": eventType,
      "Location": location,    // Include location in JSON
      "imageUrl": imageUrl,
    };
  }

  // Read snapshot from Firestore and convert to EventModel
  factory EventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EventModel(
      id: document.id,
      eventDate: data["EventDate"],
      eventDescription: data["EventDescription"],
      eventName: data["EventName"],
      eventType: data["EventType"],
      location: data["Location"],    // Fetch location from Firestore
      imageUrl: data["imageUrl"],
    );
  }
}
