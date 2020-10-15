import 'package:flutter/material.dart';

Widget storeAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text(
      "Wag Store",
      style: TextStyle(
        fontFamily: 'Sofia Pro Bold',
        fontSize: 24,
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ],
  );
}
