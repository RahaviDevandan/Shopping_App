import 'package:car_shopping_app/services/firebase_services.dart';
import 'package:car_shopping_app/widgets/custom_action_bar.dart';
import 'package:car_shopping_app/widgets/image_swipe.dart';
import 'package:car_shopping_app/widgets/product_card.dart';
import 'package:car_shopping_app/widgets/product_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductPage extends StatefulWidget {
  //const ProductPage({ Key? key }) : super(key: key);
  final String productId;
  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");
  String _selectedProductColor = "Blue";
  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("cart")
        .doc(widget.productId)
        .set({"color": _selectedProductColor});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"color": _selectedProductColor});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text('Product added to the cart'),
  );
  final SnackBar _snackBar1 = SnackBar(
    content: Text('Product added to the favourites'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                DocumentSnapshot documentData =
                    snapshot.data! as DocumentSnapshot;
                List imageList = documentData['images'];
                List productColor = documentData['color'];
                _selectedProductColor = productColor[0];
                return ListView(padding: EdgeInsets.all(0), children: [
                  ImageSwipe(
                      imageList:
                          imageList), //Image.network("${documentData['images'][0]}")),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 4.0,
                    ),
                    child: Text(
                      "${documentData['name']}",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 24.0,
                    ),
                    child: Text("Rs ${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 24.0,
                    ),
                    child: Text("${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 24.0,
                    ),
                    child:
                        Text("Select Color", style: Constants.regularDarkText),
                  ),
                  ProductColor(
                    productColor: productColor,
                    onSelected: (color) {
                      _selectedProductColor = color;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addToSaved();
                            Scaffold.of(context).showSnackBar(_snackBar1);
                          },
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2016/08/29/13/55/heart-1628313_960_720.png",
                              ),
                              height: 25.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              Scaffold.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 65.0,
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple[400],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]);
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            Title: "",
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
