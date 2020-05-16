import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Database/userDatabase.dart';
import 'package:care_alarm2/Screens/editProfile.dart';
import 'package:care_alarm2/Screens/profile.dart';
import 'package:care_alarm2/widget.dart/gridCell.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Accounts extends StatefulWidget {

  @override
 _AccountsState createState() => _AccountsState();

}

class _AccountsState extends State<Accounts> {

  User user;

  UserDatabase userDatabase=UserDatabase();

  List<User> userList;
  
  int count;
  @override
  Widget build(BuildContext context) {
      if(userList==null){
        userList=List<User>();
         getUsersList();
          print('the user number : $count');
      }

      if(user!=null){
        userList.add(user);
        getUsersList();
      }
     
   

    return  Scaffold(
      appBar: AppBar(        
        title: Text('Accounts'),
      ),
      body:GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: userList.length,
      itemBuilder: (BuildContext context,int index){
        return GestureDetector(
                  child: Container(
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                Icon(Icons.contact_phone,size: 100,),
                Text("${userList[index].firstName} ${ userList[index].lastName}" ,style: TextStyle(fontSize: 25)),
                
               ],),
          ),
          onTap: (){
            //userDatabase.deleteUser(userList[index].id);
            //getUsersList();
            //print('user datelted');
             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return EditProfile(userList[index]);}));

          },
        );
      },
      
      
    ),
  );
  }

  void getUsersList() {
     final Future<Database> dbFututre =userDatabase.database;
     dbFututre.then((database){
       Future<List<User>> userListFuture=userDatabase.getUsersList();
       userListFuture.then((userList){       
           setState(() {
             this.userList=userList;
           });
          // register=true;
           //print('the result is $register');
         //  this.count=medicineList.length;
       }); 
      });
  }
}

/*Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: GridTile(child: GridCell(),),
            onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Profile(user);}));
            },
          ),
                 
         ],
      ),*/


