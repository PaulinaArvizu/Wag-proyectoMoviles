import 'package:flutter/foundation.dart';

class ProductItem {
  final String productTitle; // nombre del producto
  final String productDescription; // descripcion del producto
  final String productImage; // url de imagen del producto
  double productPrice; // precio del producto autocalculado
  int productAmount; // cantidad de producto por comprar

  ProductItem({
    @required this.productTitle,
    @required this.productDescription,
    @required this.productImage,
    @required this.productAmount,
    @required this.productPrice,
  });
}
