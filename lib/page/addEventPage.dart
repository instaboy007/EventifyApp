import 'package:eventify/page/eventsPage.dart';
import 'package:flutter/material.dart';
import 'package:eventify/model/event.dart';
import 'package:eventify/database/db.dart';
import 'package:eventify/widget/baseWidget.dart';

class AddEvent extends StatefulWidget {
  final Event? event;

  const AddEvent({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  final _name=TextEditingController();
  final _description=TextEditingController();
  final _time=TextEditingController();
  final _date=TextEditingController();
  TimeOfDay selectedTime=TimeOfDay.now();
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
        padding:const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  buildEventTime(context),
                  const SizedBox(height: 8),
                  buildEventDate(context),
                  const SizedBox(height: 8),
                  buildEventName(),
                  buildEventDescription(),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // await Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => addEvent()),
                        // );
                        addEvent();
                      }
                    },
                    child: const Text('Add Event'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventName(){

    return Container(
      margin: const EdgeInsets.all(8),
      child :TextFormField(
        maxLines: 1,
        controller:_name,
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
      ),
    );

  }

  Widget buildEventDescription(){
    return Container(
      margin: const EdgeInsets.all(8),
      child :TextFormField(
        maxLines: 5,
        controller:_description,
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
      ),
    );
  }

  Widget buildEventTime(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        keyboardType: TextInputType.none,
        onTap: () {
          setState(() {
          _selectTime(context);
          });
        },
        maxLines: 1,
        controller:_time,
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
            onPressed: () {
              setState(() {
                _selectTime(context);
              });
            },
          ),
        ),
        validator: (eventTime) {
          if (eventTime == null || eventTime.isEmpty) {
            return 'Select Time';
          }
          return null;
        },
      ),
    );

  }

  Widget buildEventDate(BuildContext context){

    return Container(
      margin: const EdgeInsets.all(8),
      child : TextFormField(
        keyboardType: TextInputType.none,
        onTap: () {
          setState(() {
          _selectDate(context);
          });
        },
        maxLines: 1,
        controller: _date,
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
            onPressed: () {
              setState(() {
                _selectDate(context);
              });
            },
          ),
        ),
        validator: (eventDate) {
          if (eventDate == null || eventDate.isEmpty) {
            return 'Select Date';
          }
          return null;
        },
      ),
    );
  }

  addEvent() async{
    final event=Event(
      eventName:_name.text,
      eventDescription:_description.text,
      eventTime:DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute),
    );

    await EventsDatabase.instance.create(event);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BaseLayout()),
    );

  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        _time.text="${selectedTime.hour}:${selectedTime.minute} ";
      });
    }
    else if(timeOfDay==selectedTime){
      setState((){
        _time.text="${selectedTime.hour}:${selectedTime.minute} ";
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? dateOfDay= await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2025),
    );
    if(dateOfDay != null && dateOfDay != selectedDate){
      setState((){
        selectedDate=dateOfDay;
        _date.text="${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
    else if(dateOfDay==selectedDate){
      setState((){
        _date.text="${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }
}
