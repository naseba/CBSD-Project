import 'package:care_alarm2/Database/user.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget{

  final User user;
  Profile(this.user);

 // String selected='';
  Widget build(BuildContext context) {

    return Scaffold(    
              
      appBar: AppBar(
        
        title: Text('User Profile'),
        actions: <Widget>[
          new IconButton(
          icon: Text('Done',style: TextStyle(fontSize: 20),), 
          iconSize: 60, 
          onPressed: (){
           Navigator.of(context).pushNamedAndRemoveUntil('/HomeScreen',ModalRoute.withName('/'));
            
          }),
        ],
      ),
      
      body: ListView(children: <Widget>[

        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('First Name : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('${user.firstName}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('Last Name : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('${user.lastName}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
           
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Gender : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${user.gender}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('place :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${user.palce}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
          ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Active :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${user.active.toString()}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
         
      ],)
    );

  }
  
  }