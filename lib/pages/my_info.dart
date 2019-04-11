import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class MyInfo extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return new _MyInfoState();
	}
}

class _MyInfoState extends State<MyInfo> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("MyInfo"),
			),
			body: Column(
				children: <Widget>[
					Text("MyInfo")
				]
			)
		);
	}
}
