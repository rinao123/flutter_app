import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";

class Loading extends StatelessWidget {
	final bool _isShow;
	final bool _isReachBottom;
	final String text;

	Loading(this._isShow, this._isReachBottom, {this.text: "—— 云来商城提供技术支持 ——"});

	@override
	Widget build(BuildContext context) {
		Widget content;
		if (this._isReachBottom) {
			content = Text(
				this.text,
				style: TextStyle(
					fontSize: Utils.px2dp(24),
					color: Utils.getColorFromString("rgba(rgba(85,85,85,0.3))")
				)
			);
		} else {
			content = Image(
				image: AssetImage("assets/images/loading.gif"),
				width: Utils.px2dp(64),
				height: Utils.px2dp(64)
			);
		}
		return Offstage(
			offstage: this._isShow,
			child: Container(
				width: Utils.px2dp(Utils.DESIGN_WIDTH),
				height: Utils.px2dp(112),
				child: Center(
					child: content
				)
			)
		);
	}
}
