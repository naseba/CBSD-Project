/*import 'package:care_alarm/utilities/theme.dart';

import 'Screens/login.dart';
import 'Screens/medicine_details.dart';

import 'Screens/profile.dart';
import 'Screens/register.dart';
import 'Screens/report.dart';
*/

import 'package:care_alarm2/Database/medicine.dart';
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
    
   // bool get isloged => user.active!=0;
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
     // theme: myThemeData,
      //home: HomeScreen(),
     //initialRoute:'/HomeScreen' ,
     initialRoute: '/Register',
    routes:{
      '/Accounts':(context)=>Accounts(),//EditProfile
       '/EditProfile':(context)=>EditProfile(user), 
      '/Register':(context)=>Register(),
      '/HomeScreen':(context)=>HomeScreen(medicine),
      '/AddMedicine':(context)=>AddMedicine(medicine),
      '/Units':(context)=>Units(medicine),
      '/Scedule':(context)=>Scedule(medicine),
      '/MoreDetails':(context)=>MoreDetails(medicine),  
      '/MedicineDetails':(context)=>MedicineDetails(medicine),
    },
    );
  }

  

}

 