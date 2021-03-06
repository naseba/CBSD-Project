import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:care_alarm2/Database/user.dart';

class UserDatabase{

    static UserDatabase _userDatabase;
    static Database _database;

    String userTable='user_table';

    String userid='ID';
    String firstName='FirstName';
    String lastName='LastName';
    String gender='Gender';
    String place='Place';
    String active='Active';

    UserDatabase.creatInstance();
    factory UserDatabase(){
      if(_userDatabase==null){
      _userDatabase=UserDatabase.creatInstance();
      }
      return _userDatabase;
    }
    
    Future<Database> get database async{
      if(_database==null){
        _database=await initializeDatabase ();
      }
      return _database;
    }

    Future<Database> initializeDatabase () async {

      Directory directory=await getApplicationDocumentsDirectory();
      String path=directory.path+'User.db';
      //create the database at the given path
      var userDatabase= await openDatabase(path,version:1,onCreate: _creatDb);
      return  userDatabase; 
    }

    void _creatDb(Database db , int newVersion) async{

     await db.execute('CREATE TABLE $userTable($userid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'+
                      '$firstName TEXT,$lastName TEXT,$gender TEXT,$place TEXT,$active INTEGER )');
    }
    Future<List<Map<String,dynamic>>> getUserMapList()async{
      Database db=await this.database;

      var result=await db.rawQuery('SELECT * FROM $userTable');
      return result;
    }
    Future<User> getActiveUser()async{
      Database db=await this.database;
      User user;
      var result=await db.rawQuery('SELECT * FROM $userTable WHERE $active = 1 ');
      user=User.fromMApToObject(result[0]);
      return user;
    }
    Future<int> insertUser(User user) async{
      Database db=await this.database;

      var result=await db.insert(userTable,user.toMap());
      return result;
    }

    //Updat Operation: 
     Future<int> updatetUser(User user) async{
      Database db=await this.database;

      var result=await db.update(userTable,user.toMap(),where: '$userid=?',whereArgs: [user.id]);
      return result;
    }

      Future<int> deleteUser(int id)async{
       Database db=await this.database;

       var result= await db.rawDelete('DELETE FROM $userTable WHERE $userid= $id');
       return result;
    }
      //Delete User's Medicines from table Medicine if the user Deleted


   //Get number of Users objects in database
    Future<int> getUSerCount() async{
      Database db=await this.database;

      List<Map<String,dynamic>> num=await db.rawQuery('SELECT COUNT (*) FROM $userTable');
      int result=Sqflite.firstIntValue(num);
      return result;
    }

    //Get the 'MapList' [List<Map>] and convert it to 'MediList' [List<Medicine>]
    Future<List<User>> getUsersList() async{
      var userMapList=await getUserMapList();
      int count =userMapList.length;
     // debugPrint('Iam insedgetMediList' );
      List<User> userList=List<User>();
      for(int i=0;i<count;i++){
        userList.add(User.fromMApToObject(userMapList[i]));
      }   
      return userList;
    }
  }


