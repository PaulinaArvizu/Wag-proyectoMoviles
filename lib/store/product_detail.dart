import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';

import 'bloc/store_bloc.dart';

class ProductDetail extends StatefulWidget {
  final ProductItem product;
  ProductDetail({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  StoreBloc _storeBloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background,
      body: BlocProvider(
        create: (context) {
          _storeBloc = StoreBloc();
          return _storeBloc;
        },
        child: BlocConsumer<StoreBloc, StoreState>(
          listener: (context, state) {
            if (state is ProductAddedState || state is CartUpdatedState) {
              _scaffoldKey.currentState
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Added to cart"),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is StoreInitial) {}
            return Center(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    child: Image.network(widget.product.productImage),
                    constraints: BoxConstraints(
                      maxHeight: 300,
                      maxWidth: 200,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xffE2E2E2),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      widget.product.productTitle,
                      style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "\$${widget.product.productPrice.toStringAsFixed(2)} MXN",
                      style: TextStyle(
                        fontFamily: 'Poppins Bold',
                        fontSize: 28,
                        color: primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ExpansionTile(
                    title: Text('Description'),
                    children: [
                      Text(
                        widget.product.productDescription,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: primary)),
                        onPressed: () {
                          _storeBloc.add(
                            AddToCartEvent(
                              product: ProductItemCart(
                                productAmount: 1,
                                productImage: widget.product.productImage,
                                productPrice: widget.product.productPrice,
                                productTitle: widget.product.productTitle,
                              ),
                            ),
                          );
                        },
                        color: primary,
                        textColor: Colors.white,
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                            fontFamily: 'Poppins Regular',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
