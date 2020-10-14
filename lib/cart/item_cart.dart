import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  final dynamic product;
  final ValueChanged<double> onAmountUpdated;
  ItemCart({
    Key key,
    @required this.onAmountUpdated,
    @required this.product,
  }) : super(key: key);

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Text("${widget.product.productTitle}"),
          SizedBox(
            height: 12,
          ),
          IconButton(icon: Icon(Icons.add_circle_outline), onPressed: _addProd),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.network(widget.product.productImage)),
          ),
          SizedBox(
            height: 12,
          ),
          IconButton(icon: Icon(Icons.remove_circle), onPressed: _remProd),
          SizedBox(
            height: 12,
          ),
          Text("${widget.product.productAmount}"),
          SizedBox(
            height: 12,
          ),
          Text("${widget.product.productPrice}"),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  void _addProd() {
    setState(() {
      ++widget.product.productAmount;
    });
    widget.onAmountUpdated(widget.product.productPrice);
  }

  void _remProd() {
    setState(() {
      --widget.product.productAmount;
      if (widget.product.productAmount <= 0) widget.product.productAmount = 0;
    });
    widget.onAmountUpdated(-1 * widget.product.productPrice);
  }
}
