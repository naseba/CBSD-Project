/*import 'package:care_alarm/utilities/theme.dart';

import 'Screens/login.dart';
import 'Screens/medicine_details.dart';

import 'Screens/profile.dart';
import 'Screens/register.dart';
import 'Screens/report.dart';
*/

import 'package:care_alarm2/Database/medicine.dart';
import 'package:care_alarm2/Database/userDatabase.dart';
import 'package:flutter/material.dart';
import 'Database/user.dart';
import 'Screens/accounts.dart';
import 'Screens/add_medicine.dart';
import 'Screens/editProfile.dart';
import 'Screens/register.dart';
import 'Screens/scedule.dart';
import 'Screens/units.dart';
import 'Screens/more_details.dart';
import './Screens/home_screen.dart';
import 'Screens/medicine_details.dart';

void main() {
  runApp(MyApp());
  }
  
  class MyApp  extends StatelessWidget{
    Medicine medicine;
    User user;
    UserDatabase userDB=UserDatabase();
    int count;
    bool get isEmbty =>count==0;
    
   // bool get isloged => user.active!=0;
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute:isEmbty?'/Register': '/Accounts',
    routes:{
      '/Accounts':(context)=>Accounts(),//EditProfile
       '/EditProfile':(context)=>EditProfile(user), 
      '/Register':(context)=>Register(user),
      '/HomeScreen':(context)=>HomeScreen(medicine,user),//medicine
      '/AddMedicine':(context)=>AddMedicine(medicine,user),
      '/Units':(context)=>Units(medicine),
      '/Scedule':(context)=>Scedule(medicine,user),
      '/MoreDetails':(context)=>MoreDetails(medicine,user),  
      '/MedicineDetails':(context)=>MedicineDetails(medicine),
    },
    );
  }
   void getUsersCount()async{
     count= await userDB.getUSerCount();
   }
  

}

 