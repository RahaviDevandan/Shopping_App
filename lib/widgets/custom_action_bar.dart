import 'dart:convert';

import 'package:car_shopping_app/constants.dart';
import 'package:car_shopping_app/services/firebase_services.dart';
import 'package:car_shopping_app/sreens/cart_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomActionBar extends StatelessWidget {
  late final String Title;
  late final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar(
      {required this.Title,
      required this.hasBackArrow,
      required this.hasTitle,
      required this.hasBackground});

  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");
  //const CustomActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow;
    bool _hasTite = hasTitle;
    bool _hasBackground = hasBackground;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.purple.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 46.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 45.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/vectors/undo-glyph-icon-web-and-mobile-back-sign-vector-graphics-a-solid-on-vector-id871054742"),
                      fit: BoxFit.cover,
                      width: 38,
                      height: 43)),
            ),
          if (_hasTite)
            Text(
              Title,
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _usersRef
                      .doc(_firebaseServices.getUserId())
                      .collection("cart")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    int _totalItems = snapshot.data!.size;

                    return Text(
                      "$_totalItems",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
