import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../common/utils.dart";
import "../components/layout_behaviors_mixin.dart";
import "../models/goods_model.dart";
import "package:flutter_app/models/base_goods_list_model.dart";
import "../models/theme_model.dart";
import "../provider/theme_provider.dart";

import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:provider/provider.dart";

class BaseGoodsList extends StatelessWidget with LayoutBehaviorsMixin {
	final BaseGoodsListModel _baseGoodsListModel;

	BaseGoodsList(this._baseGoodsListModel);

	@override
	Widget build(BuildContext context) {
		int numPerLine = this._getNumPerLine(1);
		List<Widget> items = this._buildItems(context);
		return Container(
			margin: EdgeInsets.symmetric(horizontal: Utils.px2dp(this._baseGoodsListModel.pageMargin), vertical: Utils.px2dp(this._baseGoodsListModel.goodsMargin / 2)),
			child: StaggeredGridView.countBuilder(
				shrinkWrap: true,
				physics: NeverScrollableScrollPhysics(),
				crossAxisCount: numPerLine,
				itemCount: items.length,
				itemBuilder: (BuildContext context, int index) {
					return items[index];
				},
				staggeredTileBuilder: (int index) {
					int crossAxisCellCount = 1;
					if (this._baseGoodsListModel.type == 5 && index % 3 == 0) {
						crossAxisCellCount = 2;
					}
					return StaggeredTile.fit(crossAxisCellCount);
				},
				padding: EdgeInsets.all(0),
				mainAxisSpacing: Utils.px2dp(this._baseGoodsListModel.goodsMargin),
				crossAxisSpacing: Utils.px2dp(this._baseGoodsListModel.goodsMargin)
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
		Color backgroundColor = Utils.getColorFromString("#ffffff");
		List<BoxShadow> shadow = [];
		Border border;
		BorderRadius borderRadius = BorderRadius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius));
		if (this._baseGoodsListModel.goodsStyle == 2) {
			shadow = [
				BoxShadow(offset: Offset(0, Utils.px2dp(8)), blurRadius: Utils.px2dp(16), spreadRadius: 0, color: Utils.getColorFromString("rgba(0,0,0,0.08)"))
			];
		} else if (this._baseGoodsListModel.goodsStyle == 3) {
			border = Border.all(color: Utils.getColorFromString("#dfdfdf"));
		} else if (this._baseGoodsListModel.goodsStyle == 4) {
			backgroundColor = Colors.transparent;
		}
		Widget picture = this._buildPictureContainer(index);
		Widget goodsName;
		Widget subTitle;
		Widget bottom = this._buildBottom(context, index);
		if (this._baseGoodsListModel.isShowGoodsName) {
			goodsName = this._buildGoodsName(context, index);
		}
		if (this._baseGoodsListModel.isShowSubTitle) {
			subTitle = this._buildSubTile(context, index);
		}
		Widget child;
		if (this._baseGoodsListModel.type == 4) {
			List<Widget> children = [];
			if (goodsName != null) {
				children.add(goodsName);
			}
			if (subTitle != null) {
				children.add(subTitle);
			}
			child = Row(
				children: <Widget>[
					picture,
					Expanded(
						child: Container(
							margin: EdgeInsets.symmetric(horizontal: Utils.px2dp(10)),
							height: Utils.px2dp(290),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Column(children: children),
									bottom
								]
							)
						)
					)
				]
			);
		} else {
			List<Widget> children = [];
			children.add(picture);
			if (goodsName != null) {
				children.add(goodsName);
			}
			if (subTitle != null) {
				children.add(subTitle);
			}
			children.add(bottom);
			child = Column(children: children);
		}
		return Container(
			width: Utils.px2dp(width),
			decoration: BoxDecoration(
				color: backgroundColor,
				borderRadius: borderRadius,
				border: border,
				boxShadow: shadow
			),
			child: GestureDetector(
				child: child,
				onTap: () => this.onTap(context, link: "/pages/goods_detail/goods_detail?id=${goods.id}")
			)
		);
	}

	Widget _buildPictureContainer(int index) {
		return Container(
			child: Stack(
				children: <Widget>[
					this._buildPicture(index)
				]
			)
		);
	}

	Widget _buildPicture(int index) {
		double width = this._baseGoodsListModel.type == 4 ? 290 : this._getItemWidth(index);
		double height = this._baseGoodsListModel.type == 8 ? null : Utils.px2dp(width);
		BorderRadius borderRadius;
		if (this._baseGoodsListModel.type == 4) {
			borderRadius = BorderRadius.horizontal(left: Radius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius)));
		} else {
			borderRadius = BorderRadius.vertical(top: Radius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius)));
		}
		GoodsModel goods = this._baseGoodsListModel.goodsList[index];
		return ClipRRect(
			borderRadius: borderRadius,
			child: Image.network(
				goods.picture,
				width: Utils.px2dp(width),
				height: height,
				fit: BoxFit.cover
			)
		);
	}

	Widget _buildGoodsName(BuildContext context, int index) {
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
					fontSize: Utils.px2dp(28, isText: true, context: context),
					fontWeight: this._baseGoodsListModel.bold ? FontWeight.bold : FontWeight.normal,
					color: Utils.getColorFromString("#333333")
				)
			)
		);
	}

	Widget _buildSubTile(BuildContext context, int index) {
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
					fontSize: Utils.px2dp(28, isText: true, context: context),
					color: Utils.getColorFromString("#999999")
				)
			)
		);
	}

	Widget _buildBottom(BuildContext context, int index) {
		EdgeInsetsGeometry margin;
		double width;
		if (this._baseGoodsListModel.type == 7) {
			margin = EdgeInsets.only(top: Utils.px2dp(10), left: Utils.px2dp(16));
			width = Utils.px2dp(this._getItemWidth(index) - 16);
		} else {
			margin = EdgeInsets.symmetric(vertical: Utils.px2dp(10));
			width = Utils.px2dp(this._getItemWidth(index) - 32);
		}
		List<Widget> items = [];
		items.add(this._buildPrice(context, index));
		if (this._baseGoodsListModel.btn > 0) {
			items.add(this._buildBuyBtn(context, index));
		}
		return Container(
			margin: margin,
			width: width,
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
						fontSize: Utils.px2dp(32, isText: true, context: context),
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
		if (this._baseGoodsListModel.type == 7) {
			return this._buildBuyBtnType7(context, index);
		} else {
			ThemeModel themeModel = Provider.of<ThemeProvider>(context).getThemeModel();
			return Icon(IconData(0xe644, fontFamily: "iconfont"), color: Utils.getColorFromString(themeModel.mainColor), size: Utils.px2dp(44));
		}
	}

	Widget _buildBuyBtnType7(BuildContext context, int index) {
		return Container(
			width: Utils.px2dp(192),
			height: Utils.px2dp(76),
			decoration: BoxDecoration(
				color: Utils.getColorFromString("#ff0100"),
				borderRadius: BorderRadius.only(bottomRight: Radius.circular(Utils.px2dp(this._baseGoodsListModel.borderRadius)))
			),
			child: Center(
				child: Text(
					"我要抢购",
					style: TextStyle(
						fontSize: Utils.px2dp(28),
						color: Utils.getColorFromString("#ffffff"),
						fontWeight: FontWeight.bold
					)
				)
			)
		);
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