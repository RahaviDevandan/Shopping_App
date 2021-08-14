import 'package:car_shopping_app/sreens/home_page.dart';
import 'package:car_shopping_app/sreens/login_page.dart';
import 'package:car_shopping_app/widgets/custom_btn.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  //const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final Function(String) onChanged;
  late final Function(String) onSubmitted;
  late final FocusNode focusNode;
  late final bool isPasswordField = true;

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String? _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuider(_createAccountFeedback);
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  bool _registerFormLoading = false;
  String _registerEmail = "";
  String _registerPassword = "";
  late FocusNode _passwordFocusNode;
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[100],
          title: Center(
              child: Text("Sign Up", style: TextStyle(color: Colors.white))),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1606247919215-3ce82d2e45d8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80'),
                  fit: BoxFit.cover),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 54.0,
                  ),
                  child: Text(
                    "Create A New Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 14.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: TextField(
                        onChanged: (value) {
                          _registerEmail = value;
                        },
                        onSubmitted: (value) {
                          _passwordFocusNode.requestFocus();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.email, color: Colors.blueGrey[100]),
                            hintText: "Enter your Email",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            )),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 14.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: TextField(
                        obscureText: isPasswordField,
                        onChanged: (value) {
                          _registerPassword = value;
                        },
                        onSubmitted: (value) {
                          _submitForm();
                        },
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                Icon(Icons.lock, color: Colors.blueGrey[100]),
                            hintText: "Enter your Password",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            )),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 1350.0,
                        height: 65.0,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            _submitForm();
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: Colors.blueGrey[100],
                          child: Text(
                            'Create New Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 1350.0,
                    height: 65.0,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.blueGrey[100],
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Future<void> _alertDialogBuider(String error) async {
  var context;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            FlatButton(
              child: Text(
                "Close Dialog",
              ),
              onPressed: () {
                print("error");
              },
            )
          ],
        );
      });
}
