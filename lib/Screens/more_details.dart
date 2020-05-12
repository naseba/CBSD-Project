import 'package:flutter/material.dart';
import 'package:care_alarm2/Database/database_helper.dart';
import 'package:care_alarm2/Database/medicine.dart';

class MoreDetails extends StatefulWidget {
  //@override
  //_MoreDetailsState createState() => _MoreDetailsState();

  final Medicine medicine;
  MoreDetails(this.medicine);
  @override
  //_SceduleState createState() => _SceduleState();
  State<StatefulWidget> createState() {
    return _MoreDetailsState(this.medicine);
  }
}

class _MoreDetailsState extends State<MoreDetails> {

    Medicine medicine;
   _MoreDetailsState(this.medicine);
     DatabaseHelper databaseHelper=DatabaseHelper();
  TextEditingController pillsNum=TextEditingController();
    TextEditingController refilnum=TextEditingController();

   // int val=1;
  @override
  Widget build(BuildContext context) {
      pillsNum.text=medicine.numOfPills.toString();
      refilnum.text=medicine.pillsLeft.toString();
     // val=medicine.refill;

    TextStyle textStyle=Theme.of(context).textTheme.title;
    
    return Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        title: Text('More Details'),
        actions: <Widget>[
          new IconButton(
          icon: Text('Done',style: TextStyle(fontSize: 20),), 
          iconSize: 60, 
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/HomeScreen',ModalRoute.withName('/'));
            
            save();
            print("done: $medicine.name");
          })
          
        ],
      ),

      body: Column(
        children: <Widget>[
          Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 5.0,bottom: 15.0),
                child: TextField(
                controller: pillsNum,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  medicine.numOfPills=int.parse(pillsNum.text);
                },
                decoration: InputDecoration(
                  labelText: 'Number of pills',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  
                  )
                ),
              ),
              ),

              Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 5.0,bottom: 15.0),
                child: TextField(
                controller: refilnum,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  medicine.pillsLeft=int.parse(refilnum.text);
                },
                decoration: InputDecoration(
                  labelText: 'Pills Left',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  
                  )
                ),
              ),
              ),

          ListTile(
          title: Row(children: <Widget>[
          Padding(
          padding: EdgeInsets.only(right:5.0,left:5.0,top: 20.0),
          child: Text('Refill Reminder  ',style: TextStyle(fontSize: 20,color: Colors.black), ),
          ),

          Padding(
          padding: EdgeInsets.only(right:5.0,left:150.0,top: 20.0),
          child: Switch(
            value: setValue(medicine.refill),
             
            onChanged: (newval){
                setState(() {
                  updateValu(newval);
                });
            }
            )
          ),
          
             ],),
           ), 
        ])
    );
  }

  bool setValue(int value){
    switch (value){
      case 1:
          return true;
          break;
      case 0:
         return false;
          break; 
    }
  }//setValue

   updateValu(bool newValue){
    switch (newValue){
      case true:
          medicine.refill=1;
          break;
      case false:
          medicine.refill=0;
          break; 
    }
  }///updateValu

  void save() async{
    int result;
    if(medicine.id != null) {//Update Operatio
        result= await databaseHelper.updateMedi(medicine);
    }
    else{//insert Operation
      result= await databaseHelper.insertMedi(medicine);
    }

    if(result !=0){ //Success
        showAlartDialog('Status','Medicine Saved Successfully');
    }
    else{ //failure
        showAlartDialog('Status',' Problem Saving Medicine');
    }
  }//Save

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