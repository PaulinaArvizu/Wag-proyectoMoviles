import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/cart/item_cart.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/models/product_item_cart.dart';
// import 'package:wag_proyecto_moviles/payment.dart';

class Cart extends StatefulWidget {
  final List<ProductItemCart> productsList;
  Cart({
    Key key,
    @required this.productsList,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _total = 0;
  @override
  void initState() {
    super.initState();
    for (var item in widget.productsList) {
      _total += (item.productPrice * item.productAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.productsList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCart(
                  onAmountUpdated: _priceUpdate,
                  item: widget.productsList[index],
                );
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: subtotal_background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Subtotal: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Proxima Nova Regular',
                            ),
                          ),
                          Text(
                            "\$${_total.toStringAsFixed(2)} MXN",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Proxima Nova Regular'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            // padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {},
                            color: pagar_background,
                            textColor: Colors.white,
                            child: Text("PAGAR",
                                style: TextStyle(
                                  fontFamily: 'Poppins SemiBold',
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Carrito de Compras'),
    //   ),
    //   body: Stack(
    //     children: <Widget>[
    //       Container(
    //         height: MediaQuery.of(context).size.height * 0.9,
    //         child: ListView.builder(
    //           itemCount: widget.productsList.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return ItemCart(
    //               onAmountUpdated: _priceUpdate,
    //               cartItemsList:
    //                   widget.productsList, //widget.productsList[index],
    //             );
    //           },
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 50,
    //         child: Text("Total: \$$_total"),
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         child: RaisedButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             Navigator.of(context)
    //                 .push(MaterialPageRoute(builder: (context) {
    //               return Payment();
    //             }));
    //           },
    //           textColor: Colors.white,
    //           padding: const EdgeInsets.all(0.0),
    //           child: Container(
    //             padding: const EdgeInsets.all(10.0),
    //             child: const Text('Pagar', style: TextStyle(fontSize: 20)),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  void _priceUpdate(double newItemPrice) {
    setState(() {
      _total += newItemPrice;
      if (_total < 0) _total = 0;
    });
  }
}
