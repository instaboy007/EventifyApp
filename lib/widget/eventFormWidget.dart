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
            buildEventDate(),
            const SizedBox(height: 8),
            buildEventName(),
            const SizedBox(height: 8),
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
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          labelText: 'Event Name',
          border: InputBorder.none,
          hintText: 'Enter Event Name',
          hintStyle: TextStyle(color: Colors.grey),
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
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.start,
        decoration: const InputDecoration(
            labelText: 'Event Description',
            border: InputBorder.none,
            hintText: 'Enter Event Description',
            hintStyle: TextStyle(color: Colors.grey),
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
    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        maxLines: 1,
        initialValue: eventTime,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:"Select Time",
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: "Time",
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
                onChangedEventTime(timeOfDay.format(context));
              }
              // else if(timeOfDay==toTime(eventTime!)){
              //   onChangedEventTime(timeOfDay.format(context));
              // }
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

  Widget buildEventDate(){
    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        maxLines: 1,
        initialValue: eventDate,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:"Select Date",
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: "Date",
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {

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

  // _selectTime(BuildContext context) async {
  //   final TimeOfDay? timeOfDay = await showTimePicker(
  //     context: context,
  //     initialTime: toTime(eventTime!) ,
  //     initialEntryMode: TimePickerEntryMode.dial,
  //
  //   );
  //   if(timeOfDay != null && timeOfDay != toTime(eventTime!))
  //   {
  //     setState(()=>{
  //       eventTime = DateFormat.Hms().format(timeOfDay);
  //     });
  //
  //   }
  //   else if(timeOfDay==selectedTime){
  //     setState((){
  //       _time.text="${selectedTime.hour}:${selectedTime.minute} ";
  //     });
  //   }
  // }

  // _selectDate(BuildContext context) async {
  //   final DateTime? dateOfDay= await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: selectedDate,
  //     lastDate: DateTime(2025),
  //   );
  //   if(dateOfDay != null && dateOfDay != selectedDate){
  //     setState((){
  //       selectedDate=dateOfDay;
  //       _date.text="${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  //     });
  //   }
  //   else if(dateOfDay==selectedDate){
  //     setState((){
  //       _date.text="${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  //     });
  //   }
  // }

  toTime(String time){
    return TimeOfDay(hour:int.parse(time.split(':')[0]),minute: int.parse(time.split(':')[1]));
  }

}
