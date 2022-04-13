import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventFormWidget extends StatelessWidget {
  final String? eventName;
  final String? eventDescription;
  final  String? eventTime;
  final String? eventDate;
  final ValueChanged<String> onChangedEventName;
  final ValueChanged<String> onChangedEventDescription;
  final ValueChanged<String> onChangedEventTime;
  final ValueChanged<String> onChangedEventDate;

  const EventFormWidget({
    Key? key,
    this.eventName='',
    this.eventDescription='',
    this.eventTime='',
    this.eventDate='',
    required this.onChangedEventName,
    required this.onChangedEventDescription,
    required this.onChangedEventTime,
    required this.onChangedEventDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child:Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildEventTime(context),
            const SizedBox(height: 8),
            buildEventDate(context),
            const SizedBox(height: 8),
            buildEventName(),
            buildEventDescription(),
            const SizedBox(height: 8),
          ],
        ),
      )
    );
  }

  Widget buildEventName(){

    return Container(
      margin: const EdgeInsets.all(8),
      child :TextFormField(
        maxLines: 1,
        initialValue: eventName,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        decoration: const InputDecoration(
          labelText: 'Event Name',
          labelStyle: TextStyle(
            color: Colors.blueGrey,
          ),
          border: InputBorder.none,
          hintText: 'Enter Event Name',
          hintStyle: TextStyle(
              color: Colors.white38
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: (eventName) {
          if (eventName == null || eventName.isEmpty) {
            return 'Event Name Required';
          }
          return null;
        },
        onChanged: onChangedEventName,
      ),
    );

  }

  Widget buildEventDescription(){
    return Container(
      margin: const EdgeInsets.all(8),
      child :TextFormField(
        maxLines: 5,
        initialValue: eventDescription,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        textAlign: TextAlign.start,
        decoration: const InputDecoration(
          labelText: 'Event Description',
          labelStyle: TextStyle(
            color: Colors.blueGrey,
          ),
          border: InputBorder.none,
          hintText: 'Enter Event Description',
          hintStyle: TextStyle(
              color: Colors.white38
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: (eventDescription) {
          if (eventDescription == null || eventDescription.isEmpty) {
            return 'Event Description Required';
          }
          return null;
        },
        onChanged: onChangedEventDescription,
      ),
    );
  }

  // Widget buildEventTimeDate(){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children :[buildEventTime(),buildEventDate()],
  //   );
  // }

  Widget buildEventTime(BuildContext context){
    TextEditingController timeController = TextEditingController();
    timeController.text = eventTime!;
    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        keyboardType: TextInputType.none,
        onTap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: toTime(eventTime!) ,
            initialEntryMode: TimePickerEntryMode.dial,
          );
          if(timeOfDay != null && timeOfDay != toTime(eventTime!))
          {
            timeController.text=timeOfDay.format(context);
            // eventTime=timeOfDay.format(context);
          }
        },
        maxLines: 1,
        controller: timeController,
        // initialValue: eventTime,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:"Select Time",
          hintStyle: const TextStyle(color: Colors.white38),
          labelText: "Time",
          labelStyle: const TextStyle(
            color: Colors.blueGrey,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: toTime(eventTime!) ,
                initialEntryMode: TimePickerEntryMode.dial,
              );
              if(timeOfDay != null && timeOfDay != toTime(eventTime!))
              {
                timeController.text=timeOfDay.format(context);
                // eventTime=timeOfDay.format(context);
              }
            },
          ),
        ),
        validator: (eventTime) {
          if (eventTime == null || eventTime.isEmpty) {
            return 'Select Time';
          }
          return null;
        },
        onChanged: onChangedEventTime,
      ),
    );

  }

  Widget buildEventDate(BuildContext context){

    TextEditingController dateController = TextEditingController();
    dateController.text = eventDate!;
    late String date = eventDate!;
    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        keyboardType: TextInputType.none,
        onTap: () async {
          final DateTime? dateOfDay= await showDatePicker(
            context: context,
            initialDate: toDate(eventDate!),
            firstDate: toDate(eventDate!),
            lastDate: DateTime(2025),
          );
          if(dateOfDay != null && dateOfDay != toDate(eventDate!)){
            dateController.text=DateFormat.MMMd('en-US').format(dateOfDay);
            // date=DateFormat.MMMd('en-US').format(dateOfDay);
          }
        },
        maxLines: 1,
        controller: dateController,
        // initialValue: date,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:"Select Date",
          hintStyle: const TextStyle(color: Colors.white38),
          labelText: "Date",
          labelStyle: const TextStyle(
            color: Colors.blueGrey,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              final DateTime? dateOfDay= await showDatePicker(
                context: context,
                initialDate: toDate(eventDate!),
                firstDate: toDate(eventDate!),
                lastDate: DateTime(2025),
              );
              if(dateOfDay != null && dateOfDay != toDate(eventDate!)){
                dateController.text=DateFormat.MMMd('en-US').format(dateOfDay);
                // date=DateFormat.MMMd('en-US').format(dateOfDay);
              }
            },
          ),
        ),
        validator: (eventDate) {
          if (eventDate == null || eventDate.isEmpty) {
            return 'Select Date';
          }
          return null;
        },
        onChanged: onChangedEventDate,
      ),
    );
  }

  toTime(String time){
    return TimeOfDay(hour:int.parse(time.split(':')[0]),minute: int.parse(time.split(':')[1]));
  }

  toDate(String date){
    return DateTime.parse(date);
  }

}
