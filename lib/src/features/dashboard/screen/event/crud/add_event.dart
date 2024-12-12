import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? _eventType;
  String? _eventName;
  String? _eventDescription;
  String? _imageUrl;
  String? _eventDate; // New field for event date
  String? _location; // New field for location

  final List<String> _eventTypes = ['Conference', 'Workshop', 'Seminar', 'Webinar', 'Competition', 'Mentoring'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventController());
    return Scaffold(
      appBar: AppBar(
        title: Text(cAddEvent, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(  // Make the body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Type Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: cTypeEvent,
                  border: OutlineInputBorder(),
                ),
                value: _eventType,
                onChanged: (String? newValue) {
                  setState(() {
                    _eventType = newValue;
                  });
                },
                items: _eventTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an event type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Event Name TextField
              TextFormField(
                controller: controller.eventName,
                decoration: const InputDecoration(
                  labelText: cEventName,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventName = value;
                },
              ),
              const SizedBox(height: 16.0),

              // Event Description TextField
              TextFormField(
                controller: controller.eventDescription,
                decoration: const InputDecoration(
                  labelText: cEventDesc,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventDescription = value;
                },
              ),
              const SizedBox(height: 16.0),

              // Event Date TextField (string format)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventDate = value;
                },
              ),
              const SizedBox(height: 16.0),

              // Location TextField
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value;
                },
              ),
              const SizedBox(height: 16.0),

              // Image URL TextField
              TextFormField(
                controller: controller.imageUrl,
                decoration: const InputDecoration(
                  labelText: cImageUrl,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value;
                },
              ),
              const SizedBox(height: 32.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Printing the form data to verify
                    print('Event Type: $_eventType');
                    print('Event Name: $_eventName');
                    print('Event Description: $_eventDescription');
                    print('Event Date: $_eventDate');
                    print('Event Location: $_location');
                    print('Image URL: $_imageUrl');

                    // Call the addEvent function from the controller
                    controller.addEvent(
                      _eventDate!,
                      _eventDescription!,
                      _eventName!,
                      _eventType!,
                      _location!,
                      _imageUrl!,
                    );

                    // Reset form fields after submission
                    controller.eventType.clear();
                    controller.eventName.clear();
                    controller.eventDescription.clear();
                    controller.imageUrl.clear();
                    setState(() {
                      _eventType = null;
                    });

                    // Go back to the previous screen
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
