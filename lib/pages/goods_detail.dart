import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../common/utils.dart';
import '../components/swiper.dart';
import '../controllers/goods_controller.dart';
import '../models/goods_model.dart';
import '../models/theme_model.dart';
import '../provider/theme_provider.dart';

class GoodsDetail extends StatefulWidget {
	final int id;

	GoodsDetail(this.id);

	@override
	State<StatefulWidget> createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
	GoodsModel _goods;

	@override
	void initState() {
		super.initState();
		this._getGoodsDetail();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Utils.getColorFromString("#f5f5f5"),
			body: CustomScrollView(
				slivers: <Widget>[
					this._buildHeader(context),
					this._buildBody(context)
				]
			)
		);
	}

	Widget _buildHeader(BuildContext context) {
		return SliverPersistentHeader(
			pinned: true,
			delegate: _Header(
				minHeight: Utils.getStatusBarHeight(context) + 56,
				maxHeight: Utils.px2dp(750),
				child: this._buildSwiper(context)
			)
		);
	}

	Widget _buildSwiper(BuildContext context) {
		if (this._goods == null) {
			return Container(height: Utils.px2dp(750));
		} else {
			return Container(
				height: Utils.px2dp(750),
				child: Swiper(
					circular: true,
					children: this._goods.imgArray.map((item) {
						return Image.network(item, fit: BoxFit.cover);
					}).toList()
				)
			);
		}
	}

	Widget _buildBody(BuildContext context) {
		if (this._goods == null) {
			return SliverToBoxAdapter(child: Container(height: Utils.px2dp(750)));
		} else {
			return SliverToBoxAdapter(
				child: Column(
					children: <Widget>[
						this._buildDescription(context)
					]
				),
			);
		}
	}
	
	Widget _buildDescription(BuildContext context) {
		return Container(
			margin: EdgeInsets.only(top: Utils.px2dp(20)),
			child: Html(
				backgroundColor: Utils.getColorFromString("#ffffff"),
				defaultTextStyle: TextStyle(fontSize: Utils.px2dp(32)),
				data: this._goods.description
			)
		);
	}

	void _getGoodsDetail() async {
		GoodsModel goods = await GoodsController.getGoodsDetail(widget.id);
		this.setState(() => this._goods = goods);
	}
}

class _Header extends SliverPersistentHeaderDelegate {
	final double minHeight;
	final double maxHeight;
	final Widget child;

	_Header({this.minHeight: 0, this.maxHeight: 0, @required this.child});

	@override
	double get minExtent => this.minHeight;

	@override
	double get maxExtent => max(this.maxHeight, this.minHeight);

	@override
	bool shouldRebuild(_Header oldDelegate) {
		return this.minHeight != oldDelegate.minHeight || this.maxHeight != oldDelegate.maxHeight || this.child != oldDelegate.child;
	}

	@override
	Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
		return Stack(
			children: <Widget>[
				child,
				this._buildAppBar(context, shrinkOffset)
			]
		);
	}

	Widget _buildAppBar(BuildContext context, double shrinkOffset) {
		ThemeModel themeModel = Provider.of<ThemeProvider>(context).getThemeModel();
		double statusBarHeight = Utils.getStatusBarHeight(context);
		Color color = Utils.getColorFromString(themeModel.mainColor);
		int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
		color = color.withAlpha(alpha);
		SystemUiOverlayStyle systemUiOverlayStyle;
		if (shrinkOffset <= statusBarHeight) {
			systemUiOverlayStyle = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark);
		} else {
			systemUiOverlayStyle = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);
		}
		return Positioned(
			top: 0,
			left: 0,
			right: 0,
			child: AnnotatedRegion<SystemUiOverlayStyle>(
				value: systemUiOverlayStyle,
				child: Container(
					color: color,
					child: Column(
						children: <Widget>[
							Container(height: statusBarHeight),
							Container(
								height: this.minHeight - statusBarHeight,
								child: Row(
									children: <Widget>[
										this._buildBackButton(context, shrinkOffset)
									]
								)
							)
						]
					)
				)
			)
		);
	}

	Widget _buildBackButton(BuildContext context, double shrinkOffset) {
		double offset = (shrinkOffset / (this.maxExtent - this.minExtent)).clamp(0.0, 1.0);
		print(offset);
		if (offset > 0.5) {
			double opacity = (offset - 0.5) * 2;
			return Opacity(
				opacity: opacity,
				child: BackButton(color: Utils.getColorFromString("#ffffff"))
			);
		} else {
			double opacity = (0.5 - offset) * 2;
			return Opacity(
				opacity: opacity,
				child: GestureDetector(
					child: Container(
						width: Utils.px2dp(100),
						height: Utils.px2dp(100),
						child: Center(
							child: Container(
								decoration: BoxDecoration(
									color: Utils.getColorFromString("#666666"),
									shape: BoxShape.circle
								),
								width: Utils.px2dp(60),
								height: Utils.px2dp(60)
							)
						)
					),
					onTap: () => Navigator.maybePop(context)
				)
			);
		}
	}
}
