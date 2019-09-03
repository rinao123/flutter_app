import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout_page.dart";

class Index extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _IndexState();
	}
}

class _IndexState extends State<Index> {

	@override
	Widget build(BuildContext context) {
		return LayoutPage("index");
	}
}
