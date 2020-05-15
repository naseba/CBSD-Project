import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:care_alarm2/Database/medicine.dart';
import 'package:care_alarm2/Database/user.dart';
import 'package:flutter/material.dart';

class DatabaseHelper{
    static DatabaseHelper _databaseHelper;
    static Database _database;
    String mediTable='medicine_table';

    String medid='ID';
    String userID='Userid';
    String medname='Name';
    String dosage='Dosage';
    String units='Units';
    String numOfTime='NumOfTimes';//How many times a day
    String time='Time';//when to alart
    String startDate='StartDate';
    String endDate='EndDate';
    String numOfPills='NumOfPills';
    String pillsLeft='PillsLeft';
    String refill='Refill';
    String state='State';

    String userTable='user_table';

    String userid='ID';
    String firstName='FirstName';
    String lastName='LastName';
    String gender='Gender';
    String birthDate='BirthDate';
    String active='Active';

    DatabaseHelper.creatInstance();
    factory DatabaseHelper(){
      if(_databaseHelper==null){
      _databaseHelper=DatabaseHelper.creatInstance();
      }
      return _databaseHelper;
    }
    
    Future<Database> get database async{
      if(_database==null){
        _database=await initializeDatabase ();
      }
      return _database;
    }

    Future<Database> initializeDatabase () async {

      Directory directory=await getApplicationDocumentsDirectory();
      String path=directory.path+'medicine.db';
      //create the database at the given path
      var medDatabase= await openDatabase(path,version:1,onCreate: _creatDb);
      return  medDatabase; 
    }

    void _creatDb(Database db , int newVersion) async{

     /*await db.execute('CREATE TABLE $userTable($userid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'+
                      '$firstName TEXT,$lastName TEXT,$gender TEXT,$birthDate TEXT,$active Text)');*/
      
      await db.execute('CREATE TABLE $mediTable($medid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'+
                      '$medname TEXT,$dosage INTEGER,$units TEXT,$time TEXT,$numOfTime INTEGER Nullable,'+
                      '$startDate TEXT ,$endDate TEXT, $numOfPills INTEGER ,$pillsLeft INTEGER,$refill INTEGER,$state INTEGER,$userID INTEGER)');
                       //($userID) REFERENCES $userTable ($userid)  
    }

  // Fetch Operation : Get one medicine from database based on ID
    Future<List<Map<String,dynamic>>> getMediMapList()async{//int mid
      Database db=await this.database;

      var result=await db.rawQuery('SELECT * FROM $mediTable ');//WHERE $medid = $mid
      return result;
    }
       //Get all User's medicines from database based on User ID
   Future<List<Map<String,dynamic>>> getALLMediMapList()async{//int uid
      Database db=await this.database;

      var result=await db.rawQuery('SELECT * FROM $mediTable');  //ORDER BY $state ASC');//WHERE $userID = $uid
      return result;
    }

      //Get all Users from database
    /*Future<List<Map<String,dynamic>>> getUserMapList(int id)async{
      Database db=await this.database;

      var result=await db.rawQuery('SELECT * FROM $userTable WHERE $userID = $id');
      return result;
    }*/ 

    //Insert Operation:
    Future<int> insertMedi(Medicine medi) async{
      Database db=await this.database;

      var result=await db.insert(mediTable,medi.toMap());
      return result;
    }

  /*  Future<Medicine> insertMedi(Medicine medi) async{
      var dbClient=await this.database;

      medi.id=await dbClient.insert(mediTable, medi.toMap());
      return medi;
    }*/


    /*Future<int> insertUser(User user) async{
      Database db=await this.database;

      var result=await db.insert(userTable,user.toMap());
      return result;
    }*/

    //Updat Operation: 
    Future<int> updateMedi(Medicine medi) async{
      Database db=await this.database;

      var result=await db.update(mediTable,medi.toMap(),where: '$medid=?',whereArgs: [medi.id]);
      return result;
    }

  /*  Future<int> updatetUser(User user) async{
      Database db=await this.database;

      var result=await db.update(userTable,user.toMap(),where: '$userid=?',whereArgs: [user.id]);
      return result;
    }*/

    //Delete Operation:
    Future<int> deleteMedi(int id)async{
       Database db=await this.database;

       var result= await db.rawDelete('DELETE FROM $mediTable WHERE $medid= $id');
       return result;
    }

   /* Future<int> deleteUser(int id)async{
       Database db=await this.database;

       var result= await db.rawDelete('DELETE FROM $userTable WHERE $userid= $id');
       return result;
    }*/
      //Delete User's Medicines from table Medicine if the user Deleted
   /* Future<int> deleteUserMedicine(int userid)async{
       Database db=await this.database;

       var result= await db.rawDelete('DELETE FROM $mediTable WHERE $userID= $userid');
       return result;
    }*/

    //Get number of medicines objects in database
    Future<int> getMedCount() async{
      Database db=await this.database;

      List<Map<String,dynamic>> num=await db.rawQuery('SELECT COUNT (*) FROM $mediTable');
      int result=Sqflite.firstIntValue(num);
      return result;
    }
    //Get number of Users objects in database
    Future<int> getUSerCount() async{
      Database db=await this.database;

      List<Map<String,dynamic>> num=await db.rawQuery('SELECT COUNT (*) FROM $userTable');
      int result=Sqflite.firstIntValue(num);
      return result;
    }

    //Get the 'MapList' [List<Map>] and convert it to 'MediList' [List<Medicine>]
    Future<List<Medicine>> getMediList() async{
      var medMapList= await getALLMediMapList();
      int count =medMapList.length;
      debugPrint('Iam insedgetMediList' );
      List<Medicine> mediList=List<Medicine>();
      for(int i=0;i<count;i++){
        mediList.add(Medicine.fromMApToObject(medMapList[i]));
      }   
      return mediList;
    }
  }

