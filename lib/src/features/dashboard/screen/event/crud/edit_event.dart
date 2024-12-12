import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventPage extends StatefulWidget {
  final String? eventId;  // Add eventId parameter for update functionality

  const EditEventPage({Key? key, this.eventId}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? _eventType;
  String? _eventName;
  String? _eventDescription;
  String? _imageUrl;
  String? _eventDate; // New field for event date
  String? _location; // New field for location

  bool isLoading = false; // Variable to track loading state

  final List<String> _eventTypes = ['Conference', 'Workshop', 'Seminar', 'Webinar', 'Competition', 'Mentoring'];

  final controller = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    // If eventId is provided, load event data
    if (widget.eventId != null) {
      _loadEventData(widget.eventId!);
    }
  }

  void _loadEventData(String eventId) async {
    try {
      EventModel event = await controller.getEventData(eventId);
      setState(() {
        _eventType = event.eventType;
        _eventName = event.eventName;
        _eventDescription = event.eventDescription;
        _eventDate = event.eventDate;
        _location = event.location;
        _imageUrl = event.imageUrl;
      });

      // Set controller text directly for form fields
      controller.eventName.text = _eventName!;
      controller.eventDescription.text = _eventDescription!;
      controller.eventDate.text = _eventDate!;
      controller.location.text = _location!;
      controller.imageUrl.text = _imageUrl!;
    } catch (e) {
      print('Error loading event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventId == null ? cAddEvent : 'Update Event', style: Theme.of(context).textTheme.headlineMedium),
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
              ),
              const SizedBox(height: 16.0),

              // Event Date TextField (string format)
              TextFormField(
                controller: controller.eventDate,
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
              ),
              const SizedBox(height: 16.0),

              // Event Location TextField
              TextFormField(
                controller: controller.location,
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
              ),
              const SizedBox(height: 16.0),

              // Image URL TextField
              TextFormField(
                controller: controller.imageUrl,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),

              // Update or Create Button
              isLoading
                  ? Center(child: CircularProgressIndicator())  // Show loading indicator when isLoading is true
                  : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;  // Start loading
                    });

                    // No need to call save explicitly; use controller's text directly
                    if (widget.eventId == null) {
                      controller.addEvent(
                        controller.eventDate.text,
                        controller.eventDescription.text,
                        controller.eventName.text,
                        _eventType!,
                        controller.location.text,
                        controller.imageUrl.text,
                      );
                    } else {
                      // Update existing event
                      EventModel updatedEvent = EventModel(
                        eventDate: controller.eventDate.text,
                        eventDescription: controller.eventDescription.text,
                        eventName: controller.eventName.text,
                        eventType: _eventType!,
                        location: controller.location.text,
                        imageUrl: controller.imageUrl.text,
                      );
                      await controller.updateEvent(widget.eventId!, updatedEvent);
                    }

                    setState(() {
                      isLoading = false;  // Stop loading
                    });

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.eventId == null ? 'Create Event' : 'Update Event'),
              ),

              // Add a Delete Button
              if (widget.eventId != null) // Only show the delete button if eventId is not null
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await controller.deleteEvent(widget.eventId!);

                      setState(() {
                        isLoading = false;
                      });

                      Navigator.pop(context);  // After deleting, pop the page
                    },

                    child: Text('Delete Event', style: TextStyle(color: Colors.black)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
