import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/models/layout/icons_model.dart";

class Icons extends StatefulWidget {
	IconsModel _iconsModel;

	Icons(IconsModel iconsModel) {
		this._iconsModel = iconsModel;
	}

	@override
	State<StatefulWidget> createState() {
		return new _IconsState(this._iconsModel);
	}
}

class _IconsState extends State<Icons> with LayoutBehaviors {
	IconsModel _iconsModel;

	_IconsState(IconsModel iconsModel) {
		this._iconsModel = iconsModel;
	}

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.center,
			children: <Widget>[

			],
		);
	}
}
