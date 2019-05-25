import 'package:flutter/material.dart';
import 'package:mobilefinal2/Database/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'Model/User.dart';
import 'Register.dart';

class LoginForm extends StatefulWidget {
	@override
	LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	final _formKey = GlobalKey<FormState>();
  final textValue1 = TextEditingController();
  final textValue2 = TextEditingController();
  bool check;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    textValue1.dispose();
    textValue2.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    final scaffoldState =_scaffoldKey.currentState;
    if (formState.validate()) {
      findUser(textValue1.text, textValue2.text);
    }
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    if (prefs.getString('userId').isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      build(context);
    }
  }

  void findUser(user, pass) {
    var userProvider = UserProvider();
    Future<List<User>> users = userProvider.getUser();
    users.then((value) async {
      for (int i=0;i<value.length;i++) {
        print(value[5].mypassword);
        if(value[i].userId == user && value[i].mypassword == pass) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', textValue1.text);
          print(value[i].name);
          prefs.setString('name', value[i].name);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image.asset('resources/img.jpg',height: 250,),
              ),  
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please fill out this form';
                    }
                  },
                  controller: textValue1,
                  decoration: InputDecoration(
                    labelText: 'User ID',
                    prefixIcon: Icon(Icons.person)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please fill out this form';
                    }
                  },
                  controller: textValue2,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.https)
                  ),
                  obscureText: true,
                  ),
              ),   
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: RaisedButton(
                  onPressed: signIn,
                  child: Text('LOGIN'),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: <Widget>[
                  FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterForm()));
                  },
                  child: Text('Register New Account',style: TextStyle(color: Colors.teal, fontSize: 16),textAlign: TextAlign.right,),
              ),
                ],
              ),
            ]
          )
        ),
      );
    }
  }