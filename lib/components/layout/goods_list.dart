import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/navigation_helper.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/controllers/goods_controller.dart";
import "package:flutter_app/models/goods.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";

class GoodsList extends StatefulWidget {
	final GoodsListModel _goodsListModel;

	GoodsList(this._goodsListModel);

	@override
	State<StatefulWidget> createState() {
		return _GoodsListState(this._goodsListModel);
	}
}

class _GoodsListState extends State<GoodsList> with LayoutBehaviors, AutomaticKeepAliveClientMixin<GoodsList> {
	GoodsListModel _goodsListModel;
	List _goodsList;
	int _page;
	int _pageSize;

	_GoodsListState(this._goodsListModel);

	@override
	void initState() {
		super.initState();
		this._page = 1;
		this._pageSize = 10;
		this.getGoodsList();
	}

	@override
	Widget build(BuildContext context) {
		if (this._goodsList == null) {
			return Container(
				width: Utils.px2dp(750),
				height: Utils.px2dp(100),
				child: Center(
					child: Text("正在加载中…")
				)
			);
		}
		if (this._goodsListModel.type == 1) {
			return this._buildGoodsList1();
		} else if (this._goodsListModel.type == 2) {
			return this._buildGoodsList2();
		} else if (this._goodsListModel.type == 3) {
			return this._buildGoodsList3();
		} else {
			print("unknown goodsList type");
			return Container();
		}
	}

	Widget _buildGoodsList1() {
		return Container();
	}

	Widget _buildGoodsList2() {
		return Container(
			width: Utils.px2dp(750),
			child: Center(
				child: Wrap(
					children: this._buildGoodsItems2()
				)
			)
		);
	}

	List<Widget> _buildGoodsItems2() {
		List<Widget> items = [];
		for (int i = 0; i < this._goodsList.length; i++) {
			items.add(Column(
				children: this._buildGoodsItem2(i),
			));
			if (i % 2 == 0) {
				items.add(Padding(padding: EdgeInsets.only(right: Utils.px2dp(10))));
			}
		}
		return items;
	}

	List<Widget> _buildGoodsItem2(index) {
		Goods goods = this._goodsList[index];
		List<Widget> items = [];
		items.add(InkWell(
			child: Container(
				width: Utils.px2dp(360),
				height: Utils.px2dp(556),
				color: Utils.getColorFromString("#ffffff"),
				child: Stack(
					children: <Widget>[
						this._buildPicture2(goods.picture),
						this._buildName2(goods.name),
						this._buildSales2(goods.sales),
						this._buildPrice2(goods)
					],
				)
			),
			onTap: () => NavigationHelper.navigateTo(context, "/pages/goods_detail/goods_detail?id=${goods.id}")
		));
		if ((this._goodsList.length % 2 == 0 && index < this._goodsList.length - 2) || (this._goodsList.length % 2 == 1 && index < this._goodsList.length - 1)) {
			items.add(Padding(padding: EdgeInsets.only(bottom: Utils.px2dp(10))));
		}
		return items;
	}

	Widget _buildPicture2(String picture) {
		return Positioned(
			top: 0,
			left: 0,
			child: FadeInImage.assetNetwork(
				image: picture,
				placeholder: "assets/images/loading.gif",
				width: Utils.px2dp(360),
				height: Utils.px2dp(360)
			),
		);
	}

	Widget _buildName2(String name) {
		return Positioned(
			top: Utils.px2dp(370),
			left: Utils.px2dp(10),
			child: Container(
				width: Utils.px2dp(340),
				child: Text(
					name,
					style: TextStyle(
						fontSize: Utils.px2dp(28),
						color: Utils.getColorFromString("#333333")
					),
					softWrap: true,
					maxLines: 2,
					overflow: TextOverflow.ellipsis,
				)
			)
		);
	}

	Widget _buildSales2(int sales) {
		return Positioned(
			top: Utils.px2dp(468),
			left: Utils.px2dp(10),
			child: Container(
				width: Utils.px2dp(340),
				child: Text(
					"已抢：$sales件",
					style: TextStyle(
						fontSize: Utils.px2dp(24),
						color: Utils.getColorFromString("#333333")
					)
				)
			)
		);
	}

	Widget _buildPrice2(Goods goods) {
		String price = goods.pintuanNum > 0 ? goods.pintuanPrice.amountAsString : goods.promotionPrice.amountAsString;
		return Positioned(
			top: Utils.px2dp(502),
			left: Utils.px2dp(10),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						"¥$price",
						style: TextStyle(
							fontSize: Utils.px2dp(32),
							fontWeight: FontWeight.bold,
							color: Utils.getColorFromString("#D4001A")
						)
					),
					Padding(padding: EdgeInsets.only(right: Utils.px2dp(10))),
					Container(
						width: Utils.px2dp(32),
						height: Utils.px2dp(28),
						decoration: BoxDecoration(
							color: Utils.getColorFromString("#2F2F2F"),
							borderRadius: BorderRadius.only(topLeft: Radius.circular(Utils.px2dp(4)), bottomLeft: Radius.circular(Utils.px2dp(4)))
						),
						child: Center(
							child: Text(
								"送",
								style: TextStyle(
									fontSize: Utils.px2dp(20),
									fontWeight: FontWeight.bold,
									color: Utils.getColorFromString("#FFFFFF")
								)
							)
						)
					),
					Container(
						height: Utils.px2dp(28),
						decoration: BoxDecoration(
							color: Utils.getColorFromString("#DFC77F"),
							borderRadius: BorderRadius.only(topRight: Radius.circular(Utils.px2dp(4)), bottomRight: Radius.circular(Utils.px2dp(4)))
						),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Padding(padding: EdgeInsets.only(right: Utils.px2dp(6))),
								Text(
									"${Utils.removeNumEndZero(goods.commission.amountAsString)}点",
									style: TextStyle(
										fontSize: Utils.px2dp(20),
										fontWeight: FontWeight.bold,
										color: Utils.getColorFromString("#2F2F2F")
									)
								),
								Padding(padding: EdgeInsets.only(right: Utils.px2dp(6))),
							]
						)
					)
				]
			)
		);
	}

	Widget _buildGoodsList3() {
		return Container();
	}

	void getGoodsList() async {
		List<Goods> goodsList = await GoodsController.getGoodsList(this._goodsListModel.src, this._page, this._pageSize);
		if (goodsList == null) {
			return;
		}
		this.setState(() => this._goodsList = goodsList);
	}

	@override
	bool get wantKeepAlive => true;
}
