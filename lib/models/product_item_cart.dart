import 'package:flutter/foundation.dart';

class ProductItemCart {
  String productTitle;
  String productImage;
  int productAmount;
  double productPrice;

  ProductItemCart({
    @required this.productTitle,
    @required this.productImage,
    @required this.productAmount,
    @required this.productPrice,
  });
}
