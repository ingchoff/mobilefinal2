import 'dart:io' as io;
import 'package:mobilefinal2/Model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserProvider{
  static Database db_instance;
  final String TABLE_NAME = 'user';

  Future<Database> get db async{
    if(db_instance == null){
      db_instance = await initDB();
    }
    return db_instance;
  }

  initDB() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'User.db');
    var db = await openDatabase(path,version: 1,onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    //create table
    await db.execute(
      'CREATE TABLE $TABLE_NAME(_id INTEGER PRIMARY KEY AUTOINCREMENT, userid TEXT NOT NULL, name TEXT NOT NULL, age INTEGER NOT NULL, password TEXT NOT NULL)'
      );
  }

  Future<List<User>> getUser() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(
      'SELECT * FROM $TABLE_NAME'
    );
    List<User> users = new List();
    for(int i = 0;i<list.length;i++){
      User user = new User();
      user.id = list[i]['_id'];
      user.userId = list[i]['userid'];
      user.name = list[i]['name'];
      user.age = list[i]['age'];
      user.mypassword = list[i]['password'];
      users.add(user);
    }
    return users;
  }

  void addUser(User user) async {
    var dbConnection = await db;
    String query = 'INSERT INTO $TABLE_NAME(userid, name, age, password) VALUES(\'${user.userId}\', \'${user.name}\', ${user.age}, \'${user.mypassword}\')';
    print(query);
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  void updateUser(User user) async {
    var dbConnection = await db;
    String query = 'UPDATE $TABLE_NAME SET userid=\'${user.userId}\',name=\'${user.name}\',age=\'${user.age}\',password=\'${user.mypassword}\' WHERE _id=${user.id}';
    print(query);
    await dbConnection.transaction((transaction) async {
      return await transaction.rawUpdate(query);
    });
  }

  // void deleteTodo() async {
  //   var dbConnection = await db;
  //   String query = 'DELETE FROM $TABLE_NAME WHERE done=1';
  //   print(query);
  //   await dbConnection.transaction((transaction) async {
  //     return await transaction.rawQuery(query);
  //   });
  // }

}