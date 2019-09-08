import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Member extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _MemberState();
	}
}

class _MemberState extends State<Member> {
	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				SliverToBoxAdapter(child: Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg")),
				SliverToBoxAdapter(child: Image.network("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg"))
			]
		);
	}
}
