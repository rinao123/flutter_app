import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Member extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => _MemberState();
}

class _MemberState extends State<Member> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				appBar: AppBar(
					elevation: 0,
					backgroundColor: Colors.white,
					brightness: Brightness.light,
					title: Text(
							"会员",
							style: TextStyle(color: Colors.black)
					),
				),
				body: Column(
					children: <Widget>[
						Text("Member")
					]
				)
		);
	}
}
