import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfo extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				elevation: 0,
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				title: Text(
					"我的",
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
