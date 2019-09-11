import "package:flutter/material.dart";
import 'package:flutter/src/rendering/sliver_multi_box_adaptor.dart';
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import 'package:flutter_app/components/notifications/list_layout_notification.dart';

class Cart extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _CartState();
	}
}

class _CartState extends State<Cart> {
	@override
	Widget build(BuildContext context) {
		return NotificationListener<ListLayoutNotification>(
			onNotification: (ListLayoutNotification notification) {
				print("onListLayoutNotification");
				print(notification);
				return true;
			},
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: Colors.white,
					brightness: Brightness.light,
					title: Text(
						"购物袋",
						style: TextStyle(color: Colors.black)
					),
				),
				body:  GestureDetector(
					child: Container(
						color: Colors.pink,
						width: Utils.px2dp(750),
						height: Utils.px2dp(100),
					),
					onTap: () => ListLayoutNotification(message: ListLayoutNotification.MESSAGE_LOADED).dispatch(context)
				)
			)
		);
	}
}

