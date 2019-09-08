import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/layout_model.dart";
import "package:flutter_app/models/layout/tabs_view_model.dart";
import "package:flutter_app/models/theme_model.dart";
import "package:flutter_app/provider/theme_provider.dart";
import "package:provider/provider.dart";

class TabsView extends StatefulWidget {
	final TabsViewModel _tabsViewModel;

	TabsView(this._tabsViewModel, {Key key}) : super(key: key);

	@override
	State<StatefulWidget> createState() => TabsViewState();
}

class TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin implements ListLayout {
	int _index;
	TabController _tabController;
	LayoutModel _layoutModel;
	bool _isReachBottom;
	Layout _layout;
	GlobalKey<LayoutState> _layoutStateKey;

	@override
	void initState() {
		super.initState();
		this._index = 0;
		this._tabController = TabController(
			length: widget._tabsViewModel.items.length,
			vsync: this
		);
		this._tabController.addListener(() {
			if (this._tabController.indexIsChanging) {
				this.setState(() {
					this._index = this._tabController.index;
					this.getLayouts();
				});
			}
		});
		this._isReachBottom = false;
		this.getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				this._buildTabs(context),
				this._buildLayout()
			]
		);
	}

	Widget _buildTabs(BuildContext context) {
		double tabWidth = Utils.DESIGN_WIDTH / widget._tabsViewModel.items.length;
		if (widget._tabsViewModel.items.length >= 5) {
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
				tabs: widget._tabsViewModel.items.map((item) {
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
		if (this._layoutModel == null) {
			return Container();
		} else {
			this._layoutStateKey = GlobalKey<LayoutState>();
			this._layout = Layout(this._layoutModel.modules, isChild: true, key: this._layoutStateKey);
			return this._layout;
		}
	}

	void getLayouts() async {
		String code = widget._tabsViewModel.items[this._index].code;
		LayoutModel layoutModel = await SiteController.getLayoutByCode(code);
		if (layoutModel == null) {
			return;
		}
		this.setState(() => this._layoutModel = layoutModel);
	}

	@override
	void onReachBottom() {
		if (this._isReachBottom) {
			return;
		}
		if (this._layoutStateKey != null) {
			print(this._layoutStateKey);
			print(this._layoutStateKey.currentState);
			this._layoutStateKey.currentState.onReachBottom();
		}
	}
}
