import 'package:flutter/material.dart';

enum method { PAYPAL, GIFTCARD, CARD }

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text('Elige tu metodo de pago'),
          ),
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
                child: Text('Tarjeta credito/debito',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  _gotoPayment();
                },
                child: const Text('GiftCard', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  _gotoPayment();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Paypal', style: TextStyle(fontSize: 20)),
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
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Orden Exitosa!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Tu orden ha sido registrada, para mas informacion busca en la opcion historial de compras en tu perfil'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
