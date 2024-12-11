import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Validasi email sebelum membuat akun
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9-]+\.)?president\.ac\.id$");
    return emailRegex.hasMatch(email);
  }

  // Fungsi untuk membuat pengguna baru
  createUser(UserModel user) async {
    // Validasi domain email
    if (!isValidEmail(user.email)) {
      Get.snackbar(
        "Error",
        "Email must be from domain president.ac.id.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    await _db.collection("Users").add(user.toJson()).whenComplete(
          () => Get.snackbar(
        "Success",
        "Your Account Has been Created",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      ),
    ).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try Again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("ERROR - $error");
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserRecord(UserModel user, String newPassword) async {
    try {
      // 1. Update password in Firebase Authentication
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Updating the password in Firebase Authentication
        await currentUser.updatePassword(newPassword);

        // Optionally reauthenticate user (important for some actions like password change)
        await currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: currentUser.email!,
            password: user.password, // Current password
          ),
        );

        print("Password updated successfully in Firebase Authentication");

        // 2. Update Firestore user record (if needed, though not recommended to store passwords here)
        await _db.collection("Users").doc(user.id).update({
          'password': newPassword, // This should be avoided for security reasons
        });

        print("User profile updated successfully in Firestore");

        // Show success snackbar
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            "Success",
            "Profile Updated",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            borderRadius: 10.0,
            margin: const EdgeInsets.all(16.0),
            icon: const Icon(Icons.check_circle, color: Colors.white),
            snackStyle: SnackStyle.FLOATING,
          );
        });
      } else {
        throw Exception("No user is currently logged in.");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Try Again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}
