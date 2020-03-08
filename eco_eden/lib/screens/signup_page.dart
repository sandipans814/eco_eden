import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _RegisterPageState();

}

class _RegisterPageState extends State<StatefulWidget> {

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _firstName;
  String _lastName;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),

      body: Stack(
        children: <Widget>[
          showForm(),
        ],
      ),
    );
  }

  Widget showNameInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    icon: Icon(
                      Icons.face,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) => value.isEmpty ? 'First Name cant\'t be empty.' : null,
                  onSaved: (value) => _firstName = value.trim(),
                ),
              ),

              Flexible(
                child: TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (value) => value.isEmpty ? 'Last Name cant\'t be empty.' : null,
                  onSaved: (value) => _lastName = value.trim(),
                ),
              ),
            ],
          ),
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
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
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

  Widget showConfirmPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _confirmPassword = value.trim(),
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
            'Register',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () => print('i am Register button'),
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return FlatButton(
      child: Text(
        'Have an account? Sign in.',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget showForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showNameInput(),
            showEmailInput(),
            showPasswordInput(),
            showConfirmPasswordInput(),
            showPrimaryButton(),
            showSecondaryButton(),
          ],
        ),
      ),
    );
  }
}
