import 'package:flutter/material.dart';
import 'package:eventify/model/event.dart';
import 'package:eventify/database/db.dart';
import 'package:eventify/widget/eventFormWidget.dart';
import 'package:intl/intl.dart';

class AddEditEventPage extends StatefulWidget {

  final Event? event;

  const AddEditEventPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<AddEditEventPage> createState() => _AddEditEventPageState();
}

class _AddEditEventPageState extends State<AddEditEventPage> {

  final _formKey = GlobalKey<FormState>();
  late String eventName;
  late String eventDescription;
  late String eventTime;
  late String eventDate;

  @override
  void initState() {
    super.initState();

    eventName = widget.event?.eventName ?? '';
    eventDescription = widget.event?.eventDescription ?? '';
    eventTime = DateFormat.Hms().format((widget.event?.eventTime)!);
    eventDate = DateFormat('yyyy-MM-dd').format((widget.event?.eventTime)!);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions:[saveButton()],
      ),
      body: Form(
        key:_formKey,
        child: EventFormWidget(
          eventName: eventName,
          eventDescription: eventDescription,
          eventTime: eventTime,
          eventDate:eventDate,
          onChangedEventName: (eventName) =>
              setState(() => this.eventName = eventName),
          onChangedEventDescription: (eventDescription) =>
              setState(() => this.eventDescription = eventDescription),
          onChangedEventTime: (eventTime) =>
              setState(() => this.eventTime = eventTime),
          onChangedEventDate: (eventDate) =>
              setState(() => this.eventDate = eventDate),

        ),
      ),
    );
  }

  Widget saveButton() {
    final isFormValid = eventName.isNotEmpty && eventDescription.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.event != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final event = widget.event!.copy(
      eventName: eventName,
      eventDescription: eventDescription,
      eventTime: DateTime.parse(eventDate+" "+eventTime),
    );

    await EventsDatabase.instance.update(event);
  }

  Future addNote() async {
    final event = Event(
        eventName: eventName,
        eventDescription: eventDescription,
        eventTime: DateTime.parse(eventDate+" "+eventTime)
    );

    await EventsDatabase.instance.create(event);
  }
}
