import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";

class Loading extends StatefulWidget {
	bool isShow;
	bool isReachBottom;
	final String text;

	Loading({Key key, this.isShow: true, @required this.isReachBottom, this.text: "—— 云来商城提供技术支持 ——"}) : super(key: key);

	@override
	State<StatefulWidget> createState() => LoadingState();
}

class LoadingState extends State<Loading> {

	@override
	void initState() {
		print("Loaidng initState");
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		Widget content;
		if (widget.isReachBottom) {
			content = Text(
				widget.text,
				style: TextStyle(
					fontSize: Utils.px2dp(24),
					color: Utils.getColorFromString("rgba(85,85,85,0.3)")
				)
			);
		} else {
			content = Image.asset(
				"assets/images/loading.gif",
				width: Utils.px2dp(64),
				height: Utils.px2dp(64)
			);
		}
		return Offstage(
			offstage: !widget.isShow && !widget.isReachBottom,
			child: Container(
				width: Utils.px2dp(Utils.DESIGN_WIDTH),
				height: Utils.px2dp(112),
				child: Center(
					child: content
				)
			)
		);
	}

	void show() {
		this.setState(() => widget.isShow = true);
	}

	void hide() {
		this.setState(() => widget.isShow = false);
	}

	void reset() {
		this.setState(() => widget.isReachBottom = false);
	}

	void reachBottom() {
		this.setState(() => widget.isReachBottom = true);
	}
}
