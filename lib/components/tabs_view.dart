import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'layout_container_mixin.dart';
import 'list_layout.dart';
import 'list_layout_event.dart';
import '../common/utils.dart';
import 'package:flutter_app/models/layout_model.dart';
import 'package:flutter_app/models/tabs_view_model.dart';
import '../models/theme_model.dart';
import '../provider/theme_provider.dart';

class TabsView extends StatefulWidget {
	final TabsViewModel model;
	final Function eventListener;

	TabsView({Key key, @required this.model, this.eventListener}) : super(key: key);

	@override
	State<StatefulWidget> createState() => TabsViewState();
}

class TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin, LayoutContainerMixin implements ListLayout {
	static final Logger logger = Logger("TabsViewState");
	TabsViewModel _model;
	int _index;
	TabController _controller;
	List<Map> _items;

	bool get isReachBottom {
		bool isReachBottom = true;
		if (this._items[this._index]["key"].currentState != null) {
			isReachBottom = this._items[this._index]["key"].currentState.isReachBottom;
		}
		return isReachBottom;
	}

	@override
	void initState() {
		logger.info("TabsView initState");
		super.initState();
		this._model = widget.model;
		this._index = 0;
		this._controller = TabController(
			length: this._model.items.length,
			vsync: this
		);
		this._controller.addListener(() {
			if (this._controller.indexIsChanging) {
				this.setState(() {
					this._index = this._controller.index;
				});
			}
		});
		this._items = this._getItems();
	}

	@override
	Widget build(BuildContext context) {
		Widget content = this._items[this._index]["widget"];
		return SliverStickyHeader(
			header: _Tabs(items: widget.model.items, controller: this._controller),
			sliver: content
		);
	}

	List<Map> _getItems() {
		List<Map> items = [];
		for (TabViewModel item in this._model.items) {
			GlobalKey<_ContentState> key = GlobalKey<_ContentState>();
			logger.info(item.code);
			Widget widget = _Content(code: item.code);
			items.add({"key": key, "widget": widget});
		}
		return items;
	}

	void onListEvent(int event, Key key) {
		if (widget.eventListener != null) {
			if (event == ListLayoutEvent.LOADED) {
				widget.eventListener(ListLayoutEvent.LOADED, widget.key);
			} else if (event == ListLayoutEvent.REACH_BOTTOM) {
				this.onReachBottom();
			}
		}
	}

	@override
	void onReachBottom() {
		if (this.isReachBottom) {
			return;
		}
		for (Map item in this._items) {
			if (item["key"] != null && item["key"].currentState is ListLayout && !item["key"].currentState.isReachBottom) {
				item["key"].currentState.onReachBottom();
				return;
			}
		}
		if (widget.eventListener != null) {
			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
		}
	}

	void show() {
		this.setState(() => this._model.isShow = true);
	}

	void hide() {
		this.setState(() => this._model.isShow = false);
	}
}

class _Tabs extends StatelessWidget {
	final List<TabViewModel> items;
	final TabController controller;
	_Tabs({@required this.items, @required this.controller});

	Widget build(BuildContext context) {
		double tabWidth = Utils.DESIGN_WIDTH / this.items.length;
		if (this.items.length >= 5) {
			tabWidth = 140;
		}
		ThemeModel themeModel = Provider.of<ThemeProvider>(context).getThemeModel();
		return Container(
			width: Utils.px2dp(Utils.DESIGN_WIDTH),
			height: Utils.px2dp(60),
			decoration: BoxDecoration(
				color: Utils.getColorFromString("#ffffff"),
				border: Border(bottom: BorderSide(color: Utils.getColorFromString("#f1f1f1")))
			),
			child: TabBar(
				isScrollable: true,
				controller: this.controller,
				unselectedLabelStyle: TextStyle(fontSize: Utils.px2dp(28, isText: true, context: context)),
				unselectedLabelColor: Utils.getColorFromString("#333333"),
				labelStyle: TextStyle(fontSize: Utils.px2dp(30, isText: true, context: context), fontWeight: FontWeight.bold),
				labelColor: Utils.getColorFromString(themeModel.mainColor),
				labelPadding: EdgeInsets.all(0),
				indicator: UnderlineTabIndicator(
					borderSide: BorderSide(width: Utils.px2dp(6), color: Utils.getColorFromString(themeModel.mainColor)),
					insets: EdgeInsets.symmetric(horizontal: Utils.px2dp((tabWidth - 32) / 2))
				),
				tabs: this.items.map((item) {
					return Tab(
						child: Container(
							width: Utils.px2dp(tabWidth),
							child: Center(
								child: Text(item.title)
							)
						)
					);
				}).toList()
			)
		);
	}
}

class _Content extends StatefulWidget {
	final String code;

	_Content({Key key, @required this.code}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _ContentState();
}

class _ContentState extends State<_Content> with LayoutContainerMixin implements ListLayout {
	static final Logger logger = Logger("_ContentState");
	LayoutModel _layoutModel;
	List<Map> _items;
	bool _isReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		logger.info(widget.code);
		super.initState();
		this._items = [];
		this._isReachBottom = false;
		this._getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> list = [];
		for (Map item in this._items) {
			Widget widget = item["widget"];
			if (widget.runtimeType != TabsView) {
				list.add(widget);
			}
		}
		return SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) => list[index], childCount: list.length));
	}

	void _getLayouts() async {
		this.setState(() {
			if (this._layoutModel != null) {
				this._layoutModel.modules = [];
			}
		});
		LayoutModel layoutModel = await this.getLayouts(widget.code);
		List<Map> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		this.setState(() {
			this._layoutModel = layoutModel;
			this._items = items;
		});
	}

	@override
	void onReachBottom() {
		if (this.isReachBottom) {
		  	return;
		}
		for (Map item in this._items) {
			if (item["key"] != null && item["key"].currentState is ListLayout && !item["key"].currentState.isReachBottom) {
				item["key"].currentState.onReachBottom();
				return;
			}
		}
//		if (widget.eventListener != null) {
//			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
//		}
	}
}
