import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class Swiper extends StatefulWidget {
	final bool autoplay;
	final bool circular;
	final int interval;
	final int duration;
	final int current;
	final List<Widget> children;
	final PageController controller;

	Swiper({
		Key key,
		this.autoplay: false,
		this.interval: 5000,
		this.duration: 500,
		this.circular: false,
		this.current: 0,
		@required this.children,
		this.controller
	}) : super(key: key);

	@override
	State<StatefulWidget> createState() => SwiperState();
}

class SwiperState extends State<Swiper> {
	static final Logger logger = Logger("SwiperState");
	int _current;
	List<Widget> _children;
	PageController _controller;
	Timer _timer;

	@override
	void initState() {
		super.initState();
		this._current = widget.current;
		this._initChildren();
		this._initController();
		this._initTimer();
	}

	void _initChildren() {
		List<Widget> children = List.from(widget.children);
		if (widget.circular && widget.children.length > 0) {
			this._current++;
			children.add(widget.children[0]);
			children.insert(0, widget.children[widget.children.length - 1]);
		}
		this._children = children;
	}

	void _initController() {
		this._controller = PageController(initialPage: this._current);
		this._controller.addListener(this._listener);
	}

	void _initTimer() {
		if (widget.autoplay && widget.interval > 0) {
			this._timer = Timer.periodic(Duration(milliseconds: widget.interval), (timer) {
				int index = this._current + 1;
				this._controller.animateToPage(index, duration: Duration(milliseconds: widget.duration), curve: Curves.ease);
			});
		}
	}

	void _clearTimer() {
		this._timer?.cancel();
	}

	@override
	void dispose() {
		this._clearTimer();
		this._controller?.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTapDown: (TapDownDetails details) {
				this._clearTimer();
			},
			onTapUp: (TapUpDetails details) {
				this._initTimer();
			},
			onTapCancel: () {
				this._initTimer();
			},
			child: PageView(
				children: this._children,
				onPageChanged: this._onPageChanged,
				controller: this._controller
			)
		);
	}

	void _listener() {

	}

	void _onPageChanged(int index) {
		this._clearTimer();
		this._initTimer();
		if (!widget.circular) {
			this._current = index;
			return;
		}
		if (index == 0) {
			this._current = this._children.length - 2;
			RenderBox box = this.context.findRenderObject();
			double offset = box.size.width * (this._current + this._controller.page % 1);
			this._controller.jumpTo(offset);
		} else if (index == this._children.length - 1) {
			this._current = 0;
			RenderBox box = this.context.findRenderObject();
			double offset = box.size.width * (this._current + this._controller.page % 1);
			this._controller.jumpTo(offset);
		} else {
			this._current = index;
		}
	}
}
