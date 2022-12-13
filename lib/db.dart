import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS data( 
                          id primary key,
                          name varchar(255) not null,
                          roll_no int not null
                      );

                      //create more table here
                  
                  ''');
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getData(int rollno) async {
    List<Map> maps =
        await db.query('data', where: 'roll_no = ?', whereArgs: [rollno]);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
