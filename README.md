# Compuverse

Welcome to **Compuverse**, a Flutter project designed to kickstart your mobile application development journey!

- [Septian Dwi Cahyo](https://github.com/septiandwica)
- [Samuel George Sasaki](https://github.com/samuelsasaki)
- [Salsabil Maheswari](https://github.com/SalsabilMaheswari)
## Getting Started

Follow this guide to set up and run the project locally. If you're new to Flutter, don't worry—we've got resources to help you along the way!

### Prerequisites

Make sure you have the following installed on your system:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart](https://dart.dev/get-dart)
- Android Studio or Visual Studio Code (with Flutter and Dart plugins)
- Xcode (for iOS development on macOS)
- A device or emulator for testing (e.g., Android Emulator or iOS Simulator)

### Installation Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/septiandco/Compuverse.git
   cd compuverse
   ```

2. **Install Dependencies**

   Run the following command to fetch all required packages:

   ```bash
   flutter pub get
   ```

3. **Run the Application**

   - For Android:
     ```bash
     flutter run
     ```
   - For iOS:
     Ensure that you have Xcode installed and configured, then run:
     ```bash
     flutter run
     ```

   You can also use an IDE like Android Studio or Visual Studio Code to run the project.

### Project Structure

Here is the complete project structure(MNC + Repo as db):

```plaintext
lib/
└── src/
    ├── constants/
    │   ├── colors.dart
    │   ├── image_strings.dart
    │   ├── sizes.dart
    │   └── text_strings.dart
    ├── features/
    │   ├── authentication/
    │   │   ├── controllers/
    │   │   │   ├── login_controller.dart
    │   │   │   ├── on_boarding_controller.dart
    │   │   │   ├── signup_controller.dart
    │   │   │   └── splash_screen_controller.dart
    │   │   ├── models/
    │   │   │   ├── on_boarding_models.dart
    │   │   │   └── user_model.dart
    │   │   └── screen/
    │   │       ├── login_screen/
    │   │       ├── on_boarding/
    │   │       ├── signup_screen/
    │   │       ├── splash_screen/
    │   │       └── welcome/
    │   ├── dashboard/
    │   │   ├── controller/
    │   │   │   ├── announce_controller.dart
    │   │   │   ├── attendance_controller.dart
    │   │   │   ├── career_controller.dart
    │   │   │   ├── event_controller.dart
    │   │   │   └── profile_controller.dart
    │   │   ├── models/
    │   │   │   ├── announce_model.dart
    │   │   │   ├── attendance_model.dart
    │   │   │   ├── career_model.dart
    │   │   │   └── event_model.dart
    │   │   └── screen/
    │           ├── announce/
    │           │   └── announce.dart
    │           ├── attendance/
    │           │   ├── attendancelist.dart
    │           │   └── scannerpage.dart
    │           ├── career/
    │           │   ├── crud/
    │           │   │   ├── add_career.dart
    │           │   │   ├── edit_career.dart
    │           │   ├── career.dart
    │           │   └── career_detail.dart
    │           ├── event/
    │           │   ├── certificate/
    │           │   │   └── generate_certificate.dart
    │           │   ├── competition/
    │           │   │   └── competitionform.dart
    │           │   ├── crud/
    │           │   │   ├── add_event.dart
    │           │   │   ├── edit_event.dart
    │           │   ├── event.dart
    │           │   └── event_detail.dart
    │           └── profile/
    │               ├── profile_screen.dart
    │               └── update_profile.dart
    │           └── upskill/
    │               ├── crud/
    │               │   ├── add_upskill.dart
    │               │   ├── edit_upskill.dart
    │               ├── upskill.dart
    │               └── upskill_detail.dart
    ├── repository/
    │   ├── announce/
    │   │   └── announce_repo.dart
    │   ├── attendance/
    │   │   └── attendance_repo.dart
    │   ├── authentication/
    │   │   ├── exception/
    │   │   │   ├── login_exception.dart
    │   │   │   ├── signup_exception.dart
    │   │   └── authentication_repo.dart
    │   ├── career/
    │   │   └── career_repo.dart
    │   ├── event/
    │   │   └── event_repo.dart
    ├── utils/
    │   └── theme/
    │       ├── widget_theme.dart
    │       └── theme.dart
    ├── firebase_options.dart
    └── main.dart
```

### Debugging Tips

- Run `flutter doctor` to ensure your development environment is set up correctly.
- Check the device logs using:
  ```bash
  flutter logs
  ```
- Use `flutter clean` to clear cached data if you encounter unexpected behavior.

## Resources

Here are some useful links to help you get started with Flutter:

- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter online documentation](https://docs.flutter.dev/)

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature name"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a Pull Request

## License

This project is licensed under the [MIT License](LICENSE).

---

Happy coding! 🚀

