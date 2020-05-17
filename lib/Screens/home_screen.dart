import 'package:care_alarm2/Database/database_helper.dart';
import 'package:care_alarm2/Database/medicine.dart';
import 'package:care_alarm2/Database/user.dart';
import 'package:care_alarm2/Screens/add_medicine.dart';
import 'package:care_alarm2/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  final Medicine medicine;
  final User user;

  HomeScreen(this.medicine,this.user);
  @override
  //_HomeScreenState createState() => _HomeScreenState();
 State<StatefulWidget> createState() {
   
    return _HomeScreenState(this.medicine,this.user);
  }
  }


class _HomeScreenState extends State<HomeScreen> {

  User user;
   Medicine medicine=Medicine(1, '', 1, '', 1, '', '', '', 1, 1, 0, 1);

     _HomeScreenState(this.medicine,this.user);
     
     
    DatabaseHelper databaseHelper=DatabaseHelper();
   List<Medicine> medicineList;
   bool result;
  @override
  Widget build(BuildContext context) {
    if(medicineList==null){
      medicineList=List<Medicine>();
      updateListView();
    }
    if(medicine!=null){
      medicineList.add(medicine);
      updateListView();
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
             Positioned(
               child:Container(
                 width: MediaQuery.of(context).size.width,
                 height:  MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  color:Color(0xff5a348b),
                  gradient: LinearGradient(
                   colors: [Color(0xff8d70fe),Color(0xff2da9ef)],
                   begin: Alignment.centerRight,
                   end: Alignment(-1.0,-1.0) ),
                ),
                child: appBarWidget() ,
               ), ),
               Positioned(
                 top:160.0,
                 left: 18.0,
                 child: Container(
                   color: Colors.white,
                   width: 380.0,
                   height: MediaQuery.of(context).size.height/1.5,
                 child: getMediList(), 
                 ),),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xff2da9ef) ,
        foregroundColor: Color(0xffffffff),
        onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddMedicine(Medicine(1, '', 1, '', 1, '', '', '', 1, 1, 0, 1),user);
                            }));
        },
        tooltip: 'Add Medicine',
        child: new Icon(Icons.add),
         ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
         bottomNavigationBar: BottomAppBar(
           color:  Color(0xff2da9ef),
           shape: CircularNotchedRectangle(),
           child: Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               IconButton(
                 icon: Icon(Icons.face),
                 color: Colors.white,
                 tooltip: 'Profile',
                 onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Profile(user);}));
                 },
               ),
               IconButton(
                 icon: Icon(Icons.people_outline),
                 color: Colors.white,
                 tooltip: 'Accounts',
                 onPressed: (){
                   Navigator.of(context).pushNamed('/Accounts');
                 },
               ),
             ],
           ),
         ),


    );
  }

  Widget appBarWidget(){
    DateTime dateTime=DateTime.now();
    String day=DateFormat('d').format(dateTime);
    String month= DateFormat('LLLL').format(dateTime);
    String year =DateFormat('y').format(dateTime);
    return Align(
      child: ListTile(
        leading: Text(day,style: TextStyle(fontSize: 50.0,color:Colors.amber)),
        title: Text(month,style: TextStyle(fontSize: 34.0,color:Colors.white)),
        subtitle: Text(year,style: TextStyle(fontSize: 24.0,color:Colors.white)),
      ) ,
    );
  }

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

  ListView getMediList(){

   // TextStyle titlestyle=Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount:medicineList.length,
        itemBuilder: (BuildContext context,int position){
          return Dismissible(
            
            key: ValueKey(this.medicineList[position].id),
            background: hiddenContaner(medicineList[position].state) ,
            child: listContaner(
              medicineList[position].name,medicineList[position].state,
              medicineList[position].dosage,medicineList[position].units) ,

            confirmDismiss: (direction) async{
              if(direction==DismissDirection.startToEnd){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddMedicine(medicineList[position],user);
                            }));
              }
              if(direction==DismissDirection.endToStart){
                showAlartDialog( result,this.medicineList[position]);
              }
              return true;
            },
          );
        }
      );
  }
 
  Widget listContaner(String medicineName,int state,int dosage,String units){

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child:Container(
        height:80.0,
        child:Material( 
         color:Colors.white,
         elevation: 14.0,
         shadowColor: Color(0x802196F3),
         child:Container(
           child: Row(
               children: <Widget>[
                 Container(
                   height:80.0,
               width:15,
               color:getStateColor(state),
                 ),
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Align(
                         alignment: Alignment.topLeft,
                         child: Container(
                          child: Text(medicineName,style:TextStyle(fontSize: 25.0,color:Colors.black,fontWeight: FontWeight.bold)),
                         )
                       ),
                       Align(
                         alignment: Alignment.topLeft,
                         child: Container(
                          child: Text('${dosage.toString()}   $units',style:TextStyle(fontSize: 20.0,color:Colors.black,fontWeight: FontWeight.bold)),
                         )
                       ),
                     ],
                   ),),
               ],
           ),
         ),

    ),),);
  }
  
  Widget hiddenContaner(int sate){
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: getStateColor(sate) ,
      child: Row(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.delete),
              color:Colors.white,
              onPressed: (){
                setState(() {
                  
                });
              },
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.edit),
              color:Colors.white,
              onPressed: (){
                setState(() {
                  
                });
              },
            ),
          ),
        ],),

    );
  }
 
  showAlartDialog(bool result,Medicine medicine){
    AlertDialog alertDialog=AlertDialog (
      title: Text('Warning'),
      content: Text('Are you sure you want to delete this medicine ?'),
      actions: <Widget>[
        FlatButton(
        onPressed: (){
          delete(context, medicine);
          Navigator.of(context).pop();
          result=true;
            print(result);
          }, 
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
 
  void delete(BuildContext context,Medicine medicine) async{
     //int  result=
     await databaseHelper.deleteMedi(medicine.id);
     updateListView();
     }
 
   void updateListView(){
     final Future<Database> dbFututre =databaseHelper.database;
     dbFututre.then((database){
       Future<List<Medicine>> medListFuture=databaseHelper.getMediList(user.id);
       medListFuture.then((medicineList){
         setState(() {
           this.medicineList=medicineList;
           //this.count=medicineList.length;
         });
       }); 
      });
  }//updateListView
  }

