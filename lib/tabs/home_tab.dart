import 'package:car_shopping_app/sreens/product_page.dart';
import 'package:car_shopping_app/widgets/custom_action_bar.dart';
import 'package:car_shopping_app/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class HomeTab extends StatelessWidget {
  //const HomeTab({Key? key}) : super(key: key);
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
       
        child: Stack(children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.count(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  crossAxisCount: 2,
                  //mainAxisSpacing: 5.0,
                  //crossAxisSpacing: 5.0,
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
          CustomActionBar(
            Title: "Vehicle Suite",
            hasTitle: true,
            hasBackArrow: false,
            hasBackground: true,
          )
        ]));
  }
}
//flutter run -d chrome --web-renderer html
