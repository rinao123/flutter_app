import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/utils.dart';
import '../../models/layout/search_model.dart';

class Search extends StatefulWidget {
	final SearchModel model;

	Search({@required this.model});

	@override
	State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
	SearchModel _model;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			height: Utils.px2dp(80),
			color: Utils.getColorFromString("#F4F5F6"),
				child: Center(
				child: ClipRRect(
				borderRadius: BorderRadius.circular(Utils.px2dp(8)),
					child: Container(
						width: Utils.px2dp(710),
						height: Utils.px2dp(60),
						color: Utils.getColorFromString("#ffffff"),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								Padding(padding: EdgeInsets.only(right: Utils.px2dp(16))),
								Image.asset(
									"assets/images/search_icon.png",
									width: Utils.px2dp(26),
									height: Utils.px2dp(26)
								),
								Padding(padding: EdgeInsets.only(right: Utils.px2dp(11))),
								Container(
									width: Utils.px2dp(570),
									child: TextField(
										style: TextStyle(
											fontSize: Utils.px2dp(24),
											color: Utils.getColorFromString("#333333")
										),
										decoration: InputDecoration(
											hintText: this._model.title,
											hintStyle: TextStyle(
												color: Utils.getColorFromString("rgba(51, 51, 51, 0.6)")
											),
											border: InputBorder.none,
											contentPadding: EdgeInsets.symmetric(vertical: 0)
										)
									)
								)
							]
						)
					)
				)
			)
		);
  	}

	void show() {
		this.setState(() => this._model.isShow = true);
	}

	void hide() {
		this.setState(() => this._model.isShow = false);
	}
}
