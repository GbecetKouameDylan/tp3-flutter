import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'creation.dart';
import 'home.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '${FirebaseAuth.instance.currentUser?.email} ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text("signOut"),
            onTap: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add a task"),
            onTap: () async {
Navigator.push(
    context,MaterialPageRoute(builder: (context) => Creation()),
);
            },
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () async {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ],
      ),
    );
  }
}
