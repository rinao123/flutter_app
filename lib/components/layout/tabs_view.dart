import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import 'package:flutter_app/components/layout.dart';
import "package:flutter_app/components/layout/layout_behaviors.dart";
import 'package:flutter_app/models/layout/tabs_view_model.dart';

class TabsView extends StatefulWidget {
	final TabsViewModel _tabsViewModel;

	TabsView(this._tabsViewModel);

	@override
	State<StatefulWidget> createState() {
		return _TabsViewState(this._tabsViewModel);
	}
}

class _TabsViewState extends State<TabsView> with SingleTickerProviderStateMixin {
	TabsViewModel _tabsViewModel;
	TabController _tabController;
	int _index;

	_TabsViewState(this._tabsViewModel) {
		this._tabController = TabController(
			length: this._tabsViewModel.items.length,
			vsync: this
		);
		this._tabController.addListener(() {
			if (this._tabController.indexIsChanging) {
				this.setState(() => this._index = this._tabController.index);
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				this._buildTabs()
			]
		);
	}

	Widget _buildTabs() {
		return TabBar(
			isScrollable: true,
			controller: this._tabController,
			labelColor: Colors.red,
			unselectedLabelColor: Color(0xff666666),
			labelStyle: TextStyle(fontSize: 16.0),
			tabs: this._tabsViewModel.items.map((item) {
				return Tab(
					text: item.title
				);
			}).toList()
		);
	}
}
