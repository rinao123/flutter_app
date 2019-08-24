import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _CartState();
	}
}

class _CartState extends State<Cart> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				title: Text(
					"购物袋",
					style: TextStyle(color: Colors.black)
				),
			),
			body: Column(
				children: <Widget>[
					Text("Cart")
				]
			)
		);
	}
}
