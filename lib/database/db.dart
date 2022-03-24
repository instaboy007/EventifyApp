import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eventify/model/event.dart';

class EventsDatabase{

  static final EventsDatabase instance=EventsDatabase._init();
  static Database? _database;
  EventsDatabase._init();

  Future<Database> get database async{
    if(_database!=null) return database!;

    _database=await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath=await getDatabasesPath();
    final path=join(dbPath,filePath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version) async{

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableEvents(
        ${EventFields.id} $idType,
        ${EventFields.eventName} $textType,
        ${EventFields.eventDescription} $textType,
        ${EventFields.eventTime} $textType,
      )
    ''');
  }

  Future<Event> create(Event event) async{
    final db = await instance.database;
    final id = await db.insert(tableEvents,event.toJson());

    return event.copy(id:id);
  }

  Future close() async{
    final db=await instance.database;
    db.close();
  }

}