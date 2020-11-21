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
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(products: _products),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                _openCartPage();
              }),
        ],
      ),
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

class Search extends SearchDelegate {
  final List<ProductItem> products;

  Search({@required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    //boton que limpie la busqueda
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon (a la izquierda del search)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductItem> filteredProducts = [];
    //busca los resultados
    query.isEmpty
        ? filteredProducts = []
        : filteredProducts = products.where((p) {
            String title = p.productTitle.toLowerCase();
            String desc = p.productDescription.toLowerCase();
            String price = p.productDescription.toString().toLowerCase();
            String search = query.toLowerCase();
            return title.contains(search) ||
                desc.contains(search) ||
                price.contains(search);
          }).toList();

    //muestra los resultados
    return filteredProducts.length == 0
        ? Center(child: Text('No results'))
        : GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8 / 10,
            children: filteredProducts
                .map((product) => Product(product: product))
                .toList(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text(''));
  }
}
