import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../common/utils.dart';
import '../../components/layout/layout_container_mixin.dart';
import '../../components/layout/list_layout.dart';
import '../../components/layout/list_layout_event.dart';
import '../../models/layout/layout_model.dart';
import '../../models/layout/tabs_view_model.dart';
import '../../models/theme_model.dart';
import '../../provider/theme_provider.dart';

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
	TabController _tabController;
	List<Widget> _contents;
	bool _isReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		logger.info("TabsView initState");
		super.initState();
		this.isChild = true;
		this._model = widget.model;
		this._index = 0;
		this._tabController = TabController(
			length: this._model.items.length,
			vsync: this
		);
		this._tabController.addListener(() {
			if (this._tabController.indexIsChanging) {
				this.setState(() {
					this._index = this._tabController.index;
					this._getLayouts();
				});
			}
		});
		this.items = [];
		this._contents = [];
		this._isReachBottom = false;
		this._getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		return SliverStickyHeader(
			header: this._buildTabs(context),
			sliver:this._buildLayout()
		);
	}

	Widget _buildTabs(BuildContext context) {
		double tabWidth = Utils.DESIGN_WIDTH / this._model.items.length;
		if (this._model.items.length >= 5) {
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
				controller: this._tabController,
				unselectedLabelStyle: TextStyle(fontSize: Utils.px2dp(28, isText: true, context: context)),
				unselectedLabelColor: Utils.getColorFromString("#333333"),
				labelStyle: TextStyle(fontSize: Utils.px2dp(30, isText: true, context: context), fontWeight: FontWeight.bold),
				labelColor: Utils.getColorFromString(themeModel.mainColor),
				labelPadding: EdgeInsets.all(0),
				indicator: UnderlineTabIndicator(
					borderSide: BorderSide(width: Utils.px2dp(6), color: Utils.getColorFromString(themeModel.mainColor)),
					insets: EdgeInsets.symmetric(horizontal: Utils.px2dp((tabWidth - 32) / 2))
				),
				tabs: this._model.items.map((item) {
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

	Widget _buildLayout() {
		List<Widget> list = [];
		for (Map item in this.items) {
			Widget widget = item["widget"];
			if (widget.runtimeType != TabsView) {
				list.add(widget);
			}
		}
		return SliverList(
			delegate: SliverChildBuilderDelegate(
				(BuildContext context, int index) {
					return list[index];
				},
				childCount: list.length
			)
		);
	}

	void _getLayouts() async {
		String code = this._model.items[this._index].code;
		LayoutModel layoutModel = await this.getLayouts(code);
		List<Map> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		this.setState(() {
			this.items = items;
		});
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
		if (this._isReachBottom) {
			return;
		}
		for (Map item in this.items) {
			if (item["key"] != null && item["key"].currentState is ListLayout && !item["key"].currentState.isReachBottom) {
				item["key"].currentState.onReachBottom();
				return;
			}
		}
		this._isReachBottom = true;
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
