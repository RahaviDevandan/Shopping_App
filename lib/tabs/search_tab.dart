import 'package:car_shopping_app/services/firebase_services.dart';
import 'package:car_shopping_app/sreens/product_page.dart';
import 'package:car_shopping_app/sreens/register_page.dart';
import 'package:car_shopping_app/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
                child: Text(
              "Search Results",
              style: Constants.regularDarkText,
            )),
          )
        else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy("search_string")
                .startAt([_searchString]).endAt(["$_searchString\uf8ff"]).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 128.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return ProductCard(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(productId: document.id)),
                          );
                        },
                        imageUrl: (document.data()! as Map)['images'][0],
                        title: (document.data()! as Map)['name'],
                        price: "\$${(document.data()! as Map)['price']}",
                        productId: document.id);
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 14.0,
            ),
            decoration: BoxDecoration(
                color: Colors.purple[200],
                borderRadius: BorderRadius.circular(12.0)),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search here...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  )),
              style: Constants.regularDarkText,
            ),
          ),
        ),
        // Text(
        //   "Search Results",
        //   style: Constants.regularDarkText,
        // ),
      ],
    ));
  }
}
