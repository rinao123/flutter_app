import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'layout_interface.dart';
import '../common/utils.dart';
import '../models/notice_model.dart';

class Notice extends StatefulWidget {
	final NoticeModel model;

	Notice({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => NoticeState();
}

class NoticeState extends State<Notice> with SingleTickerProviderStateMixin  implements LayoutInterface {
	static const HEIGHT = 80;
	NoticeModel _model;
	GlobalKey _textKey;
	Timer _timer;
	AnimationController _controller;
	Animation<Offset> _animation;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
		this._textKey = GlobalKey();
		if (this._model.isRolling || this._model.duration > 0) {
			this._initAnimation();
			this._timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
				if (this._textKey.currentContext != null) {
					RenderBox renderBox = this._textKey.currentContext.findRenderObject();
					this._startAnimation(renderBox.size.width);
					timer?.cancel();
				}
			});
		}
	}

	@override
	void dispose() {
		this._timer?.cancel();
		this._controller?.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		bool offstage = !this._model.isShow;
		if (!offstage) {
			if (this._model.startTime > 0 && this._model.endTime > 0) {
				int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
				offstage = !(now >= this._model.startTime && now < this._model.endTime);
			}
		}
		return Offstage(
			offstage: offstage,
			child: Container(
				color: Utils.getColorFromString(this._model.backgroundColor),
				height: Utils.px2dp(HEIGHT),
				child: Stack(
					children: <Widget>[
						this._buildContainer(context),
						this._buildIcon(context)
					],
				)
			)
		);
	}

	Widget _buildIcon(BuildContext context) {
		return Positioned(
			top: 0,
			left: 0,
			child:	Container(
				width: Utils.px2dp(HEIGHT),
				height: Utils.px2dp(HEIGHT),
				color: Utils.getColorFromString(this._model.backgroundColor),
				child: Center(
					child: Icon(IconData(0xe655, fontFamily: "iconfont"), color: Utils.getColorFromString(this._model.textColor), size: Utils.px2dp(44))
				)
			)
		);
	}

	Widget _buildContainer(BuildContext context) {
		return Positioned(
			top: 0,
			left: Utils.px2dp(HEIGHT),
			child: Container(
				width: Utils.px2dp(750 - HEIGHT),
				height: Utils.px2dp(HEIGHT),
				child: Stack(
					alignment: AlignmentDirectional.centerStart,
					children: <Widget>[
						this._buildText(context),
						this._buildLeftGradient(context),
						this._buildRightGradient(context)
					]
				)
			)
		);
	}

	Widget _buildLeftGradient(BuildContext context) {
		Color color = Utils.getColorFromString(this._model.backgroundColor);
		return Positioned(
			top: 0,
			left: 0,
			child: Container(
				width: Utils.px2dp(20),
				height: Utils.px2dp(HEIGHT),
				decoration: BoxDecoration(
					gradient: LinearGradient(colors: [color.withOpacity(1), color.withOpacity(0)])
				)
			)
		);
	}

	Widget _buildRightGradient(BuildContext context) {
		Color color = Utils.getColorFromString(this._model.backgroundColor);
		return Positioned(
			top: 0,
			right: 0,
			child: Container(
				width: Utils.px2dp(20),
				height: Utils.px2dp(HEIGHT),
				decoration: BoxDecoration(
					gradient: LinearGradient(colors: [color.withOpacity(0), color.withOpacity(1)])
				)
			)
		);
	}

	Widget _buildText(BuildContext context) {
		if (this._model.isRolling && this._model.duration > 0) {
			return this._buildRollingText(context);
		} else {
			return this._buildStaticText(context);
		}
	}

	Widget _buildRollingText(BuildContext context) {
		return Positioned(
			top: 0,
			left: 0,
			height: Utils.px2dp(HEIGHT),
			child: Row(
				children: <Widget>[
					SlideTransition(
						position: this._animation,
						child: Text(
							this._model.notice,
							key: this._textKey,
							style: TextStyle(
								fontSize: Utils.px2dp(28, isText: true, context: context),
								color: Utils.getColorFromString(this._model.textColor)
							),
							maxLines: 1
						)
					)
				]
			)
		);
	}

	Widget _buildStaticText(BuildContext context) {
		return Positioned(
			top: 0,
			left: Utils.px2dp(20),
			height: Utils.px2dp(HEIGHT),
			child: Row(
				children: <Widget>[
					Text(
						this._model.notice,
						style: TextStyle(
							fontSize: Utils.px2dp(28, isText: true, context: context),
							color: Utils.getColorFromString(this._model.textColor)
						),
						maxLines: 1
					)
				]
			)
		);
	}

	void _initAnimation() {
		this._controller = AnimationController(duration: Duration(seconds: this._model.duration), vsync: this);
		Tween tween = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(1.0, 0.0));
		this._animation = tween.animate(this._controller);
	}

	void _startAnimation(double textWidth) {
		this._controller.addStatusListener((status) {
			if (status == AnimationStatus.completed) {
				this._controller.reset();
				this._controller.forward();
			}
		});
		Tween tween = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(-1.0, 0.0));
		double distance = Utils.px2dp(750.0 - HEIGHT);
		if (textWidth < distance) {
			double start = distance / textWidth;
			tween = Tween<Offset>(begin: Offset(start, 0.0), end: Offset(-1.0, 0.0));
		}
		this.setState(() {
			this._animation = tween.animate(this._controller);
			this._controller.forward();
		});
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
