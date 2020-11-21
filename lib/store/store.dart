import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';
import 'package:wag_proyecto_moviles/models/product_repository.dart';
import 'package:wag_proyecto_moviles/store/product.dart';

import 'cart/cart.dart';

class Store extends StatefulWidget {
  Store({
    Key key,
  }) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<ProductItemCart> productList = new List<ProductItemCart>();
  List<ProductItem> _products = ProductRepository.loadProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
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
              onPressed: () {
                _openCartPage();
              }),
        ],
      ),
      // body: Product(),
      backgroundColor: background,
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8 / 10,
        children:
            _products.map((product) => Product(product: product)).toList(),
      ),
    );
  }

  void _openCartPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Cart(
          productsList: ProductRepository.loadProducts().map((product) {
            return new ProductItemCart(
              productTitle: product.productTitle,
              productImage: product.productImage,
              productAmount: 0,
              productPrice: product.productPrice,
            );
          }).toList(),
        );
      }),
    );
  }
}
