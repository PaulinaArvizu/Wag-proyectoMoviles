import 'package:flutter/material.dart';
import 'package:wag_proyecto_moviles/colors.dart';
import 'package:wag_proyecto_moviles/home/home_page.dart';
import 'package:wag_proyecto_moviles/store/bloc/store_bloc.dart';

enum method { PAYPAL, GIFTCARD, CARD }

class Payment extends StatefulWidget {
  final StoreBloc storeBloc;
  Payment({Key key, @required this.storeBloc}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Choose payment method'),
        backgroundColor: primary,
      ),
      body:
          // SizedBox(height: 60),
          Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              minWidth: double.infinity,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: secondary),
              ),
              onPressed: _gotoPayment,
              color: secondary_background,
              textColor: secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/credit-card.png",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Credit/Debit card",
                    style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            FlatButton(
              minWidth: double.infinity,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: secondary),
              ),
              onPressed: _gotoPayment,
              color: secondary_background,
              textColor: secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/gift-card.png",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Giftcard",
                    style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            FlatButton(
              minWidth: double.infinity,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: secondary),
              ),
              onPressed: _gotoPayment,
              color: secondary_background,
              textColor: secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/paypal.png",
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Paypal",
                    style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _gotoPayment() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Success!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Your payment was successful and your order should be on its way. Thank you for your purchase.'),
                Image.asset(
                  'assets/images/PaymentSuccess.png',
                  height: 50,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Confirm and Go to Home page'),
                onPressed: () {
                  widget.storeBloc.add(PaymentSuccessEvent());
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        });
  }
}
