import 'package:flutter/material.dart';
import 'package:eventify/model/event.dart';
import 'package:eventify/database/db.dart';
import 'package:eventify/page/eventDetailPage.dart';
import 'package:eventify/widget/eventCardWidget.dart';
import 'package:eventify/page/addEventPage.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  late List<Event> events;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();

    refreshEvents();
  }

  @override
  void dispose(){
    EventsDatabase.instance.close();

    super.dispose();
  }

  Future refreshEvents() async{
    setState(()=>isLoading=true);

    events=await EventsDatabase.instance.readAllEvents();

    setState(()=>isLoading=false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:isLoading ? const CircularProgressIndicator() : events.isEmpty ? const Text('No Events', style:TextStyle(color:Colors.black54,fontSize:24)) : buildEvents(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () async {
      //     await Navigator.of(context).push(
      //       MaterialPageRoute(builder:(context)=> const AddEvent())
      //     );
      //     refreshEvents();
      //   },
      // ),
    );
  }

  Widget buildEvents(){
    return ListView.separated(
        itemCount: events.length,
        itemBuilder: (context,index){
          final event = events[index];
          return GestureDetector(
            onTap : () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventDetailPage(eventId:event.id!),
              ));

              refreshEvents();
            },
              child: EventCardWidget(event: event, index:index),
          );
        },
        separatorBuilder: (BuildContext context, int index)=>const Divider(),
    );
  }

}
