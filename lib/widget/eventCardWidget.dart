import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eventify/model/event.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({Key? key,
    required this.event,
    required this.index,
  }) : super(key: key);

  final Event event;
  final int index;

  @override
  Widget build(BuildContext context) {

    final color= Colors.lightBlue.shade300;
    final time = DateFormat.yMMMMd().format(event.eventTime);
    double minHeight=100;

    return Card(
      color:color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style:const TextStyle(color:Colors.black),
            ),
            const SizedBox(height:4),
            Text(
              event.eventName,
              style: const TextStyle(
                color: Colors.black,
                fontSize:20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
