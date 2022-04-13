import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eventify/model/event.dart';

final _lightColors =[
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100,
  Colors.redAccent.shade100,
  Colors.purpleAccent.shade100
];

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({Key? key,
    required this.event,
    required this.index,
  }) : super(key: key);

  final Event event;
  final int index;


  @override
  Widget build(BuildContext context) {

    final color= _lightColors[index%_lightColors.length];
    final date = DateFormat.MMMd('en-US').format(event.eventTime);
    final time = DateFormat.Hm().format(event.eventTime);
    double minHeight=120;

    return Card(
      color:color,
      margin: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  event.eventName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize:25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.white,fontSize:40,fontWeight: FontWeight.w900),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade700,fontSize: 20,fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
