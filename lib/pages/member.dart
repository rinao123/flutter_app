import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Member extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return new _MemberState();
	}
}

class _MemberState extends State<Member> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Member"),
			),
			body: Column(
				children: <Widget>[
					Text("Member")
				]
			)
		);
	}
}
