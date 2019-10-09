import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'layout_interface.dart';
import '../common/utils.dart';
import '../models/rich_text_model.dart';

import 'package:flutter_html/flutter_html.dart';

class RichText extends StatefulWidget {
	final RichTextModel model;

	RichText({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => RichTextState();
}

class RichTextState extends State<RichText> implements LayoutInterface {
	RichTextModel _model;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
	}

	@override
	Widget build(BuildContext context) {
		return Offstage(
			offstage: !this._model.isShow,
			child: Html(
				padding: EdgeInsets.all(Utils.px2dp(20)),
				backgroundColor: Utils.getColorFromString(this._model.backgroundColor),
				defaultTextStyle: TextStyle(fontSize: Utils.px2dp(32)),
				data: this._model.text
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
