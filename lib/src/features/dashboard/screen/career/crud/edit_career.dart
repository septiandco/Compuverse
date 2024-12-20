import 'package:compuvers/src/features/dashboard/controller/career_controller.dart';
import 'package:compuvers/src/features/dashboard/models/career_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateCareerPage extends StatelessWidget {
  final Career career;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  UpdateCareerPage({required this.career});

  @override
  Widget build(BuildContext context) {
    // Initialize the controllers with current career details
    titleController.text = career.title;
    typeController.text = career.type;
    companyController.text = career.company;
    locationController.text = career.location;
    deadlineController.text = career.applicationDeadline;
    urlController.text = career.url;
    descriptionController.text = career.description;

    final CareerController controller = Get.put(CareerController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Career'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Type (remote/onsite/hybrid)'),
            ),
            TextField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Company'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(labelText: 'Application Deadline'),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'URL for Details'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create updated career object
                Career updatedCareer = Career(
                  id: career.id, // Keep the same ID for updating
                  title: titleController.text,
                  type: typeController.text,
                  company: companyController.text,
                  location: locationController.text,
                  applicationDeadline: deadlineController.text,
                  url: urlController.text,
                  description: descriptionController.text,
                );

                // Update the career in Firestore
                controller.updateCareer(updatedCareer);

                // Go back to the previous page after updating the career
                Navigator.pop(context);
              },
              child: Text('Update Career'),
            ),
          ],
        ),
      ),
    );
  }
}
