import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/base_goods_list.dart";
import "package:flutter_app/components/layout/layout_behaviors_mixin.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import 'package:flutter_app/components/notifications/list_layout_notification.dart';
import "package:flutter_app/controllers/goods_controller.dart";
import "package:flutter_app/models/goods_model.dart";
import "package:flutter_app/models/layout/base_goods_list_model.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";

class GoodsList extends StatefulWidget {
	final GoodsListModel model;

	GoodsList({Key key, @required this.model}) : super(key: key);

	@override
	State<StatefulWidget> createState() => GoodsListState();
}

class GoodsListState extends State<GoodsList> with LayoutBehaviorsMixin implements ListLayout {
	int _page;
	List _goodsList;
	bool _isShowLoading;
	bool _isReachBottom;
	bool _isGoodsListReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		print("goodsList initState");
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
		baseGoodsListModel.type = widget.model.type;
		baseGoodsListModel.goodsStyle = widget.model.goodsStyle;
		baseGoodsListModel.pageMargin = widget.model.pageMargin;
		baseGoodsListModel.goodsMargin = widget.model.goodsMargin;
		baseGoodsListModel.borderRadius = widget.model.borderRadius;
		baseGoodsListModel.pictureScale = widget.model.pictureScale;
		baseGoodsListModel.bold = widget.model.bold;
		baseGoodsListModel.textAlign = widget.model.textAlign;
		baseGoodsListModel.isShowGoodsName = widget.model.isShowGoodsName;
		baseGoodsListModel.isShowSubTitle = widget.model.isShowSubTitle;
		baseGoodsListModel.isShowPrice = widget.model.isShowPrice;
		baseGoodsListModel.btn = widget.model.btn;
		baseGoodsListModel.btnTitle = widget.model.btnTitle;
		baseGoodsListModel.corner = widget.model.corner;
		baseGoodsListModel.cornerWidth = widget.model.cornerWidth;
		baseGoodsListModel.cornerHeight = widget.model.cornerHeight;
		baseGoodsListModel.goodsList = this._goodsList;
		baseGoodsListModel.isShowLoading = this._isShowLoading;
		baseGoodsListModel.isReachBottom = this._isGoodsListReachBottom;
		return Offstage(
			offstage: !widget.model.isShow,
			child: BaseGoodsList(baseGoodsListModel)
		);
	}

	void _getGoodsList(int page) async {
		List<GoodsModel> goodsList = await GoodsController.getGoodsList(widget.model.src, page, widget.model.pageSize);
		if (goodsList == null) {
			return;
		}
		this._page = page;
		if (goodsList.length == widget.model.pageSize) {
			this._page++;
		}
		this.setState(() {
			if (page == 1) {
				this._goodsList = goodsList;
			} else {
				this._goodsList.addAll(goodsList);
			}
			this._isShowLoading = !widget.model.isLoadingControlByPage || widget.model.type == 6;
			this._isGoodsListReachBottom = goodsList.length < widget.model.pageSize;
		});
		ListLayoutNotification(message: ListLayoutNotification.MESSAGE_LOADED).dispatch(this.context);
	}

	@override
	void onReachBottom() {
		if (this._isGoodsListReachBottom) {
			return;
		}
		this._getGoodsList(this._page);
	}
}
