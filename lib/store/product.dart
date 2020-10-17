import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'package:wag_proyecto_moviles/models/product_repository.dart';
import 'package:wag_proyecto_moviles/store/product_detail.dart';

class Product extends StatefulWidget {
  Product({
    Key key,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8 / 10,
          children: _buildGridCards(context) // Changed code
          ),
    );
  }
}

List<Widget> _buildGridCards(BuildContext context) {
  List<ProductItem> products = ProductRepository.loadProducts();

  if (products == null || products.isEmpty) {
    return const <Card>[];
  }

  return products.map((product) {
    return GestureDetector(
      onTap: () => _openProductDetails(context, product),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 9,
                child: AspectRatio(
                  aspectRatio: 18 / 11,
                  child: SizedBox(
                    child: Image.network(
                      product.productImage,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        product.productTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${product.productPrice.toStringAsFixed(2)} MXN",
                        style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: 18,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }).toList();
}

_openProductDetails(BuildContext context, ProductItem product) async {
  await Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ProductDetail(product: product)));
}
