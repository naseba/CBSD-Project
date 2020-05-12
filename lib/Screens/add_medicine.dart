import 'package:care_alarm2/Screens/scedule.dart';
import 'package:care_alarm2/Screens/units.dart';
import 'package:flutter/material.dart';
import 'package:care_alarm2/Database/medicine.dart';

class AddMedicine extends StatefulWidget{

  //String selected;
  //AddMedicine(this.selected);

  final String appBarTitle;
  final Medicine medicine;
  AddMedicine(this.medicine,this.appBarTitle);
  @override
  //_AddMedicineState createState() => _AddMedicineState(appBarTitle);
  State<StatefulWidget> createState() {
    return AddMedicineState(this.medicine,this.appBarTitle);
  }
}
  
class AddMedicineState extends State<AddMedicine> {
  //String selected;
 // _AddMedicineState(this.selected);
     String appBarTitle;
     Medicine medicine;
    AddMedicineState(this.medicine,this.appBarTitle);

  
    TextEditingController mediName=TextEditingController();
    TextEditingController dosage=TextEditingController();
  @override
  Widget build(BuildContext context) {
    mediName.text=medicine.name;
    dosage.text=medicine.dosage.toString();

    TextStyle textStyle=Theme.of(context).textTheme.title;
    return Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        actions: <Widget>[
          new IconButton(
          icon: Text('Next',style: TextStyle(fontSize: 20),), 
          iconSize: 60, 
          onPressed: (){
           // Navigator.of(context).pushNamed('/Scedule');
           Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Scedule(medicine);
                            }));
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
                  //if(medicine.units !=null)
                   subtitle: Text(medicine.units ,style:TextStyle(fontSize: 20)),
              
                  trailing: Icon(Icons.chevron_right,color: Colors.grey,),
                  onTap: (){
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
  }
  
}