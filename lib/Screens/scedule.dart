import 'package:care_alarm2/Screens/more_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:care_alarm2/Database/medicine.dart';

class Scedule extends StatefulWidget {
  final Medicine medicine;
  Scedule(this.medicine);
  @override
  //_SceduleState createState() => _SceduleState();
  State<StatefulWidget> createState() {
    return _SceduleState(this.medicine);
  }
}

class _SceduleState extends State<Scedule> {

  Medicine medicine;
  _SceduleState(this.medicine);

  List<String> frequency=['As Needed','Every Day','Specific Days','Days interval','Birth Control Days'];
  TextEditingController times=TextEditingController();
  DateTime date=DateTime.now();
  TimeOfDay time=TimeOfDay.now();
  var startDate;
  var endDate;
  var timy;

  
  @override
  Widget build(BuildContext context) {
    TimeOfDay time=TimeOfDay.now();
    startDate=DateFormat.yMMMd().format(DateTime.now());
    times.text=medicine.numOfTimes.toString();
    startDate= medicine.startDate;
    endDate=medicine.endDate;

    if(medicine.id==null){ //if you adding medicine set the start date else dont change it
      medicine.startDate=startDate;
    }

    
    TextStyle textStyle=Theme.of(context).textTheme.title;


//final now = DateTime.now();

//print('the hour : ${now.hour} : ${now.minute}  ');
 //double _timeOfDayToDouble(TimeOfDay tod) => tod.hour + tod.minute/60.0;
 //var min = now.minute;
 //var hour=now.hour; //_timeOfDayToDouble(TimeOfDay.now());
  //print('the time is : $now');

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
                            return MoreDetails(medicine);}));
          })
          
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.only(right:10.0,left:15.0,top: 30.0),
          child: Text('How Many Times A Day?',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),

          Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 5.0,bottom: 15.0),
                child: TextField(
                controller: times,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  medicine.numOfTimes=int.parse(times.text);
                },
                decoration: InputDecoration(
                  labelText: 'times a day',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  
                  )
                ),
              ),
              ),
          Padding(
          padding: EdgeInsets.only(right:10.0,left:15.0,top: 25.0),
          child: Text('What Time?',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
          Padding(
          padding: EdgeInsets.only(right:10.0,top: 5.0),
          child: ListTile(
                title: Text(time.toString()),
                onTap: (){  
                  selecteTime(context);
                  medicine.time='wait';
                },
              ),
          ),
          // Start Date
           ListTile(
            title: Row(children: <Widget>[
              Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('Starts  ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('$startDate',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
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
          child: Text('$endDate',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
          ),
          
             ],),
             onTap: (){
               selecteDate(context);
                 medicine.endDate=endDate;
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
      });
    }
  }

  Future<Null> selecteTime(BuildContext context) async{
    final TimeOfDay picked=await showTimePicker(
      context: context,
     initialTime: time);
    
    if(picked !=null && picked != time){
      setState(() {
        time=picked;
       // time=time.format('HH_colon_mm');
       
      });
    }
  }
  /*void generateTime(DateTime dt ,List<DateTime> dtlist,double numb){
      DateTime time=DateTime.now();
      var day=24*60*60;
      var interval=day/numb; //in second
      dtlist.add(dt.add(Duration(seconds: 120)));
  }*/
  
}

