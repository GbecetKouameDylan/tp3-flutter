import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Tiroir extends StatefulWidget {
  const Tiroir({super.key});

  @override
  State<Tiroir> createState() => _TiroirState();
}

class _TiroirState extends State<Tiroir> {
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
            leading: Icon(Icons.settings),
            title: Text("signOut"),
            onTap: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
