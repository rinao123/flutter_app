import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/goods_model.dart";
import "package:flutter_app/models/layout/base_goods_list_model.dart";
import "package:flutter_app/models/theme_model.dart";
import "package:flutter_app/provider/theme_provider.dart";
import "package:provider/provider.dart";

class BaseGoodsList extends StatelessWidget with LayoutBehaviors {
	final BaseGoodsListModel _baseGoodsListModel;

	BaseGoodsList(this._baseGoodsListModel);

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: EdgeInsets.symmetric(horizontal: Utils.px2dp(
				this._baseGoodsListModel.pageMargin)),
			child: Wrap(
				children: this._buildItems(context)
			)
		);
	}

	List<Widget> _buildItems(BuildContext context) {
		List<Widget> items = [];
		for (int i = 0; i < this._baseGoodsListModel.goodsList.length; i++) {
			Widget item = this._buildItem(context, i);
			items.add(item);
		}
		return items;
	}

	Widget _buildItem(BuildContext context, int index) {
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		double width = this._getItemWidth(index);
		double marginVertical = this._baseGoodsListModel.goodsMargin / 2;
		int numPerLine = this._getNumPerLine(index);
		int marginRight = 0;
		if (this._baseGoodsListModel.type == 5) {
			if (index % 3 == 1) {
				marginRight = this._baseGoodsListModel.goodsMargin;
			}
		} else {
			if (index % numPerLine < numPerLine - 1) {
				marginRight = this._baseGoodsListModel.goodsMargin;
			}
		}
		Color backgroundColor = this._baseGoodsListModel.goodsStyle == 4 ? Colors.transparent : Utils.getColorFromString("#ffffff");
		List<BoxShadow> shadow = [];
		if (this._baseGoodsListModel.goodsStyle == 4) {
			shadow = [
				BoxShadow(offset: Offset(0, Utils.px2dp(8)), blurRadius: Utils.px2dp(16), spreadRadius: 0, color: Utils.getColorFromString("rgba(0,0,0,0.8)"))
			];
		}
		List<Widget> items = [];
		items.add(this._buildPictureContainer(index));
		if (this._baseGoodsListModel.isShowGoodsName) {
			items.add(this._buildGoodsName(index));
		}
		if (this._baseGoodsListModel.isShowGoodsName) {
			items.add(this._buildSubTile(index));
		}
		items.add(this._buildBottom(context, index));
		print("/pages/goods_detail/goods_detail?id=${goods.id}");
		return Container(
			margin: EdgeInsets.only(top: Utils.px2dp(marginVertical), bottom: Utils.px2dp(marginVertical), right: Utils.px2dp(marginRight)),
			width: Utils.px2dp(width),
			decoration: BoxDecoration(
				color: backgroundColor,
				borderRadius: BorderRadius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius)),
				boxShadow: shadow
			),
			child: GestureDetector(
				child: Column(
					children: items
				)
			)
		);
	}

	Widget _buildPictureContainer(int index) {
		double width = this._getItemWidth(index);
		return Container(
			width: Utils.px2dp(width),
			height: Utils.px2dp(width),
			child: Stack(
				children: <Widget>[
					this._buildPicture(index)
				]
			)
		);
	}

	Widget _buildPicture(int index) {
		double width = this._getItemWidth(index);
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		return Positioned(
			top: 0,
			left: 0,
			child: Container(
				child: ClipRRect(
					borderRadius: BorderRadius.vertical(top: Radius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius))),
					child: Image(
						image: NetworkImage(goods.picture),
						width: Utils.px2dp(width),
						height: Utils.px2dp(width),
						fit: BoxFit.contain
					)
				)
			)
		);
	}

	Widget _buildGoodsName(int index) {
		double width = this._getItemWidth(index);
		int maxLines = 2;
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		return Container(
			margin: EdgeInsets.only(top: Utils.px2dp(10)),
			width: Utils.px2dp(width - 32),
			height: Utils.px2dp(40 * maxLines),
			child: Text(
				goods.name,
				textAlign: this._baseGoodsListModel.textAlign == "center" ? TextAlign.center : TextAlign.left,
				maxLines: maxLines,
				overflow: TextOverflow.ellipsis,
				style: TextStyle(
					fontSize: Utils.px2dp(28),
					fontWeight: this._baseGoodsListModel.bold ? FontWeight.bold : FontWeight.normal,
					color: Utils.getColorFromString("#333333")
				)
			)
		);
	}

	Widget _buildSubTile(int index) {
		double width = this._getItemWidth(index);
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		return Container(
			width: Utils.px2dp(width - 32),
			height: Utils.px2dp(40),
			child: Text(
				goods.subTitle,
				textAlign: this._baseGoodsListModel.textAlign == "center" ? TextAlign.center : TextAlign.left,
				overflow: TextOverflow.ellipsis,
				style: TextStyle(
					fontSize: Utils.px2dp(28),
					color: Utils.getColorFromString("#999999")
				)
			)
		);
	}

	Widget _buildBottom(BuildContext context, int index) {
		double width = this._getItemWidth(index);
		List<Widget> items = [];
		items.add(this._buildPrice(context, index));
		if (this._baseGoodsListModel.btn > 0) {
			items.add(this._buildBuyBtn(context, index));
		}
		return Container(
			margin: EdgeInsets.symmetric(vertical: Utils.px2dp(10)),
			width: Utils.px2dp(width - 32),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: items
			)
		);
	}

	Widget _buildPrice(BuildContext context, int index) {
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		ThemeModel themeModel = Provider.of<ThemeProvider>(context).getThemeModel();
		List<Widget> items = [];
		if (this._baseGoodsListModel.isShowPrice) {
			Widget price = Container(
				margin: EdgeInsets.only(right: Utils.px2dp(10)),
				child: Text(
					"¥${Utils.removeLastZero(goods.promotionPrice.amountAsString)}",
					style: TextStyle(
						fontSize: Utils.px2dp(32),
						fontWeight: this._baseGoodsListModel.bold ? FontWeight.bold : FontWeight.normal,
						color: Utils.getColorFromString(themeModel.mainColor)
					)
				)
			);
			items.add(price);
		}
		return Container(
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.end,
				children: items
			)
		);
	}

	Widget _buildBuyBtn(BuildContext context, int index) {
		ThemeModel themeModel = Provider.of<ThemeProvider>(context).getThemeModel();
		return Icon(IconData(0xe644, fontFamily: "iconfont"), color: Utils.getColorFromString(themeModel.mainColor), size: Utils.px2dp(44));
	}

	double _getItemWidth(int index) {
		double width = 0;
		int numPerLine = this._getNumPerLine(index);
		width = (Utils.DESIGN_WIDTH - this._baseGoodsListModel.pageMargin * 2 - this._baseGoodsListModel.goodsMargin * (numPerLine - 1)) / numPerLine;
		return width;
	}

	int _getNumPerLine(int index) {
		int numPerLine = 1;
		if (this._baseGoodsListModel.type == 1 || this._baseGoodsListModel.type == 4) {
			numPerLine = 1;
		} else if (this._baseGoodsListModel.type == 2 || this._baseGoodsListModel.type == 7 || this._baseGoodsListModel.type == 8) {
			numPerLine = 2;
		} else if (this._baseGoodsListModel.type == 3) {
			numPerLine = 3;
		} else if (this._baseGoodsListModel.type == 5 && index % 3 == 0) {
			numPerLine = 1;
		} else if (this._baseGoodsListModel.type == 5 && index % 3 > 0) {
			numPerLine = 2;
		}
		return numPerLine;
	}
}