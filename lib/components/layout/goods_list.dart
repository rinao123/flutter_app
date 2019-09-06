import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/base_goods_list.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/controllers/goods_controller.dart";
import "package:flutter_app/models/goods_model.dart";
import "package:flutter_app/models/layout/base_goods_list_model.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";

class GoodsList extends StatefulWidget {
	final GoodsListModel goodsListModel;

	GoodsList(this.goodsListModel, {Key key}) : super(key: key);

	@override
	State<StatefulWidget> createState() => GoodsListState();
}

class GoodsListState extends State<GoodsList> with LayoutBehaviors, AutomaticKeepAliveClientMixin<GoodsList> implements ListLayout {
	int _page;
	List _goodsList;
	bool _isShowLoading;
	bool _isReachBottom;
	bool _isGoodsListReachBottom;

	@override
	void initState() {
		super.initState();
		this._page = 1;
		this._isShowLoading = false;
		this._isReachBottom = false;
		this._isGoodsListReachBottom = false;
		this._getGoodsList(1);
	}

	@override
	Widget build(BuildContext context) {
		if (this._goodsList == null) {
			return Container(
				width: Utils.px2dp(Utils.DESIGN_WIDTH),
				height: Utils.px2dp(100),
				child: Center(
					child: Text("正在加载中…")
				)
			);
		}
		BaseGoodsListModel baseGoodsListModel = BaseGoodsListModel();
		baseGoodsListModel.type = widget.goodsListModel.type;
		baseGoodsListModel.goodsStyle = widget.goodsListModel.goodsStyle;
		baseGoodsListModel.pageMargin = widget.goodsListModel.pageMargin;
		baseGoodsListModel.goodsMargin = widget.goodsListModel.goodsMargin;
		baseGoodsListModel.borderRadius = widget.goodsListModel.borderRadius;
		baseGoodsListModel.pictureScale = widget.goodsListModel.pictureScale;
		baseGoodsListModel.bold = widget.goodsListModel.bold;
		baseGoodsListModel.textAlign = widget.goodsListModel.textAlign;
		baseGoodsListModel.isShowGoodsName = widget.goodsListModel.isShowGoodsName;
		baseGoodsListModel.isShowSubTitle = widget.goodsListModel.isShowSubTitle;
		baseGoodsListModel.isShowPrice = widget.goodsListModel.isShowPrice;
		baseGoodsListModel.btn = widget.goodsListModel.btn;
		baseGoodsListModel.btnTitle = widget.goodsListModel.btnTitle;
		baseGoodsListModel.corner = widget.goodsListModel.corner;
		baseGoodsListModel.cornerWidth = widget.goodsListModel.cornerWidth;
		baseGoodsListModel.cornerHeight = widget.goodsListModel.cornerHeight;
		baseGoodsListModel.goodsList = this._goodsList;
		baseGoodsListModel.isShowLoading = this._isShowLoading;
		baseGoodsListModel.isReachBottom = this._isGoodsListReachBottom;
		return BaseGoodsList(baseGoodsListModel);
	}

	void _getGoodsList(int page) async {
		List<GoodsModel> goodsList = await GoodsController.getGoodsList(widget.goodsListModel.src, page, widget.goodsListModel.pageSize);
		if (goodsList == null) {
			return;
		}
		this._page = page;
		if (goodsList.length == widget.goodsListModel.pageSize) {
			this._page++;
		}
		this.setState(() {
			if (page == 1) {
				this._goodsList = goodsList;
			} else {
				this._goodsList.addAll(goodsList);
			}
			this._isShowLoading = !widget.goodsListModel.isLoadingControlByPage || widget.goodsListModel.type == 6;
			this._isGoodsListReachBottom = goodsList.length < widget.goodsListModel.pageSize;
		});
	}

	@override
	bool get wantKeepAlive => true;

	@override
	void onReachBottom() {
		print("onReachBottom");
		if (!this._isGoodsListReachBottom) {
			this._getGoodsList(this._page);
		}
	}
}
