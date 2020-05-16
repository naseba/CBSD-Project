import 'package:care_alarm2/Database/user.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget{
    User user;
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color:Colors.blue,
        child: ListView(
          children: <Widget>[                        
            UserAccountsDrawerHeader(
              accountName: Text("User Name"), 
              accountEmail: Text("User Email"),
              ),
              SizedBox(
                height: 7,                           
              ),
              Divider(
                color: Colors.white,
              ),
              
          ],
        ),
      ),
    );
  }


}