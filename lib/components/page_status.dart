import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class PageStatus extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {
		return new _PageStatusState();
	}
}

class _PageStatusState extends State<PageStatus> {

	@override
	Widget build(BuildContext context) {
		return Center(
			child: Text("正在加载中")
		);
	}
}
