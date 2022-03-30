import 'package:flutter/material.dart';

class EventFormWidget extends StatelessWidget {
  final String? eventName;
  final String? eventDescription;
  final TimeOfDay? eventTime;
  final DateTime? eventDate;
  final ValueChanged<String> onChangedEventName;
  final ValueChanged<String> onChangedEventDescription;
  final ValueChanged<TimeOfDay> onChangedEventTime;
  final ValueChanged<DateTime> onChangedEventDate;

  const EventFormWidget({
    Key? key,
    this.eventName='',
    this.eventDescription='',
    this.eventTime,
    this.eventDate,
    required this.onChangedEventName,
    required this.onChangedEventDescription,
    required this.onChangedEventTime,
    required this.onChangedEventDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
        padding:EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child :TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Event Name',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Event Name Required';
                  }
                  return null;
                },
                onChanged: onChangedEventName,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child :TextFormField(
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Event Description',
                    contentPadding: EdgeInsets.symmetric(vertical:40.0, horizontal: 10.0)

                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Event Description Required';
                  }
                  return null;
                },
                onChanged: onChangedEventDescription,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText:"Time",
                  labelText: "Time",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time), onPressed: () {  },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Time';
                  }
                  return null;
                },
                onChanged: onChangedEventTime,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                onTap: () {
                  setState(() {
                    _selectDate(context);
                  });
                },
                controller:_date,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Date",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Date';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
