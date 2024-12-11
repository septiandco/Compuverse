import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AttendanceRepository extends GetxController {
  static AttendanceRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fungsi untuk menandai kehadiran pengguna
  Future<void> markAttendance(String eventId) async {
    // Mendapatkan ID pengguna yang sedang login (pastikan sudah login)
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Referensi ke koleksi kehadiran
    CollectionReference attendanceCollection = _db.collection("Events").doc(eventId).collection("Attendance");

    // Mengecek apakah kehadiran sudah ada untuk pengguna ini
    DocumentReference attendanceDoc = attendanceCollection.doc(userId);
    var docSnapshot = await attendanceDoc.get();

    if (docSnapshot.exists) {
      // Jika sudah hadir, beri feedback
      Get.snackbar(
        "Already Marked",
        "You have already marked your attendance for this event",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.1),
        colorText: Colors.orange,
      );
    } else {
      // Menandai kehadiran
      await attendanceDoc.set({
        'userId': userId,
        'eventId': eventId,
        'timestamp': FieldValue.serverTimestamp(),
      }).whenComplete(() {
        // Memberikan feedback jika kehadiran berhasil dicatat
        Get.snackbar(
          "Success",
          "Your attendance has been marked!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      }).catchError((error) {
        // Memberikan feedback jika terjadi error
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        print("Error marking attendance: $error");
      });
    }
  }

  // Fungsi untuk mengambil data kehadiran acara tertentu
  Future<List<Map<String, dynamic>>> getAttendanceList(String eventId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("Events")
          .doc(eventId)
          .collection("Attendance")
          .get();

      List<Map<String, dynamic>> attendanceList = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return attendanceList;
    } catch (e) {
      print("Error getting attendance: $e");
      throw Exception("Could not retrieve attendance data");
    }
  }
}
