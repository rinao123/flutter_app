import "package:flutter/material.dart";
import 'package:flutter/src/rendering/sliver_multi_box_adaptor.dart';
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import 'package:flutter_app/components/notifications/list_layout_notification.dart';

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _CartState();
	}
}

class _CartState extends State<Cart> {

	@override
	void initState() {
		print("cart");
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				elevation: 0,
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				title: Text(
					"购物袋",
					style: TextStyle(color: Colors.black)
				),
			),
			body: Column(
				children: <Widget>[
					Text("MyInfo")
				]
			)
		);
	}
}
