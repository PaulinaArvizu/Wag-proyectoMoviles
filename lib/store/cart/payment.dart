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
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _gotoPayment();
                },
                color: primary,
                child: Text('Credit/Debit card',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  _gotoPayment();
                },
                color: primary,
                child: const Text('GiftCard',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  _gotoPayment();
                },
                color: primary,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Paypal',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
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
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
                },
              ),
            ],
          );
        });
  }
}
