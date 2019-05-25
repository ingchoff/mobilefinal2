import 'package:flutter/material.dart';
import 'package:mobilefinal2/Database/UserProvider.dart';

import 'Model/User.dart';

class ProfileForm extends StatefulWidget {
  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

class ProfileFormState extends State<ProfileForm> {
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final textValue1 = TextEditingController();
  final textValue2 = TextEditingController();
  final textValue3 = TextEditingController();
  final textValue4 = TextEditingController();

   @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    textValue1.dispose();
    textValue2.dispose();
    textValue3.dispose();
    textValue4.dispose();
    super.dispose();
  }

  void signUp() {
    final scaffoldState =_scaffoldKey.currentState;
    final formState = _formkey.currentState;
    if(formState.validate()){
      var userProvider = UserProvider();
      var user = User();
      user.userId = textValue1.text;
      user.name = textValue2.text;
      user.age = int.parse(textValue3.text);
      user.mypassword = textValue4.text;
      userProvider.addUser(user);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: TextFormField(
                validator: (String value) {
                  if (value.length < 6 || value.length > 12 || value.isEmpty) {
                    return 'ต้องมีความยาวอยู่ในช่วง 6-12 ตัว';
                  }
                },
                controller: textValue1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'User Id',
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                // validator: (String value) {
                //   if (value.split(" ").length < 1 || value.isEmpty) {
                //     return 'โปรดใส่ชื่อและนามสกุลและคั่นด้วย 1 space';
                //   }
                // },
                controller: textValue2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty || int.parse(value) < 10 || int.parse(value) > 80) {
                    return 'อายุต้องอยู่ในช่วง 10-80 ปี';
                  }
                },
                controller: textValue3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.calendar_today)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: TextFormField(
                validator: (String value) {
                  if (value.length <= 6 || value.isEmpty) {
                    return 'password ต้องมีความยาวมากกว่า 6';
                  }
                },
                controller: textValue4,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.https)
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: RaisedButton(
                color: Colors.blue,
                child: Text('REGISTER NEW ACCOUNT',style: TextStyle(color: Colors.white),),
                onPressed: signUp
              )
            )
          ]
        ),
      ),
    );
}
}