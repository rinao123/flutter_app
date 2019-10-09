import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/utils.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
	List<String> items;
	RefreshController _refreshController;
	TabController _controller;

	@override
	void initState() {
		super.initState();
		this.items = ["首页", "购物袋", "我的"];
		this._refreshController = RefreshController();
		this._controller = TabController(
			length: this.items.length,
			vsync: this
		);
		this._controller.addListener(() {
			if (this._controller.indexIsChanging) {
				print("indexIsChanging");
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		double tabWidth = 750 / items.length;
		return Scaffold(
			body: SmartRefresher(
				controller: this._refreshController,
				child: CustomScrollView(
					slivers: <Widget>[
						SliverAppBar(
							elevation: 0,
							backgroundColor: Colors.white,
							brightness: Brightness.light,
							title: Text(
								"购物袋",
								style: TextStyle(color: Colors.black)
							)
						),
						SliverStickyHeader(
							header: Container(
								height: Utils.px2dp(60),
								decoration: BoxDecoration(
									color: Utils.getColorFromString("#ffffff"),
									border: Border(bottom: BorderSide(color: Utils.getColorFromString("#f1f1f1")))
								),
								child: TabBar(
									controller: this._controller,
									isScrollable: true,
									unselectedLabelStyle: TextStyle(fontSize: Utils.px2dp(28, isText: true, context: context)),
									unselectedLabelColor: Utils.getColorFromString("#333333"),
									labelStyle: TextStyle(fontSize: Utils.px2dp(30, isText: true, context: context), fontWeight: FontWeight.bold),
									labelColor: Utils.getColorFromString("#FC6D6E"),
									labelPadding: EdgeInsets.all(0),
									indicator: UnderlineTabIndicator(
											borderSide: BorderSide(width: Utils.px2dp(6), color: Utils.getColorFromString("#FC6D6E")),
											insets: EdgeInsets.symmetric(horizontal: Utils.px2dp((tabWidth - 32) / 2))
									),
									tabs: this.items.map((item) {
										return Tab(
											child: Container(
												width: Utils.px2dp(tabWidth),
												child: Center(
													child: Text(item)
												)
											)
										);
									}).toList()
								)
							),
							sliver: SliverToBoxAdapter(child: Container())
						)
					]
				)
			)
		);
	}
}
