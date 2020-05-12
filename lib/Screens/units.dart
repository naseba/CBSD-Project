import 'package:care_alarm2/Database/medicine.dart';
import 'package:flutter/material.dart';

class Units extends StatelessWidget{

  Medicine medicine;
  Units(this.medicine);
  final unitList=['pills','cc','ml','gr','Drops','pieces','puffs','teaSpoon','tableSpoon','patch','mcg'];
 // String selected='';
  Widget build(BuildContext context) {

    return Scaffold(    
              
      appBar: AppBar(
        
        title: Text('Units'),
      ),
      
      body: ListView.builder(
        itemCount: unitList.length,
        itemBuilder: (context,index){
          return ListTile(
            
            title: Text(unitList[index],style:TextStyle(fontSize: 20)),
            onTap: (){
              debugPrint(unitList[index]);
              medicine.units=unitList[index];
              Navigator.of(context).pop('/AddMedicine');
              //Navigator.of(context).pop(MaterialPageRoute(
                //builder: (context) => AddMedicine());
            },
          );
        }
      ),
    );
  }

}