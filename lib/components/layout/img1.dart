import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/layout/img1_model.dart";

class Img1 extends StatefulWidget {
	final Img1Model _img1Model;

	Img1(this._img1Model);

	@override
	State<StatefulWidget> createState() {
		return new _Img1State(this._img1Model);
	}
}

class _Img1State extends State<Img1> with LayoutBehaviors {
	Img1Model _img1Model;

	_Img1State(this._img1Model);

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.center,
			children: <Widget>[
				new GestureDetector(
					child: Image(
						image: new NetworkImage(this._img1Model.img),
						width: Utils.px2dp(this._img1Model.width),
						height: Utils.px2dp(this._img1Model.height),
					),
					onTap: () {
						this.onTap(context, this._img1Model);
					}
				)
			],
		);
	}
}
