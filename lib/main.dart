import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(
    home : BaseLayout()
  ));
}

class BaseLayout extends StatefulWidget {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0;
  
  void onItemTapped(int _index) {
    setState(() {
      _selectedIndex = _index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Events(),
    AddEvent(),
    Calendar()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Eventify')
        ),
        body: Center(
          child :Align(
            alignment:Alignment.topLeft,
            child:_widgetOptions.elementAt(_selectedIndex),
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
            items:const [
              BottomNavigationBarItem(icon: Icon(Icons.alarm),label: 'Events'),
              BottomNavigationBarItem(icon:Icon(Icons.add),label: 'Add Event'),
              BottomNavigationBarItem(icon:Icon(Icons.calendar_month),label: 'Calendar')
            ],
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
        )
    );
  }
}

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return const Text('Events Page');
  }
}

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
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
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Date and Time",
                  suffixIcon: IconButton(
                      icon:const Icons.calendar_month,
                      onPressed: () {
                        _selectTime(context);
                      },
                  ),
                ),
              ),
            ),
          SizedBox(
              width: 100, // <-- Your width
              height: 50.0, // <-- Your height
              child: ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Pick Time",
                      textAlign: TextAlign.center,

                    ),
                  )),
          ),
          Text("${selectedTime.hour}:${selectedTime.minute}"),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Add Event'),
          ),
        ],
      ),
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
      });
    }
  }
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return const Text('Calendar');
  }
}










