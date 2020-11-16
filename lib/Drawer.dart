import 'package:flutter/material.dart';
import 'package:showyourtrade/Size_Config/Config.dart';
import 'package:showyourtrade/account/login.dart';
import 'package:showyourtrade/account/sign_up.dart';
class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
             padding: const EdgeInsets.only(top: 40, left: 10, right: 20),
              color: Colors.blueAccent,
              width: double.infinity,
              height:Config.yMargin(context,30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
               radius: 45.0,
                  ),
                  Text('Username', style: TextStyle(
                    fontSize: 25
                  ),)
                ],
              ),
            ),
            ListTile(leading: Icon(Icons.photo), title: Text('People and Business'),),
            ListTile(leading: Icon(Icons.store), title: Text('Products'),),
            ListTile(leading: Icon(Icons.photo), title: Text('Payhose Products'),),
            ListTile(leading: Icon(Icons.notifications), title: Text('Notifications'),),
            ListTile(leading: Icon(Icons.message), title: Text('Messages'),),
            InkWell(child: ListTile(leading: Icon(Icons.photo), title: Text('Login'),

            onTap: (){
              Navigator.of(context).pushNamed('/login');
            },)),
            InkWell(child: ListTile(leading: Icon(Icons.logout), title: Text('Create Account'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return CreateAccount();
                }));
              },
            ),

            ),

          ],
        ),
      ),

    );
  }
}
