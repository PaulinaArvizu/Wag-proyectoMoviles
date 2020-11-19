import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item.dart';

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
  bool expandedText = false;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
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
            SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 30),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: expandedText
                          ? Text(
                              widget.product.productDescription,
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(
                              widget.product.productDescription,
                              style: TextStyle(fontSize: 18),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: expandedText
                        ? Icon(Icons.arrow_circle_up)
                        : Icon(Icons.arrow_circle_down),
                    onPressed: () {
                      setState(() {
                        expandedText = !expandedText;
                      });
                    },
                  ),
                ),
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
                  onPressed: () {},
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
      ),
    );
  }
}
