// import 'package:eventify/page/addEventPage.dart';
import 'package:eventify/page/addEditEventPage.dart';
import 'package:eventify/widget/eventFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eventify/database/db.dart';
import 'package:eventify/model/event.dart';

import '../widget/baseWidget.dart';

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

    event = await EventsDatabase.instance.readEvent(widget.eventId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                padding:const EdgeInsets.symmetric(vertical:8),
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.Hm().format(event.eventTime),
                        style:const TextStyle(
                          color:Colors.white,
                          fontSize:90,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.MMMd('en-US').format(event.eventTime),
                        style:const TextStyle(
                          color:Colors.white,
                          fontSize:25,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height:25),
                  Text(
                    event.eventName,
                    style: const TextStyle(
                      color:Colors.lightBlue,
                      fontSize:35,
                      fontWeight:FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height:8),
                  Text(
                    event.eventDescription,
                    style:const TextStyle(
                        color:Colors.white70,
                        fontSize: 28
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() => IconButton(
    icon: const Icon(Icons.edit_outlined),
    onPressed: () async {
      if(isLoading) return;

      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  AddEditEventPage(event: event),
      ));
      refreshEvents();
    },
  );

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await EventsDatabase.instance.delete(widget.eventId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BaseLayout()),
      );
    },
  );
}
