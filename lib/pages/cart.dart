import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _CartState();
	}
}

class _CartState extends State<Cart> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.white,
				brightness: Brightness.light,
				title: Text(
					"购物袋",
					style: TextStyle(color: Colors.black)
				),
			),
			body: CustomScrollView(
				slivers: <Widget>[
					SliverToBoxAdapter(
						child: Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg")
					),
					SliverPersistentHeader(delegate: DemoHeader(), pinned: true),
					SliverToBoxAdapter(child: Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg")),
					SliverPersistentHeader(delegate: DemoHeader(), pinned: true),
					SliverList(
						delegate: SliverChildListDelegate([
							Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg"),
							Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg"),
							Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg"),
							Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg"),
							Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg")
						])
					)
				]
			)
		);
	}
}

class DemoHeader extends SliverPersistentHeaderDelegate {
	@override
	Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
		return Container(
				color: Colors.pink,
				alignment: Alignment.center,
				child: Text('我是一个头部部件', style: TextStyle(color: Colors.white, fontSize: 30.0)));
	} // 头部展示内容

	@override
	double get maxExtent => 100.0; // 最大高度

	@override
	double get minExtent => 100.0; // 最小高度

	@override
	bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false; // 因为所有的内容都是固定的，所以不需要更新
}
