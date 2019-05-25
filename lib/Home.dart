import 'package:flutter/material.dart';
import 'package:mobilefinal2/Profile.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});
  
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  String _name;
  String _quote;

  @override
  void initState() {
    if (_name == null) {
      _read();
    }
    super.initState();
  }

  Future<String> _read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
    });
    return _quote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text('Hello $_name', style: TextStyle(fontSize: 20),),
              Text('this is my quote "$_quote"', style: TextStyle(fontSize: 15),),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileForm()));
                  },
                  child: Text('PROFILE SETUP'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('MY FRIENDS'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('SIGN OUT'),
                ),
              )
            ],
          ),
        )
        
      ),
    );
  }
}