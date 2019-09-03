import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:flutter_app/common/utils.dart';
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/page_status.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/layout_model.dart";
import "package:flutter_app/models/layout/tabs_view_model.dart";

class TabsView extends StatefulWidget {
	final TabsViewModel _tabsViewModel;

	TabsView(this._tabsViewModel);

	@override
	State<StatefulWidget> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin {
	int _index;
	TabController _tabController;
	LayoutModel _layoutModel;

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
		this.getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				this._buildTabs(),
				this._buildLayout()
			]
		);
	}

	Widget _buildTabs() {
		return TabBar(
			isScrollable: true,
			controller: this._tabController,
			labelStyle: TextStyle(fontSize: 16.0),
			labelColor: Utils.getColorFromString(widget._tabsViewModel.textColor),
			unselectedLabelColor: Utils.getColorFromString(widget._tabsViewModel.textColorSelected),
			indicatorSize: TabBarIndicatorSize.label,
			indicatorWeight: Utils.px2dp(6),
			indicatorColor: Utils.getColorFromString(widget._tabsViewModel.lineColor),
			tabs: widget._tabsViewModel.items.map((item) {
				return Tab(
					text: item.title
				);
			}).toList()
		);
	}

	Widget _buildLayout() {
		if (this._layoutModel == null) {
			return PageStatus();
		} else {
			return Layout(this._layoutModel.modules);
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
}
