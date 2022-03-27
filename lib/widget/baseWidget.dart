import 'package:flutter/material.dart';
import 'package:eventify/widget/eventWidget.dart';
import 'package:eventify/page/addEventPage.dart';
import 'calendarWidget.dart';

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