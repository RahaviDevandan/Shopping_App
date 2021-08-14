import 'package:car_shopping_app/sreens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_shopping_app/constants.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${streamSnapshot.error}"),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User? _user = streamSnapshot.data as User?;
                  if (_user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2017/07/03/15/06/ferrari-2468015__340.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Text("Welcome to VROOM SHOWROOM",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                    ),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child:
                Text("Initialization App...", style: Constants.regularHeading),
          ),
        );
      },
    );
  }
}
