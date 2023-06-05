import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  Future<Database> GetDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'create table login(id integer primary key autoincrement,name text, email text, number text,password text)');
      await db.execute(
          'create table contact(id integer primary key autoincrement, name text, userid integer,number text)');
    });
    return database;
  }

  Future<bool> insertData(String nname, String eemail, String nnumber,
      Database database, String pass) async {
    String checkdata =
        "select * from login where email = '$eemail' or name = '$nname'";
    List<Map> selecteddata = await database.rawQuery(checkdata);
    if (selecteddata.length == 0) {
      String insertqry =
          "insert into login(name,email,number,password) values('$nname','$eemail','$nnumber','$pass')";
      database.rawInsert(insertqry);
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map>> Loginuser(
      String email, String pass, Database database) async {
    String loginn =
        "select * from login where email = '$email' and password = '$pass'";
    List<Map> list = await database.rawQuery(loginn);
    print("===$list");
    return list;
  }

  Future<void> insertcontact(
      String name, String number, int userid, Database db) async {
    String data =
        "insert into contact(name,userid,number) values('$name','$userid','$number')";
    int cb = await db.rawInsert(data);
    print(cb);
  }

  Future<List<Map>> contactview(int userid, Database db) async {
    String contactviewdata = "select * from contact where userid = '$userid'";
    List<Map> contactv = await db.rawQuery(contactviewdata);
    return contactv;
  }

  Future<void> update(
      String newname, String newnumber, int id, Database db) async {
    String updatecontact =
        "update contact set name = '$newname', number = '$newnumber' where id = '$id'";
    int aa = await db.rawUpdate(updatecontact);
  }

  Future<void> deleteContact(userid, Database db) async {
    String delete = "delete from contact where id ='$userid'";
    int aa = await db.rawDelete(delete);
  }
}
