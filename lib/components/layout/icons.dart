import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/layout/icons_model.dart";

class Icons extends StatefulWidget {

	final IconsModel _iconsModel;

	Icons(this._iconsModel);

	@override
	State<StatefulWidget> createState() {
		return _IconsState(this._iconsModel);
	}
}

class _IconsState extends State<Icons> with LayoutBehaviors {
	IconsModel _iconsModel;

	_IconsState(this._iconsModel);

	@override
	Widget build(BuildContext context) {
		return Container(
			color: Utils.getColorFromString("#FFFFFF"),
			child: Row(
				children: <Widget>[
					Padding(padding: EdgeInsets.only(right: Utils.px2dp(20))),
					Column(
						children: <Widget>[
							Padding(padding: EdgeInsets.only(top: Utils.px2dp(20))),
							Container(
								width: Utils.px2dp(730),
								child: Wrap(
									children: this._buildItems()
								)
							)
						]
					)
				]
			)
		);
	}

	List<Widget> _buildItems() {
		List<Widget> items = [];
		for (IconModel iconModel in this._iconsModel.items) {
			Widget item  = this._buildItem(iconModel);
			items.add(item);
		}
		return items;
	}

	Widget _buildItem(IconModel iconModel) {
		return Container(
			width: Utils.px2dp(710 / this._iconsModel.numPerLine),
			height: Utils.px2dp(146),
			child: InkWell(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						ClipOval(
							child: FadeInImage.assetNetwork(
								image: iconModel.img,
								placeholder: "assets/images/loading.gif",
								width: Utils.px2dp(100),
								height: Utils.px2dp(100)
							)
						),
						Padding(padding: EdgeInsets.only(top: Utils.px2dp(10))),
						Text(
							iconModel.title,
							style: TextStyle(
								fontSize: Utils.px2dp(22),
								color: Utils.getColorFromString("#333333")
							)
						)
					]
				),
				onTap: () {
					this.onTap(context, iconModel);
				}
			)
		);
	}
}
