import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Screens/more_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:care_alarm2/Database/medicine.dart';

class Scedule extends StatefulWidget {
  final User user;
  final Medicine medicine;
  Scedule(this.medicine,this.user);
  @override
  //_SceduleState createState() => _SceduleState();
  State<StatefulWidget> createState() {
    return _SceduleState(this.medicine,this.user);
  }
}

class _SceduleState extends State<Scedule> {
  User user;
  Medicine medicine;
  _SceduleState(this.medicine,this.user);
  
  List<int> number;
  //List<String> frequency=['As Needed','Every Day','Specific Days','Days interval','Birth Control Days'];
  TextEditingController times=TextEditingController();
  DateTime date=DateTime.now();
  TimeOfDay time;
  var startDate;
  var endDate;

  
  @override
  Widget build(BuildContext context) {
    number=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
    medicine.numOfTimes=1;

    if(medicine.id==null){ //if you adding medicine set the start date else dont change it
     startDate=DateFormat.yMMMd().format(DateTime.now());
     medicine.startDate=startDate;
     //medicine.time=time.toString();

    }

     if(medicine.id!=null){ //if you adding medicine set the start date else dont change it
     startDate=medicine.startDate;
     endDate=medicine.endDate;
      times.text=medicine.numOfTimes.toString();
    } 
    
    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scedule'),
        actions: <Widget>[
          new IconButton(
          icon: Text('Next',style: TextStyle(fontSize: 20),), 
          iconSize: 60, 
          onPressed: (){
            //Navigator.of(context).pushNamed('/MoreDetails');
            Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MoreDetails(medicine,user);}));
          })
          
        ],
      ),
      body: ListView(
        children: <Widget>[
            Row(children: <Widget>[

              Padding(
          padding: EdgeInsets.only(right:10.0,left:15.0,top: 25.0),
          child: Text('Remind me Every  ',style: TextStyle(fontSize: 25,color: Colors.black), ),
          ),
            ////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(right:10.0,left:15.0,top: 25.0),
              child: DropdownButtonHideUnderline(
                    child:DropdownButton<int>(
                    items: number.map((int selectedItem){
                      return DropdownMenuItem<int>(
                        value:medicine.numOfTimes ,
                        child: Text(selectedItem.toString(),style: TextStyle(fontSize: 25,color: Colors.blueAccent),),
                        );
                    }).toList(), 
                    style: textStyle,
                    
                    onChanged: (int selectedvalue){
                      setState(() {
                        medicine.numOfTimes=selectedvalue;
                      });
                    }
                    ),
                  ),
            ),
            ///////////////////////////////////
          Padding(
          padding: EdgeInsets.only(right:10.0,left:15.0,top: 25.0),
          child: Text(' hours ',style: TextStyle(fontSize: 25,color: Colors.black), ),
          ),

              ],),
          Padding(
          padding: EdgeInsets.only(right:10.0,left:15.0,top: 50.0),
          child: Text('Start Time ',style: TextStyle(fontSize: 25,color: Colors.black), ),
          ),
          Padding(
          padding: EdgeInsets.only(right:10.0,top: 5.0),
          child: ListTile(
                title: Text(time==null?'Tap to set start time ':'${time.hour} : ${time.minute}  ',style: TextStyle(fontSize: 25,color: Colors.blueAccent)),
                onTap: (){  
                  selecteTime(context);
                },
              ),
          ),

          // Start Date
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 50.0),
          child: Text('Starts  ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 50.0),
          child: Text('$startDate',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),
             ],),
           ),
          
          // End Date
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0),
          child: Text('Ends  ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),
          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0),
          child: Text(endDate==null?'Tap to set end date':'$endDate',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
             ],),
             onTap: (){
               selecteDate(context);
             },
             
           ),
        ],
      ),
      
    );
  }

  Future<Null> selecteDate(BuildContext context) async{
    final DateTime picked=await showDatePicker(
      context: context, 
      initialDate: date, 
      firstDate: new DateTime(2015), 
      lastDate: new DateTime(2030));
    
    if(picked !=null && picked != date){
      setState(() {
        endDate=DateFormat.yMMMd().format(picked);
        medicine.endDate=DateFormat.yMMMd().format(picked);
      });
    }
  }

  Future<Null> selecteTime(BuildContext context) async{
    time=TimeOfDay.now();
    final TimeOfDay picked=await showTimePicker(
      context: context,
     initialTime: time);
    
    if(picked !=null && picked != time){
      setState(() {
        time=picked;  
        medicine.time=picked.toString();    
      });
    }
  }

  
}

