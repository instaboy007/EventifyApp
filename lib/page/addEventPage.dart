import 'package:flutter/material.dart';
import 'package:eventify/model/event.dart';
import 'package:eventify/database/db.dart';


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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child :TextFormField(
              controller:_name,
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
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child :TextFormField(
              controller:_description,
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
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextFormField(
              onTap: () {
                setState(() {
                  _selectTime(context);
                });
              },
              controller:_time,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:"Time",
                labelText: "Time",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () {
                    setState(() {
                      _selectTime(context);
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Select Time';
                }
                return null;
              },
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
          ElevatedButton(
            onPressed: () async{
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                // await Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => addEvent()),
                // );
                addEvent();
              }
            },
            child: const Text('Add Event'),
          ),
        ],
      ),
    );
  }
  // addUpdateEvent() async{
  //   final isValid=_formKey.currentState!.validate();
  //
  //   if(isValid){
  //     final isUpdating = widget.event !=null;
  //     if(isUpdating){
  //       await updateEvent();
  //     }
  //     else{
  //       await addEvent();
  //     }
  //     Navigator.of(context).pop();
  //   }
  // }
  //
  // updateEvent() async{
  //   final event = widget.event!.copy(
  //     eventName:_name.text,
  //     eventDescription:_description.text,
  //     eventTime:DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute),
  //   );
  //
  //   await EventsDatabase.instance.update(event);
  // }

  addEvent() async{
    final event=Event(
      eventName:_name.text,
      eventDescription:_description.text,
      eventTime:DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute),
    );
    await EventsDatabase.instance.create(event);
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


