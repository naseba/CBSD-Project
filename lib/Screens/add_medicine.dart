//import 'dart:isolate';

import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Screens/scedule.dart';
import 'package:care_alarm2/Screens/units.dart';
import 'package:flutter/material.dart';
import 'package:care_alarm2/Database/medicine.dart';

class AddMedicine extends StatefulWidget{

  
  //final String appBarTitle;
  final Medicine medicine;
  final User user;
  AddMedicine(this.medicine,this.user);
  @override
  //_AddMedicineState createState() => _AddMedicineState(appBarTitle);
  State<StatefulWidget> createState() {
    return AddMedicineState(this.medicine,this.user);
  }
}
  
class AddMedicineState extends State<AddMedicine> {
 
    // String appBarTitle;
    final User user;
     Medicine medicine;
    AddMedicineState(this.medicine,this.user);

    bool get isEditing =>medicine.id!=null;
    TextEditingController mediName=TextEditingController();
    TextEditingController dosage=TextEditingController();
    int count=0;
    
  @override
  Widget build(BuildContext context) {
    if(medicine.id!=null){
      mediName.text=medicine.name;
    dosage.text=medicine.dosage.toString();
    }

    TextStyle textStyle=Theme.of(context).textTheme.title;
    return  Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditing?'Edit Medicine':'Add Medicine'),//if id!=null then the user want to edit the medicine and if the id ==null then it's new medicine
        actions: <Widget>[
          new IconButton(
          icon: Text('Next',style: TextStyle(fontSize: 20)), 
          iconSize: 60, 
          onPressed: (){
           // Navigator.of(context).pushNamed('/Scedule');
           print('the numbel is $count');
           //if(count==3){
             Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Scedule(medicine,user);
                            }));
          // }
          })
          
        ],
      ),
      body: 
        Padding (
          padding:EdgeInsets.only(top: 15.0,left:10.0,right: 10.0,),
          child: ListView(
            children: <Widget>[
              //First Element
              Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 15.0,bottom: 15.0),
                child: TextField(
                controller: mediName,
                style: textStyle,
                onChanged: (value){
                  medicine.name=mediName.text;
                },
                onSubmitted: (valuee){
                  count++;
                },
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
              ),
             //Second Element
               Padding(
                padding: EdgeInsets.only(right:10.0,left:10.0,top: 15.0,bottom: 15.0),
                child: TextField(
                controller: dosage,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  medicine.dosage=int.parse(dosage.text);
                },
                onSubmitted: (valuee){
                  count++;
                },
                decoration: InputDecoration(
                  labelText: 'Dosage',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
              ),
              //Third Element
             ListTile(
                  
                  title: Text('Units' ,style:TextStyle(fontSize: 25),),
                   subtitle: Text(medicine.units ,style:TextStyle(fontSize: 20)),
              
                  trailing: Icon(Icons.chevron_right,color: Colors.grey,),
                  onTap: (){
                    count++;
                    setState(() {
                       
                       //Navigator.of(context).pushNamed('/Units');
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Units(medicine);
                            }));
                       
                    });
                 
                  },  
                    ),  
              
            
        ],
          ),
        ),
    );
    
  }//build
}
