import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'layout_behaviors_mixin.dart';
import 'layout_interface.dart';
import '../common/utils.dart';
import '../models/img1_model.dart';

class Img1 extends StatefulWidget {
	final Img1Model model;

	Img1({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => Img1State();
}

class Img1State extends State<Img1> with LayoutBehaviorsMixin implements LayoutInterface {
	Img1Model _model;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
	}

	@override
	Widget build(BuildContext context) {
		double margin = Utils.px2dp(this._model.shadow ? 20 : 0);
		List<BoxShadow> boxShadow = [];
		if (this._model.shadow) {
			boxShadow = [
				BoxShadow(offset: Offset(0, Utils.px2dp(8)), blurRadius: Utils.px2dp(16), spreadRadius: 0, color: Utils.getColorFromString("rgba(0,0,0,0.16)"))
			];
		}
		return Offstage(
			offstage: !this._model.isShow,
			child: Container(
				color: Utils.getColorFromString("#ffffff"),
				margin: EdgeInsets.symmetric(vertical: margin),
				child: GestureDetector(
					child: Container(
						decoration: BoxDecoration(
							boxShadow: boxShadow
						),
						child: ClipRRect(
							borderRadius: BorderRadius.circular(Utils.px2dp(this._model.borderRadius)),
							child: Image.network(
								this._model.img,
								width: Utils.px2dp(this._model.width),
								height: Utils.px2dp(this._model.height),
								fit: BoxFit.fill
							)
						)
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
