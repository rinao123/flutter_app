import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/layout/img1_model.dart";

class Img1 extends StatelessWidget with LayoutBehaviors {
	final Img1Model _img1Model;

	Img1(this._img1Model);

	@override
	Widget build(BuildContext context) {
		double margin = Utils.px2dp(this._img1Model.shadow ? 20 : 0);
		List<BoxShadow> boxShadow = [];
		if (this._img1Model.shadow) {
			boxShadow = [
				BoxShadow(offset: Offset(0, Utils.px2dp(8)), blurRadius: Utils.px2dp(16), spreadRadius: 0, color: Utils.getColorFromString("rgba(0,0,0,0.16)"))
			];
		}

		return Container(
			color: Utils.getColorFromString("#ffffff"),
			margin: EdgeInsets.symmetric(vertical: margin),
			child: InkWell (
				child: Container(
					decoration: BoxDecoration(
						boxShadow: boxShadow
					),
					child: ClipRRect(
						borderRadius: BorderRadius.circular(Utils.px2dp(this._img1Model.borderRadius)),
						child: Image.network(
							this._img1Model.img,
							width: Utils.px2dp(this._img1Model.width),
							height: Utils.px2dp(this._img1Model.height),
							fit: BoxFit.fill
						)
					)
				),
				onTap: () {
					this.onTap(context, link: this._img1Model.link);
				}
			)
		);
	}
}
