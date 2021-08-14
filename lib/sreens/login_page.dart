import 'package:car_shopping_app/sreens/home_page.dart';
import 'package:car_shopping_app/sreens/register_page.dart';
import 'package:car_shopping_app/widgets/custom_btn.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordField = true;
  bool _rememberMe = false;
  Widget _buildSignUpBtn() {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.brown[400],
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(),
          _buildSocialBtnGoogle(),
        ],
      ),
    );
  }

  Widget _buildSocialBtn() {
    return GestureDetector(
      onTap: () => print('Login with Facebook'),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[400],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1549813069-f95e44d7f498?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=910&q=80'),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnGoogle() {
    return GestureDetector(
      onTap: () => print('Login with Google'),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1573804633927-bfcbcd909acd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=799&q=80'),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 1.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
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

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);

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
      _loginFormLoading = true;
    });
    String? _loginFeedback = await _loginAccount();
    if (_loginFeedback != null) {
      _alertDialogBuider(_loginFeedback);
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  @override
  bool _loginFormLoading = false;
  String _loginEmail = "";
  String _loginPassword = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Center(
              child: Text("Sign In", style: TextStyle(color: Colors.white))),
        ),
        body: SafeArea(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1597858520171-563a8e8b9925?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80'),
                    fit: BoxFit.cover),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Welcome Back ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      Text(
                          "Sign in with your email and password\n or continue with social media",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
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
                              _loginEmail = value;
                            },
                            onSubmitted: (value) {
                              _passwordFocusNode.requestFocus();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.brown[50]),
                                hintText: "Enter your Email",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                  vertical: 10.0,
                                )),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
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
                              _loginPassword = value;
                            },
                            onSubmitted: (value) {
                              _submitForm();
                            },
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.brown[50]),
                                hintText: "Enter your Password",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.0,
                                  vertical: 10.0,
                                )),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                      ),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: 1350.0,
                          height: 45.0,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              _submitForm();
                            },
                            padding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: Colors.brown[400],
                            child: Text(
                              'Continue',
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
                  _buildSignInWithText(),
                  _buildSocialBtnRow(),
                  _buildSignUpBtn(),
                  Container(
                    width: 1350.0,
                    height: 42.0,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.brown[400],
                      child: Text(
                        'Create a New Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
