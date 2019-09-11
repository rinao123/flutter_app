import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/layout/layout_container_mixin.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/components/layout/tabs_view.dart";
import "package:flutter_app/components/loading.dart";
import "package:flutter_app/components/notifications/list_layout_notification.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/layout_model.dart";
import "package:flutter_app/models/layout/list_model.dart";

class LayoutPage extends StatefulWidget {
	final String code;

	LayoutPage(this.code);

	@override
	State<StatefulWidget> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> with LayoutContainerMixin {
	LayoutModel _layoutModel;
	ScrollController _scrollController;
	bool _isReachBottom;


	@override
	void initState() {
		super.initState();
		this._scrollController = ScrollController();
		this._scrollController.addListener(this._onScroll);
		this.items = [];
		this.isLoading = true;
		this._isReachBottom = false;
		this._getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> silvers = [];
		Widget header = this._buildHeader();
		silvers.add(header);
		List<Widget> items = this._buildBody();
		silvers.addAll(items);
		return Scaffold(
			body: RefreshIndicator(
				child: CustomScrollView(
					controller: this._scrollController,
					slivers: silvers
				),
				onRefresh: this._onRefresh
			)
		);
	}

	Widget _buildHeader() {
		String backgroundColor = this._layoutModel == null ? "#ffffff" : this._layoutModel.backgroundColor;
		String titleColor = this._layoutModel == null ? "#000000" : this._layoutModel.frontColor;
		String title = this._layoutModel == null ? "" : this._layoutModel.title;
		return SliverAppBar(
			backgroundColor: Utils.getColorFromString(backgroundColor),
			brightness: Brightness.light,
			iconTheme: IconThemeData(color: Colors.black),
			title: Text(
				title,
				style: TextStyle(color: Utils.getColorFromString(titleColor))
			),
			pinned: true
		);
	}

	List<Widget> _buildBody() {
		List<Widget> body = [];
		List<Widget> list = [];
		for (Map item in this.items) {
			Widget widget = item["widget"];
			if (widget.runtimeType == TabsView) {
				SliverList sliverList = this._getSliverList(list);
				body.add(sliverList);
				list = [];
				body.add(widget);
			} else {
				list.add(widget);
			}
		}
		if (list.length > 0) {
			SliverList sliverList = this._getSliverList(list);
			body.add(sliverList);
		}
		return body;
	}

	SliverList _getSliverList(List<Widget> list) {
		SliverList sliverList = SliverList(
			delegate: SliverChildBuilderDelegate(
				(BuildContext context, int index) {
					return list[index];
				},
				childCount: list.length
			)
		);
		return sliverList;
	}

	Future<void> _onRefresh() async {
		this._getLayouts();
	}

	void _onScroll() {
		ScrollPosition position = _scrollController.position;
		if (position.userScrollDirection == ScrollDirection.reverse && position.pixels >= position.maxScrollExtent - 50 && !this.isLoading) {
			this.showLoading();
			this.onReachBottom();
		}
	}

//	bool onListLayoutNotification(ListLayoutNotification notification) {
//		if (notification.message == ListLayoutNotification.MESSAGE_LOADED) {
//			this.hideLoading();
//		}
//		return true;
//	}

	void onReachBottom() {
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

	void _getLayouts() async {
		this.setState(() => this._layoutModel = null);
		LayoutModel layoutModel = await this.getLayouts(widget.code);
		List<Map> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		GlobalKey<LoadingState> key = GlobalKey<LoadingState>();
		Loading loading = Loading(key: key, isShow: this.isLoading, isReachBottom: this._isReachBottom);
		items.add({"key": key, "widget": loading});
		this.setState(() {
			this._layoutModel = layoutModel;
			this.items = items;
			this.hideLoading();
		});
	}
}
