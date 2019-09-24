import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'layout_container_mixin.dart';
import 'layout_interface.dart';
import 'list_layout_interface.dart';
import 'list_layout_event.dart';
import '../common/utils.dart';
import '../models/layout_model.dart';
import '../models/state_reference_model.dart';
import '../models/tabs_view_model.dart';
import '../models/theme_model.dart';
import '../provider/theme_provider.dart';

class TabsView extends StatefulWidget {
	final TabsViewModel model;
	final Function eventListener;

	TabsView({Key key, @required this.model, this.eventListener}) : super(key: key);

	@override
	State<StatefulWidget> createState() => TabsViewState();
}

class TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin, LayoutContainerMixin implements ListLayoutInterface {
	static final Logger logger = Logger("TabsViewState");
	TabsViewModel _model;
	int _index;
	TabController _controller;
	List<StateReferenceModel> _items;

	bool get isReachBottom {
		bool isReachBottom = true;
		logger.info(this._items[this._index].key);
		logger.info(this._items[this._index].key.currentState);
		if (this._items[this._index].key.currentState != null) {
			ListLayoutInterface listLayout = this._items[this._index].key.currentState as ListLayoutInterface;
			isReachBottom = listLayout.isReachBottom;
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
					if (widget.eventListener != null) {
						Map<String, dynamic> params = {"isReachBottom": this.isReachBottom};
						widget.eventListener(ListLayoutEvent.RESET, widget.key, params: params);
					}
				});
			}
		});
		this._items = this._getItems();
	}

	@override
	Widget build(BuildContext context) {
		return SliverStickyHeader(
			header: _Tabs(items: widget.model.items, controller: this._controller),
			sliver: this._buildContent(context)
		);
	}

	Widget _buildContent(BuildContext context) {
		List<Widget> children = [];
		for (int i = 0; i < this._items.length; i++) {
			children.add(Offstage(
				offstage: i != this._index,
				child: this._items[i].widget,
			));
		}
		return SliverToBoxAdapter(
			child: Column(
				children: children
			)
		);
	}

	List<StateReferenceModel> _getItems() {
		List<StateReferenceModel> items = [];
		for (TabViewModel item in this._model.items) {
			GlobalKey<_ContentState> key = GlobalKey<_ContentState>();
			logger.info(item.code);
			Widget content = _Content(key: key, code: item.code, eventListener: this.onListEvent);
			StateReferenceModel stateReferenceModel = StateReferenceModel();
			stateReferenceModel.key = key;
			stateReferenceModel.widget = content;
			items.add(stateReferenceModel);
		}
		return items;
	}

	void onListEvent(int event, Key key) {
		if (widget.eventListener != null) {
			if (event == ListLayoutEvent.LOADED) {
				widget.eventListener(ListLayoutEvent.LOADED, widget.key);
			} else if (event == ListLayoutEvent.REACH_BOTTOM) {
				this.onListReachBottom();
			}
		}
	}

	void onListReachBottom() {
		if (widget.eventListener != null) {
			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
		}
	}

	@override
	void onReachBottom() {
		logger.info("isReachBottom: ${this.isReachBottom}");
		if (this.isReachBottom) {
			return;
		}
		StateReferenceModel item = this._items[this._index];
		if (item.key != null && item.key.currentState is ListLayoutInterface) {
			ListLayoutInterface listLayout = item.key.currentState as ListLayoutInterface;
			if (!listLayout.isReachBottom) {
				listLayout.onReachBottom();
				return;
			}
		}
		if (widget.eventListener != null) {
			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
		}
	}

	bool get isShow => this._model.isShow;

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
	final Function eventListener;

	_Content({Key key, @required this.code, this.eventListener}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _ContentState();
}

class _ContentState extends State<_Content> with LayoutContainerMixin implements ListLayoutInterface {
	static final Logger logger = Logger("_ContentState");
	LayoutModel _layoutModel;
	List<StateReferenceModel> _items;
	bool _isReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		logger.info("${widget.code} init");
		super.initState();
		this._items = [];
		this._isReachBottom = false;
		this._getLayouts();
		logger.info(widget.key);
	}

	@override
	void dispose() {
		logger.info("${widget.code} dispose");
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> list = [];
		for (StateReferenceModel item in this._items) {
			if (item.widget.runtimeType != TabsView) {
				list.add(item.widget);
			}
		}
		return ListView.builder(
			padding: EdgeInsets.all(0),
			shrinkWrap: true,
			physics: NeverScrollableScrollPhysics(),
			itemBuilder: (BuildContext context, int index) => list[index],
			itemCount: list.length
		);
	}

	void _getLayouts() async {
		this.setState(() {
			if (this._layoutModel != null) {
				this._layoutModel.modules = [];
			}
		});
		LayoutModel layoutModel = await this.getLayouts(widget.code);
		logger.info(layoutModel.toJson());
		List<StateReferenceModel> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		this.setState(() {
			this._layoutModel = layoutModel;
			this._items = items;
		});
	}

	void onListEvent(int event, Key key) {
		if (widget.eventListener != null) {
			if (event == ListLayoutEvent.LOADED) {
				widget.eventListener(event, widget.key);
			} else if (event == ListLayoutEvent.REACH_BOTTOM) {
				this.onListReachBottom();
			}
		}
	}

	void onListReachBottom() {
		for (StateReferenceModel item in this._items) {
			if (item.key != null && item.key.currentState != null) {
				LayoutInterface layout = item.key.currentState as LayoutInterface;
				if (!layout.isShow) {
					layout.show();
					if (item.key.currentState is ListLayoutInterface) {
						return;
					}
				}
			}
		}
		if (widget.eventListener != null) {
			this._isReachBottom = true;
			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
		}
	}

	@override
	void onReachBottom() {
		logger.info("isReachBottom: ${this.isReachBottom}");
		if (this.isReachBottom) {
		  	return;
		}
		for (StateReferenceModel item in this._items) {
			if (item.key != null && item.key.currentState is ListLayoutInterface) {
				ListLayoutInterface listLayout = item.key.currentState as ListLayoutInterface;
				if (!listLayout.isReachBottom) {
					listLayout.onReachBottom();
					return;
				}
			}
		}
		if (widget.eventListener != null) {
			this._isReachBottom = true;
			widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
		}
	}

	@override
	void hide() {
		// TODO: implement hide
	}

	@override
	// TODO: implement isShow
	bool get isShow => null;

	@override
	void show() {
		// TODO: implement show
	}
}
