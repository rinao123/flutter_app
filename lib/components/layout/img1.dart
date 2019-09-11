import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors_mixin.dart";
import "package:flutter_app/models/layout/img1_model.dart";

class Img1 extends StatefulWidget {
	final Img1Model model;

	Img1({@required this.model});

	@override
	State<StatefulWidget> createState() => Img1State();
}

class Img1State extends State<Img1> with LayoutBehaviorsMixin {

	@override
	Widget build(BuildContext context) {
		double margin = Utils.px2dp(widget.model.shadow ? 20 : 0);
		List<BoxShadow> boxShadow = [];
		if (widget.model.shadow) {
			boxShadow = [
				BoxShadow(offset: Offset(0, Utils.px2dp(8)), blurRadius: Utils.px2dp(16), spreadRadius: 0, color: Utils.getColorFromString("rgba(0,0,0,0.16)"))
			];
		}
		return Offstage(
			offstage: !widget.model.isShow,
			child: Container(
				color: Utils.getColorFromString("#ffffff"),
				margin: EdgeInsets.symmetric(vertical: margin),
				child: InkWell (
					child: Container(
						decoration: BoxDecoration(
							boxShadow: boxShadow
						),
						child: ClipRRect(
							borderRadius: BorderRadius.circular(Utils.px2dp(widget.model.borderRadius)),
							child: Image.network(
									widget.model.img,
								width: Utils.px2dp(widget.model.width),
								height: Utils.px2dp(widget.model.height),
								fit: BoxFit.fill
							)
						)
					),
					onTap: () {
						this.onTap(context, link: widget.model.link);
					}
				)
			)
		);
	}
}
