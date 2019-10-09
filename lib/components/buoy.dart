import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'layout_behaviors_mixin.dart';
import 'layout_interface.dart';
import '../common/utils.dart';
import '../models/buoy_model.dart';

class Buoy extends StatefulWidget {
	final BuoyModel model;

	Buoy({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => BuoyState();
}

class BuoyState extends State<Buoy> with LayoutBehaviorsMixin implements LayoutInterface {
	BuoyModel _model;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
	}

	@override
	Widget build(BuildContext context) {
		return Positioned(
			bottom: Utils.px2dp(50),
			right: Utils.px2dp(30),
			child: Offstage(
				offstage: !this._model.isShow,
				child: GestureDetector(
					child: Image.network(
						this._model.img,
						width: Utils.px2dp(this._model.width),
						height: Utils.px2dp(this._model.height),
					),
					onTap: () {
						this.onTap(context, link: this._model.link);
					}
				)
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
