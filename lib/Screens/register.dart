import 'package:care_alarm2/Database/database_helper.dart';
import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Database/userDatabase.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static var gender=['Male','Femail'];
  User user =User('','','','',1);
  List<User> userList;
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  UserDatabase databaseHelper=UserDatabase();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text('Register')),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0,left:10.0,right: 10.0,),
           child: ListView(
             children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 15.0,bottom: 15.0),
                child: 
                TextField(
                controller: firstName,
                style: textStyle,
                
                onChanged: (value){
                  user.firstName=value;
                },
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 15.0,bottom: 15.0),
                child: 
                TextField(
                controller: lastName,
                style: textStyle,
                onChanged: (value){
                  user.lastName=value;
                },
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
              ),  
              ListTile(title: Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right:70.0,left:10.0,top: 20.0),
                    child: Text('Gender  ',style: TextStyle(fontSize: 20,color: Colors.black), ),
                ),
                DropdownButtonHideUnderline(
                  child:DropdownButton(
                  items: gender.map((String selectedItem){
                    return DropdownMenuItem(
                      value:selectedItem ,
                      child: Text(selectedItem),
                      );
                  }).toList(), 
                  style: textStyle,
                  
                  onChanged: (String selectedvalue){
                    setState(() {
                      user.gender=selectedvalue;
                    });
                  }
                  ),
                ),
              ],) , ),
              Padding(
                padding: EdgeInsets.only(top:50),
                child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text('Save',textScaleFactor: 1.5,),
                onPressed: (){
                  //  save();
                }
                ),)
          ],
        ),
        ),
      
    );
  }

  void save() async{
    int result;
    int number=0;
    if(user.id != null) {//Update Operatio
        result= await databaseHelper.updatetUser(user);
      //  Navigator.of(context).pushNamed('/HomeScreen');
    }
    if(user.id == null){//insert Operation
      result= await databaseHelper.insertUser(user);
      Navigator.of(context).pushNamed('/HomeScreen');
      number=await databaseHelper.getUSerCount();
      print('The users number ${number.toString()}');
    }

    if(result !=0){ //Success
        showAlartDialog('Status','Medicine Saved Successfully');

    }
    else{ //failure
        showAlartDialog('Status',' Problem Saving Medicine');
    }
  }
   void showAlartDialog(String title,String message){
    AlertDialog alertDialog=AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_)=>alertDialog
      );
  }//showAlartDialog

}