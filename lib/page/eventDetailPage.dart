import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eventify/database/db.dart';
import 'package:eventify/model/event.dart';

class EventDetailPage extends StatefulWidget {
  final int eventId;

  const EventDetailPage({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late Event event;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshEvents();
  }

  Future refreshEvents() async{
    setState(() {
      isLoading = true;
    });

    this.event = await EventsDatabase.instance.readEvent(widget.eventId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                padding:const EdgeInsets.symmetric(vertical:8),
                children:[
                  Text(
                    event.eventName,
                    style: const TextStyle(
                      color:Colors.black,
                      fontSize:22,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height:8),
                  Text(
                    DateFormat.yMMMMd().format(event.eventTime),
                    style:const TextStyle(color:Colors.black),
                  ),
                  const SizedBox(height:8),
                  Text(
                    event.eventDescription,
                    style:const TextStyle(color:Colors.black,fontSize: 18),
                  )
                ],
              ),
            ),
    );
  }
}
