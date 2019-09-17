import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../../common/utils.dart';
import '../../components/layout/base_goods_list.dart';
import '../../components/layout/layout_behaviors_mixin.dart';
import '../../components/layout/list_layout.dart';
import '../../components/layout/list_layout_event.dart';
import '../../controllers/goods_controller.dart';
import '../../models/goods_model.dart';
import '../../models/layout/base_goods_list_model.dart';
import '../../models/layout/goods_list_model.dart';

class GoodsList extends StatefulWidget {
	final GoodsListModel model;
	final Function eventListener;

	GoodsList({Key key, @required this.model, this.eventListener}) : super(key: key);

	@override
	State<StatefulWidget> createState() => GoodsListState();
}

class GoodsListState extends State<GoodsList> with LayoutBehaviorsMixin implements ListLayout {
	static final Logger logger = Logger("GoodsListState");
	GoodsListModel _model;
	int _page;
	List _goodsList;
	bool _isShowLoading;
	bool _isReachBottom;
	bool _isGoodsListReachBottom;

	bool get isReachBottom => this._isReachBottom;

	@override
	void initState() {
		logger.info("goodsList initState");
		super.initState();
		this._model = widget.model;
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
		baseGoodsListModel.type = this._model.type;
		baseGoodsListModel.goodsStyle = this._model.goodsStyle;
		baseGoodsListModel.pageMargin = this._model.pageMargin;
		baseGoodsListModel.goodsMargin = this._model.goodsMargin;
		baseGoodsListModel.borderRadius = this._model.borderRadius;
		baseGoodsListModel.pictureScale = this._model.pictureScale;
		baseGoodsListModel.bold = this._model.bold;
		baseGoodsListModel.textAlign = this._model.textAlign;
		baseGoodsListModel.isShowGoodsName = this._model.isShowGoodsName;
		baseGoodsListModel.isShowSubTitle = this._model.isShowSubTitle;
		baseGoodsListModel.isShowPrice = this._model.isShowPrice;
		baseGoodsListModel.btn = this._model.btn;
		baseGoodsListModel.btnTitle = this._model.btnTitle;
		baseGoodsListModel.corner = this._model.corner;
		baseGoodsListModel.cornerWidth = this._model.cornerWidth;
		baseGoodsListModel.cornerHeight = this._model.cornerHeight;
		baseGoodsListModel.goodsList = this._goodsList;
		baseGoodsListModel.isShowLoading = this._isShowLoading;
		baseGoodsListModel.isReachBottom = this._isGoodsListReachBottom;
		return Offstage(
			offstage: !this._model.isShow,
			child: BaseGoodsList(baseGoodsListModel)
		);
	}

	void _getGoodsList(int page) async {
		List<GoodsModel> goodsList = await GoodsController.getGoodsList(this._model.src, page, this._model.pageSize);
		if (goodsList == null) {
			return;
		}
		this._page = page;
		if (goodsList.length == this._model.pageSize) {
			this._page++;
		}
		this._isShowLoading = !this._model.isLoadingControlByPage || this._model.type == 6;
		this._isGoodsListReachBottom = goodsList.length < this._model.pageSize;
		this._isReachBottom = this._isGoodsListReachBottom;
		if (widget.eventListener != null) {
			widget.eventListener(ListLayoutEvent.LOADED, widget.key);
			if (this._isGoodsListReachBottom) {
				widget.eventListener(ListLayoutEvent.REACH_BOTTOM, widget.key);
			}
		}
		this.setState(() {
			if (page == 1) {
				this._goodsList = goodsList;
			} else {
				this._goodsList.addAll(goodsList);
			}
		});
	}

	@override
	void onReachBottom() {
		if (this._isGoodsListReachBottom) {
			return;
		}
		this._getGoodsList(this._page);
	}

	void show() {
		this.setState(() => this._model.isShow = true);
	}

	void hide() {
		this.setState(() => this._model.isShow = false);
	}
}
