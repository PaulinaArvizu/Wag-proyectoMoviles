import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'package:wag_proyecto_moviles/store/product_detail.dart';

class Product extends StatefulWidget {
  final ProductItem product;
  Product({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openProductDetails(context, widget.product),
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
                    child: ExtendedImage.network(
                      widget.product.productImage,
                      fit: BoxFit.contain,
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/Loading.gif",
                                  height: 50,
                                ),
                                Text("Loading..."),
                              ],
                            );
                            break;
                          case LoadState.completed:
                            return Image.network(
                              widget.product.productImage,
                              fit: BoxFit.contain,
                            );
                            break;
                          case LoadState.failed:
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/ImageNotFound.png",
                                  height: 75,
                                ),
                                Text("Image not found"),
                              ],
                            );
                            break;
                        }
                        return null;
                      },
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
                        widget.product.productTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: "Poppins Regular",
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${widget.product.productPrice.toStringAsFixed(2)} MXN",
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
  }
}

_openProductDetails(BuildContext context, ProductItem product) async {
  await Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ProductDetail(product: product)));
}
