import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return new _CartState();
	}
}

class _CartState extends State<Cart> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Cart"),
			),
			body: Column(
				children: <Widget>[
					Text("Cart")
				]
			)
		);
	}
}
