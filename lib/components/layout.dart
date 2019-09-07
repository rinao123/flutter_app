import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout/carousel.dart";
import "package:flutter_app/components/layout/goods_list.dart";
import "package:flutter_app/components/layout/icons.dart" as icons;
import "package:flutter_app/components/layout/img1.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/components/layout/search.dart";
import "package:flutter_app/components/layout/tabs_view.dart";
import "package:flutter_app/components/loading.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";

class Layout extends StatefulWidget {
	final List<BaseModel> modules;
	final bool isChild;

	Layout(this.modules, {Key key, this.isChild = false}) : super(key: key);

	@override
	State<StatefulWidget> createState() => LayoutState();
}

class LayoutState extends State<Layout> {
	List<Widget> _items;
	List<GlobalKey> _keys;
	ScrollController _scrollController;
	bool _isLoading;
	bool _isReachBottom;

	@override
	void initState() {
		super.initState();
		this._items = [];
		this._keys = [];
		if (!widget.isChild) {
			this._scrollController = ScrollController();
			this._scrollController.addListener(this._onPageScroll);
		}
		this._isLoading = false;
		this._isReachBottom = false;
	}

	@override
	Widget build(BuildContext context) {
		bool shrinkWrap = widget.isChild;
		ScrollPhysics physics = widget.isChild ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics();
		print(shrinkWrap);
		this._items = this._buildBodyItems();
		if (!widget.isChild) {
			_items.add(Loading(this._isLoading, this._isReachBottom));
		}
		if (this._items.length > 0) {
			return ListView.builder(
				shrinkWrap: shrinkWrap,
				physics: physics,
				controller: this._scrollController,
				itemCount: this._items.length,
				itemBuilder: (context, index) {
					return this._items[index];
				}
			);
		} else {
			return Container();
		}
	}

	List<Widget> _buildBodyItems() {
		List<Widget> items = [];
		for (BaseModel module in widget.modules) {
			Widget item = this._buildBodyItem(module);
			if (item != null) {
				items.add(item);
			}
		}
		return items;
	}

	Widget _buildBodyItem(BaseModel module) {
		switch (module.runtimeType.toString()) {
			case "CarouselModel":
				return Carousel(module);
			case "Img1Model":
				this._keys.add(null);
				return Img1(module);
			case "IconsModel":
				return icons.Icons(module);
			case "GoodsListModel":
				GlobalKey<GoodsListState> key = GlobalKey<GoodsListState>();
				this._keys.add(key);
				GoodsListModel goodsListModel = module as GoodsListModel;
				goodsListModel.isLoadingControlByPage = true;
				return GoodsList(module, key: key);
			case "SearchModel":
				return Search(module);
			case "TabsViewModel":
				GlobalKey<TabsViewState> key = GlobalKey<TabsViewState>();
				this._keys.add(key);
				return TabsView(module, key: key);
			default:
				print("_buildBodyItem unknown module");
				return null;
		}
	}

	void _onPageScroll() {
		if (this._scrollController.position.userScrollDirection == ScrollDirection.reverse && this._scrollController.offset >= this._scrollController.position.maxScrollExtent - 50 && !this._isLoading) {
			this._isLoading = true;
			this.onReachBottom();
		}
	}

	void onReachBottom() {
		for (int i = 0; i < this._items.length; i++) {
			GlobalKey key = this._keys[i];
			if (key != null && key.currentState is ListLayout) {
				ListLayout listLayout = key.currentState as ListLayout;
				listLayout.onReachBottom();
				break;
			}
		}
	}
}
