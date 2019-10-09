import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'layout_interface.dart';
import '../common/utils.dart';
import '../models/placeholder_model.dart';

class Placeholder extends StatefulWidget {
	final PlaceholderModel model;

	Placeholder({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => PlaceholderState();
}

class PlaceholderState extends State<Placeholder> implements LayoutInterface {
	PlaceholderModel _model;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
	}

	@override
	Widget build(BuildContext context) {
		return Offstage(
			offstage: !this._model.isShow,
			child: Container(
				color: Utils.getColorFromString(this._model.backgroundColor),
				height: Utils.px2dp(this._model.height)
			)
		);
	}

	@override
	bool get isShow => this._model.isShow;

	@override
	void show() {
		if (this.isShow) {
			return;
		}
		this.setState(() => this._model.isShow = true);
	}

	@override
	void hide() {
		if (!this.isShow) {
			return;
		}
		this.setState(() => this._model.isShow = false);
	}
}
