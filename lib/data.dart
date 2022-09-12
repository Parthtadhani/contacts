import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class data {
  Future<Database> helo() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');


    // z  pen the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table parth (id integer primary key autoincrement, name text, company text,title text, number text)');
    });
    return database;
  }

  insertdata(String name1, String company1, String title1, String phone1,
      Database database) async {
    String insert =
        "insert into parth (name,company,title,number)values('$name1','$company1','$title1','$phone1')";
    int cnt = await database.rawInsert(insert);
    print(cnt);
  }

  Future<List<Map>> viewdat(Database database) async {
    String vied = "select * from parth";
    List<Map> list = await database.rawQuery(vied);
    return list;
  }

  void detel(int id, Database database) {
    String delet="delete from parth where id='$id'";
    database.rawDelete(delet);
  }

  void update(String name1,String company1, String title1, String phone1, Database database, int id) {
    String update="update parth set name='$name1',company='$company1',title='$title1',number='$phone1' where id='$id'";
    database.rawUpdate(update);
  }
}
