import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

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
			body:ListView.builder(
				itemCount: 10,
				itemBuilder: (context, index) {
					if (index == 5) {
						return ListView.builder(
							shrinkWrap: true,
							physics: NeverScrollableScrollPhysics(),
							itemCount: 10,
							itemBuilder: (context, index) {
								return Image(
									image: NetworkImage("https://image.jielong.iyunlai.cn/product/main/a889a3bffe9c899f715c2c145f7115166b07b30d.png")
								);
							}
						);
					} else {
						return Image(
							image: NetworkImage("https://image.jielong.iyunlai.cn/product/detail/e5c6031c76f9528658707d9762bb6c2d.jpg")
						);
					}
				}
			)
		);
	}
}
