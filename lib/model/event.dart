const String tableEvents = 'events';

class EventFields{
  static const String id = '_id';
  static const String eventName = 'eventName';
  static const String eventDescription = 'eventDescription';
  static const String eventTime= 'eventTime';
}

class Event{
  final int? id;
  final String eventName;
  final String eventDescription;
  final DateTime eventTime;

  const Event({
    this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventTime,
  });

  Event copy({
    int? id,
    String? eventName,
    String? eventDescription,
    DateTime? eventTime,
  })=>
    Event(
      id : id ?? this.id,
      eventName : eventName ?? this.eventName,
      eventDescription : eventDescription ?? this.eventDescription,
      eventTime : eventTime ?? this.eventTime,
    );

  Map<String,Object?> toJson() => {
    EventFields.id : id,
    EventFields.eventName : eventName,
    EventFields.eventDescription : eventDescription,
    EventFields.eventTime : eventTime.toIso8601String(),

  };
}