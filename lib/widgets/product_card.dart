import 'package:car_shopping_app/sreens/product_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard(
      {required this.onPressed,
      required this.imageUrl,
      required this.title,
      required this.price,
      required this.productId});

  //const ProductCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                    productId: productId,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 370.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network("$imageUrl", fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Constants.regularHeading),
                    Text(price,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
