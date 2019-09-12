import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/layout/layout_container_mixin.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/components/notifications/list_layout_notification.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/layout_model.dart";
import "package:flutter_app/models/layout/list_model.dart";
import "package:flutter_app/models/layout/tabs_view_model.dart";
import "package:flutter_app/models/theme_model.dart";
import "package:flutter_app/provider/theme_provider.dart";
import "package:flutter_sticky_header/flutter_sticky_header.dart";
import "package:provider/provider.dart";

class TabsView extends StatefulWidget {
	final TabsViewModel model;
	final Function eventListener;

	TabsView({Key key, @required this.model, this.eventListener}) : super(key: key);

	@override
	State<StatefulWidget> createState() => TabsViewState();
}

class TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin, LayoutContainerMixin implements ListLayout {
	int _index;
	TabController _tabController;
	LayoutModel _layoutModel;
	bool _isReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		print("TabsView initState");
		super.initState();
		this.isChild = true;
		this._index = 0;
		this._tabController = TabController(
			length: widget.model.items.length,
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
		double tabWidth = Utils.DESIGN_WIDTH / widget.model.items.length;
		if (widget.model.items.length >= 5) {
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
				unselectedLabelStyle: TextStyle(fontSize: Utils.px2dp(28)),
				unselectedLabelColor: Utils.getColorFromString("#333333"),
				labelStyle: TextStyle(fontSize: Utils.px2dp(30), fontWeight: FontWeight.bold),
				labelColor: Utils.getColorFromString(themeModel.mainColor),
				labelPadding: EdgeInsets.all(0),
				indicator: UnderlineTabIndicator(
					borderSide: BorderSide(width: Utils.px2dp(6), color: Utils.getColorFromString(themeModel.mainColor)),
					insets: EdgeInsets.symmetric(horizontal: Utils.px2dp((tabWidth - 32) / 2))
				),
				tabs: widget.model.items.map((item) {
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
		this.setState(() => this._layoutModel = null);
		String code = widget.model.items[this._index].code;
		LayoutModel layoutModel = await this.getLayouts(code);
		List<Map> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		this.setState(() {
			this._layoutModel = layoutModel;
			this.items = items;
		});
	}

	void onListEvent(int message, Key key) {
		if (widget.eventListener != null) {
			widget.eventListener(ListLayoutNotification.MESSAGE_LOADED, widget.key);
		}
	}

	@override
	void onReachBottom() {
		print("onReachBottom");
		if (this._isReachBottom) {
			return;
		}
		for (Map item in this.items) {
			if (item["key"] != null && item["key"].currentState is ListLayout && !item["key"].currentState.isReachBottom) {
				item["key"].currentState.onReachBottom();
				break;
			}
		}
	}
}
