import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'product_item_cart.g.dart';

@HiveType(typeId: 1, adapterName: "ProductItemCartAdapter")
class ProductItemCart {
  @HiveField(0)
  String productTitle;
  @HiveField(1)
  String productImage;
  @HiveField(2)
  int productAmount;
  @HiveField(3)
  double productPrice;

  ProductItemCart({
    @required this.productTitle,
    @required this.productImage,
    @required this.productAmount,
    @required this.productPrice,
  });
}
