import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Database/userDatabase.dart';
import 'package:care_alarm2/Screens/accounts.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
 final  User user;
  EditProfile(this.user);
  @override
 // _EditProfilerState createState() => _EditProfilerState();
 State<StatefulWidget> createState() {
    return _EditProfilerState(this.user);
  }
}

class _EditProfilerState extends State<EditProfile> {
 
  User user;
  _EditProfilerState(this.user);

   static var gender=['Male','Femail'];
  List<User> userList;
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController country=TextEditingController();

  UserDatabase databaseHelper=UserDatabase();
  Accounts accounts=Accounts();
  @override
  Widget build(BuildContext context) {
    if(user.id!=null){
      firstName.text=user.firstName;
    lastName.text=user.lastName;
    country.text=user.palce;
    }
    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text('EditProfile')),
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
              Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 15.0,bottom: 15.0),
                child: 
                TextField(
                controller: country,
                style: textStyle,
                onChanged: (value){
                  user.palce=value;
                },
                decoration: InputDecoration(
                  labelText: 'Country',
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
              Row(children: <Widget>[
             Padding(
                padding: EdgeInsets.only(top:50),
                child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text('Edit',textScaleFactor: 1.5,),
                onPressed: (){
                  edit();
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //            return Accounts(user);}));
                    Navigator.of(context).pop();
                }
                ),),
                Padding(
                padding: EdgeInsets.only(top:50),
                child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text('Delete',textScaleFactor: 1.5,),
                onPressed: (){
                    databaseHelper.deleteUser(user.id);
                    Navigator.of(context).pop(true);
                    
                }
                ),),]),
          ],
        ),
        ),
      
    );
  }

  void edit() async{
    int result;
    int number=0;
    if(user.id != null) {//Update Operatio
        result= await databaseHelper.updatetUser(user);
        number=await databaseHelper.getUSerCount();
       print('The users Edit Number ${number.toString()}');

      }
   /* if(user.id == null){//insert Operation
      result= await databaseHelper.insertUser(user);
      number=await databaseHelper.getUSerCount();
      print('The users number ${number.toString()}');
      print(user);
    }*/

    if(result !=0){ //Success
        showAlartDialog('Status','User Saved Successfully');

    }
    else{ //failure
        showAlartDialog('Status',' Problem Saving User');
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