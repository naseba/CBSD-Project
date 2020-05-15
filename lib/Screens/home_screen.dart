import 'package:care_alarm2/Database/database_helper.dart';
import 'package:care_alarm2/Database/medicine.dart';
import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Screens/add_medicine.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'medicine_details.dart';

class HomeScreen extends StatefulWidget {
 final Medicine medicine;
  HomeScreen(this.medicine);
  @override
  //_HomeScreenState createState() => _HomeScreenState();
  State<StatefulWidget> createState() {
    return _HomeScreenState(this.medicine);
  }
}

class _HomeScreenState extends State<HomeScreen> {
    Medicine medicine;
  _HomeScreenState(this.medicine);

  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Medicine> medicineList; // to display all medicine in the listviwe
  List<User> userList;
  int count;
  bool result;
  int fieldCount;
  
  @override
  Widget build(BuildContext context) {
    countfield(fieldCount);
     // medicineList=[new Medicine.withID(1,1, 'Medicine12', 15, 'ml', 3, '', '15/5/2020', '', 15, 1, 0, 1)];
    if(medicineList==null){
      medicineList=List<Medicine>();
      print('the list lenth befor =${medicineList.length.toString()} ');
      updateListView();
      print('the list lenth =${medicineList.length.toString()} ');
    }
    // updateListView();
    if(userList==null){
      userList=List<User>(); 
    }
    return Scaffold(    
              
      appBar: AppBar(        
        title: Text('Medicines'),
      ),
      
      body: getMediList(),

       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Medicine',
        onPressed: () {
            //Navigator.of(context).pushNamed('/AddMedicine');
            //navigateToDetail(Medicine(1, '', 1, '', 1, '', '', '', 1, 1, 0, 2));
            
     Navigator.push(context, MaterialPageRoute(builder: (context){
        return AddMedicine(Medicine(1, '', 1, '', 1, '', '', '', 1, 1, 0, 2));
     }));
        },
        ),
    );
  }//build

  ListView getMediList(){

    TextStyle titlestyle=Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount:medicineList.length,
        itemBuilder: (BuildContext context,int position){
          return Dismissible(
            key: ValueKey(this.medicineList[position].id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction){
              if(result==true)
              delete(context, this.medicineList[position]);
            },
            confirmDismiss: (direction) async{
             showAlartDialog( result);
              return result;
            },
            background: Container(
              color:Colors.red,
              padding:EdgeInsets.only(right:16),
              child: Align(child: Icon(Icons.delete,color:Colors.white),alignment: Alignment.centerRight,),
            ),
                      child: Card(
              color: Colors.white,
              elevation: 2.0, 
              child: ListTile(
                leading: CircleAvatar(
                backgroundColor: getStateColor(this.medicineList[position].state),
                child: getStateIcon(this.medicineList[position].state),
              ),

              title: Text(this.medicineList[position].name,style: titlestyle,),
              subtitle: Text(this.medicineList[position].dosage.toString()+"  "+this.medicineList[position].units),
              onTap: (){
                
              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return MedicineDetails(this.medicineList[position]);}));
              },

              onLongPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AddMedicine(this.medicineList[position]);}));
              },

              ),
            ),
          );
        }
      );
  }//getMediList


  
  Color getStateColor(int state){
    switch(state){      
      case 1://Missed
        return Colors.red;
        break;
      case 2://not Yet
        return Colors.blue;
        break;
      case 3://Taken
        return Colors.green;
        break;
      default:
        return Colors.blue;
    }
  }//getStateColor

  Icon getStateIcon(int state){
    switch(state){
      case 1://Missed
        return Icon(Icons.cancel);
        break;
      case 2://not Yet
        return Icon(Icons.check_circle_outline);
        break;
      case 3://Taken
        return Icon(Icons.check_circle);
        break;
      default:
        return Icon(Icons.check_circle_outline);
    }
  }//getStateIcon

  void updateListView(){
     final Future<Database> dbFututre =databaseHelper.database;
     dbFututre.then((database){
       Future<List<Medicine>> medListFuture=databaseHelper.getMediList();
       medListFuture.then((medicineList){
         setState(() {
           this.medicineList=medicineList;
           this.count=medicineList.length;
         });
       }); 
      });
  }//updateListView
  
   void delete(BuildContext context,Medicine medicine) async{
     //int  result=
     await databaseHelper.deleteMedi(medicine.id);
     updateListView();
     final snackBar=SnackBar(content: Text('Medicine Deleted Successfully'));
     Scaffold.of(context).showSnackBar(snackBar);
   }//delete

   void navigateToDetail(Medicine medicine){//

     Navigator.push(context, MaterialPageRoute(builder: (context){
        return AddMedicine(medicine);
     }));
   }//navigateToDetail

    showAlartDialog(bool result){
    AlertDialog alertDialog=AlertDialog (
      title: Text('Warning'),
      content: Text('Are you sure you want to delete this medicine ?'),
      actions: <Widget>[
        FlatButton(
        onPressed: (){
          Navigator.of(context).pop();
          result=true;
            print(result);}, 
        child: Text(" Yes ")),
        FlatButton(
          onPressed: (){
             Navigator.of(context).pop();
             result=false;
              print(result);}, 
          child: Text(" No "))
      ],
    );
      showDialog(
         context: context,
          builder: (_)=>alertDialog
               );
  }//showAlartDialog

    void countfield(int numb) async{
      numb=await databaseHelper.getMedCount();
       print('the number of medicines  =$numb ');
    }
  }


