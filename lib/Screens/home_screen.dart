import 'package:care_alarm2/Database/database_helper.dart';
import 'package:care_alarm2/Database/medicine.dart';
import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Screens/add_medicine.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Medicine> medicineList; // to display all medicine in the listviwe
  List<User> userList;
  int count=0;
  
  @override
  Widget build(BuildContext context) {

    if(medicineList==null){
      medicineList=List<Medicine>();
      updateListView();
    }
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
            navigateToDetail(Medicine(1,'',1,'',3,'','','','',10,3,1,2),'Add Medicine');
        },
        ),
    );
  }//build

  ListView getMediList(){

    TextStyle titlestyle=Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount:count,
        itemBuilder: (BuildContext context,int position){
          return Card(
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
             // debugPrint('ListTitle Tapped');
             // Navigator.of(context).pushNamed('/MedicineDetails');
             navigateToDetail(this.medicineList[position],'Edit Medicine');
            },

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
     final Future<Database> dbFututre =databaseHelper.initializeDatabase();
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

   void navigateToDetail(Medicine medicine,String title){//

     Navigator.push(context, MaterialPageRoute(builder: (context){
        return AddMedicine(medicine,title);
     }));
   }

  }


