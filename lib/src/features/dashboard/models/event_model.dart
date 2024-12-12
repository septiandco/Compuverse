import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? id;
  final String eventDate;
  final String eventDescription;
  final String eventName;
  final String eventType;
  final String location;
  final String imageUrl;
  final List<Map<String, dynamic>> candidates; // Tambahkan properti candidates

  const EventModel({
    this.id,
    required this.eventDate,
    required this.eventDescription,
    required this.eventName,
    required this.eventType,
    required this.location,
    required this.imageUrl,
    this.candidates = const [], // Default adalah list kosong
  });

  // Convert EventModel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      "EventDate": eventDate,
      "EventDescription": eventDescription,
      "EventName": eventName,
      "EventType": eventType,
      "Location": location,
      "imageUrl": imageUrl,
      "Candidates": candidates, // Masukkan kandidat ke JSON
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
      location: data["Location"],
      imageUrl: data["imageUrl"],
      candidates: data["Candidates"] != null
          ? List<Map<String, dynamic>>.from(data["Candidates"])
          : [],
    );
  }
}
