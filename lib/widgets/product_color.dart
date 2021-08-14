import 'package:flutter/material.dart';

class ProductColor extends StatefulWidget {
  //const ProductColor({ Key? key }) : super(key: key);
  final List productColor;
  final Function(String) onSelected;
  ProductColor({required this.productColor, required this.onSelected});

  @override
  _ProductColorState createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductColor> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productColor.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected("${widget.productColor[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 65.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: _selected == i
                        ? Theme.of(context).accentColor
                        : Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.productColor[i]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontSize: 16.0),
                ),
              ),
            )
        ],
      ),
    );
  }
}
