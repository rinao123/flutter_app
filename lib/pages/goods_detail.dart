import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class GoodsDetail extends StatefulWidget {
	final int _id;

	GoodsDetail(this._id);

	@override
	State<StatefulWidget> createState() {
		return _GoodsDetailState(this._id);
	}
}

class _GoodsDetailState extends State<GoodsDetail> {

	int _id;

	_GoodsDetailState(this._id);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				iconTheme: IconThemeData(color: Colors.black),
				title: Text(
					"商品详情",
					style: TextStyle(color: Colors.black)
				),
			),
			body: Column(
				children: <Widget>[
					Text("GoodsDetail")
				]
			)
		);
	}
}
