import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Recommend extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _RecommendState();
	}
}

class _RecommendState extends State<Recommend> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				title: Text(
					"优米推荐",
					style: TextStyle(color: Colors.black)
				),
			),
			body: Column(
				children: <Widget>[
					Text("Recommend")
				]
			)
		);
	}
}
