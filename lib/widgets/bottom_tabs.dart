import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({required this.selectedTab, required this.tabPressed});
  //const BottomTabs({Key? key}) : super(key: key);
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1558481795-7f0a7c906f5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=773&q=80'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        BottomTabBtn(
          imagePath:
              'https://cdn.pixabay.com/photo/2013/07/12/12/56/home-146585_960_720.png',
          selected: _selectedTab == 0 ? true : false,
          onChanged: () {
            widget.tabPressed(0);
          },
        ),
        BottomTabBtn(
          imagePath:
              'https://cdn.pixabay.com/photo/2015/12/14/20/35/magnifier-1093183_960_720.png',
          selected: _selectedTab == 1 ? true : false,
          onChanged: () {
            widget.tabPressed(1);
          },
        ),
        BottomTabBtn(
          imagePath:
              'https://cdn.pixabay.com/photo/2016/08/29/13/55/heart-1628313_960_720.png',
          selected: _selectedTab == 2 ? true : false,
          onChanged: () {
            widget.tabPressed(2);
          },
        ),
        BottomTabBtn(
          imagePath:
              'https://cdn.pixabay.com/photo/2013/03/29/13/40/exit-97636_960_720.png',
          selected: _selectedTab == 3 ? true : false,
          onChanged: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ]),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  //const BottomTabBtn({ Key? key }) : super(key: key);
  late final String imagePath;
  final bool selected;
  final Function onChanged;
  BottomTabBtn(
      {required this.imagePath,
      required this.selected,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected;

    return GestureDetector(
      onTap: () {
        onChanged();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: _selected ? Colors.white : Colors.transparent,
          width: 2.0,
        ))),
        height: 60,
        width: 70,
        child: Image(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
            color: _selected ? Colors.white : Colors.black),
      ),
    );
  }
}
