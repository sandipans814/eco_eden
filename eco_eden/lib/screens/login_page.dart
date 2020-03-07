import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<StatefulWidget> {

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isLoading = false; // flag to denote if loading
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(_isLoading);
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoEden'),
      ),
      body: Stack(
          children: <Widget>[
            showForm(),
            showCircularProgress(),
          ],
        ),
      );
  }

  // Loading indicator
  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }


  Widget showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 80.0,
          child: Image.asset('assets/EcoEden-Logo.png'),
        ),
      ),
    );
  }


  Widget showEmailInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email cant\'t be empty.' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        width: 30.0,
        height: 50.0,
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.blue,
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () => print('i am log in button'),
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return FlatButton(
      child: Text(
        'Create a new account',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      ),
      onPressed: () => print('i am create a new account button'),
    );
  }

  // User login form
  Widget showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showEmailInput(),
            showPasswordInput(),
            showPrimaryButton(),
            showSecondaryButton(),
          ],
        ),
      ),
    );
  }

}