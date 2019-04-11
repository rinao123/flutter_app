import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout.dart";

class Special extends StatefulWidget {
	String _code;

	Special(String code) {
		this._code = code;
	}

	@override
	State<StatefulWidget> createState() {
		return new _SpecialState(this._code);
	}
}

class _SpecialState extends State<Special> {
	String _code;

	_SpecialState(String code) {
		this._code = code;
	}

	@override
	Widget build(BuildContext context) {
		return new Layout(this._code);
	}
}
