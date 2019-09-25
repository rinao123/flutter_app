import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

import "layout_container_mixin.dart";
import 'layout_interface.dart';
import "list_layout_interface.dart";
import "list_layout_event.dart";
import "tabs_view.dart";
import "../common/utils.dart";
import "../models/layout_model.dart";
import '../models/state_reference_model.dart';

import "package:logging/logging.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";

class Layout extends StatefulWidget {
	final String code;

	Layout(this.code);

	@override
	State<StatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with LayoutContainerMixin {
	static final Logger logger = Logger("_LayoutState");
	LayoutModel _layoutModel;
	List<StateReferenceModel> _items;
	RefreshController _refreshController;
	ScrollController _scrollController;

	@override
	void initState() {
		super.initState();
		this._refreshController = RefreshController();
		this._scrollController = ScrollController();
		this._items = [];
		this._getLayouts();
	}

	@override
	void dispose() {
		this._refreshController.dispose();
		this._scrollController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		List<Widget> silvers = [];
		Widget header = this._buildHeader();
		silvers.add(header);
		List<Widget> items = this._buildBody();
		silvers.addAll(items);
		return Scaffold(
			body: SmartRefresher(
				enablePullDown: true,
				enablePullUp: true,
				controller: this._refreshController,
				child: CustomScrollView(
					controller: this._scrollController,
					slivers: silvers
				),
				onRefresh: this._onRefresh,
				onLoading: this.onReachBottom,
			)
		);
	}

	Widget _buildHeader() {
		String backgroundColor = this._layoutModel == null ? "#ffffff" : this._layoutModel.backgroundColor;
		String titleColor = this._layoutModel == null ? "#000000" : this._layoutModel.frontColor;
		String title = this._layoutModel == null ? "" : this._layoutModel.title;
		return SliverAppBar(
			elevation: 0,
			backgroundColor: Utils.getColorFromString(backgroundColor),
			brightness: titleColor == "#000000" ? Brightness.light : Brightness.dark,
			iconTheme: IconThemeData(color: titleColor == "#000000" ? Colors.black : Colors.white),
			title: Text(
				title,
				style: TextStyle(color: Utils.getColorFromString(titleColor))
			),
			pinned: true,
			expandedHeight: Utils.px2dp(370) - MediaQuery.of(context).padding.top,
			flexibleSpace: FlexibleSpaceBar(
				background: Container(
					width: Utils.px2dp(750),
					height: Utils.px2dp(370),
					child: Image.network("https://image.jielong.iyunlai.cn/product/detail/bb284c644e2dea07f2046e6364ac87d9.jpg", fit: BoxFit.fitWidth)
				)
			)
		);
	}

	List<Widget> _buildBody() {
		List<Widget> body = [];
		List<Widget> list = [];
		for (StateReferenceModel item in this._items) {
			if (item.widget.runtimeType == TabsView) {
				SliverList sliverList = this._getSliverList(list);
				body.add(sliverList);
				list = [];
				body.add(item.widget);
			} else {
				list.add(item.widget);
			}
		}
		if (list.length > 0) {
			SliverList sliverList = this._getSliverList(list);
			body.add(sliverList);
		}
		return body;
	}

	SliverList _getSliverList(List<Widget> list) {
		logger.info(list);
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

	void onListEvent(int event, Key key, {Map<String, dynamic> params}) {
		if (event == ListLayoutEvent.LOADED) {
			this._refreshController.loadComplete();
		} else if (event == ListLayoutEvent.REACH_BOTTOM) {
			this.onListReachBottom();
		} else if (event == ListLayoutEvent.RESET) {
			this.onTabsReset(key, params["isReachBottom"]);
		}
	}

	void onListReachBottom() {
		logger.info("onListReachBottom");
		for (StateReferenceModel item in this._items) {
			if (item.key != null && item.key.currentState != null) {
				LayoutInterface layout = item.key.currentState as LayoutInterface;
				logger.info(layout);
				logger.info(layout.isShow);
				if (!layout.isShow) {
					layout.show();
					if (item.key.currentState is ListLayoutInterface) {
						return;
					}
				}
			}
		}
		this._refreshController.loadNoData();
	}

	void onTabsReset(Key key, bool isReachBottom) {
		logger.info("isReachBottom:$isReachBottom");
		bool isShow = true;
		for (StateReferenceModel item in this._items) {
			if (item.key != null && item.key.currentState != null) {
				LayoutInterface layout = item.key.currentState as LayoutInterface;
				if (isShow) {
					layout.show();
				} else {
					layout.hide();
				}
				if (item.key == key) {
					RenderObject renderObject = item.key.currentContext.findRenderObject();
					RenderAbstractViewport viewport = RenderAbstractViewport.of(renderObject);
					RevealedOffset revealedOffset = viewport.getOffsetToReveal(renderObject, 0.0);
					double offset = revealedOffset.offset;
					if (this._scrollController.offset > offset) {
						this._scrollController.jumpTo(offset);
					}
					isShow = !isReachBottom;
				}
				if (item.key.currentState is ListLayoutInterface) {
					ListLayoutInterface listLayout = item.key.currentState as ListLayoutInterface;
					isShow = listLayout.isReachBottom;
				}
			}
		}
		logger.info("isShow:$isShow");
		if (isShow) {
			this._refreshController.loadNoData();
		} else {
			this._refreshController.resetNoData();
		}
	}

	void onReachBottom() {
		for (StateReferenceModel item in this._items) {
			if (item.key != null && item.key.currentState != null && item.key.currentState is ListLayoutInterface) {
				ListLayoutInterface listLayout = item.key.currentState as ListLayoutInterface;
				if ( !listLayout.isReachBottom) {
					listLayout.onReachBottom();
					return;
				}
			}
		}
	}

	void _getLayouts() async {
		this.setState(() {
			if (this._layoutModel != null) {
				this._layoutModel.modules = [];
			}
		});
		LayoutModel layoutModel = await this.getLayouts(widget.code);
		List<StateReferenceModel> items = [];
		if (layoutModel != null) {
			items = this.getLayoutWidgets(layoutModel.modules);
		}
		this._refreshController.refreshCompleted(resetFooterState: true);
		this.setState(() {
			this._layoutModel = layoutModel;
			this._items = items;
		});
	}
}
