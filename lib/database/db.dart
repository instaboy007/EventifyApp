import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eventify/model/event.dart';

class EventsDatabase{

  static final EventsDatabase instance=EventsDatabase._init();
  static Database? _database;
  EventsDatabase._init();

  Future<Database> get database async{
    print(await getDatabasesPath());
    if(_database!=null) return _database!;

    _database=await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath=await getDatabasesPath();
    final path=join(dbPath,filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version) async{

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableEvents(
        ${EventFields.id} $idType,
        ${EventFields.eventName} $textType,
        ${EventFields.eventDescription} $textType,
        ${EventFields.eventTime} $textType
      )
    ''');
  }

  Future<Event> create(Event event) async{
    final db = await instance.database;
    final id = await db.insert(tableEvents,event.toJson());

    return event.copy(id: id);
  }

  Future<Event> readEvent(int id) async {
    final db = await instance.database;

    final maps=await db.query(
      tableEvents,
      columns:EventFields.values,
      where: '${EventFields.id}=?',
      whereArgs:[id],
    );

    if(maps.isNotEmpty){
      return Event.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not Found!');
    }
  }

  Future<List<Event>> readAllEvents() async{
    final db = await instance.database;
    const orderBy = '${EventFields.eventTime} ASC';

    final result = await db.query(tableEvents, orderBy: orderBy);

    return result.map((json) => Event.fromJson(json)).toList();
  }

  Future<int> update(Event event) async{
    final db = await instance.database;

    return db.update(
      tableEvents,
      event.toJson(),
      where: '${EventFields.id} = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableEvents,
      where :'${EventFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db=await instance.database;
    db.close();
  }

}