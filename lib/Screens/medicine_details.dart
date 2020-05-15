
import 'package:care_alarm2/Database/medicine.dart';
import 'package:flutter/material.dart';

class MedicineDetails extends StatelessWidget{

  final Medicine medicine;
  MedicineDetails(this.medicine);

 // String selected='';
  Widget build(BuildContext context) {

    return Scaffold(    
              
      appBar: AppBar(
        
        title: Text('Medicine Details'),
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
          child: Text('User Name : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('${medicine.userid}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('Medicine Name : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('${medicine.name}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
           
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Dosage : ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.dosage}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('How Many Times in a day :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.numOfTimes}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
          ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Medicine Times :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.time}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Medicine StartDate :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.startDate}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),   
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Medicine EndDate :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.endDate}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ), 
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('Number Of Pills :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 10.0),
          child: Text('${medicine.numOfPills}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),     
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('Pills Left :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('${medicine.pillsLeft}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ), 
        ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('Refill :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('${refillToString(medicine.refill)}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ),
          ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('State :   ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 5.0),
          child: Text('${state(medicine.state)}',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
           ), 
      ],)
    );

  }

  String refillToString(int refill){
    switch (refill) {
      case 0:
        return 'No';
        break;
      case 1:
        return 'Yes';
        break;
      default:
        return 'No';
        break;
    }
  }
  String state(int stat){
    switch (stat) {
      case 1://Missed
        return 'Missed';
        break;
      case 2://not Yet
        return 'Not Yet';
        break;
      case 3://Taken
        return 'Taken';
        break;
      default:
        return 'Not Yet';
    }
  }
  
  }