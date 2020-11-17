import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wag_proyecto_moviles/cart/cart.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/home/home_page.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';
import 'package:wag_proyecto_moviles/models/product_repository.dart';
import 'package:wag_proyecto_moviles/profile/profile.dart';
import 'package:wag_proyecto_moviles/store/product.dart';

class Store extends StatefulWidget {
  Store({
    Key key,
  }) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int _selectedIndex = 2;
  List<ProductItemCart> productList = new List<ProductItemCart>();
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
      body: Product(),
    );
  }

  void _openHomePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return HomePage();
      }),
    );
  }

  void _openCartPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Cart(
          productsList: ProductRepository.loadProducts().map(
            (product) {
              return new ProductItemCart(
                productTitle: product.productTitle,
                productImage: product.productImage,
                productAmount: 0,
                productPrice: product.productPrice,
              );
            },
          ).toList(),
        );
      }),
    );
  }

  void _openStorePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Store();
      }),
    );
  }

  void _openProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Profile();
      }),
    );
  }
}
