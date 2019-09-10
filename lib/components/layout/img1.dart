import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/layout/img1_model.dart";

class Img1 extends StatelessWidget with LayoutBehaviors {
	final Img1Model model;

	Img1({@required this.model});

	@override
	Widget build(BuildContext context) {
		double margin = Utils.px2dp(this.model.shadow ? 20 : 0);
		List<BoxShadow> boxShadow = [];
		if (this.model.shadow) {
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
						borderRadius: BorderRadius.circular(Utils.px2dp(this.model.borderRadius)),
						child: Image.network(
							this.model.img,
							width: Utils.px2dp(this.model.width),
							height: Utils.px2dp(this.model.height),
							fit: BoxFit.fill
						)
					)
				),
				onTap: () {
					this.onTap(context, link: this.model.link);
				}
			)
		);
	}
}
