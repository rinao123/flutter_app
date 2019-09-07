import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/page_status.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/layout_model.dart";

class LayoutPage extends StatefulWidget {

	final String code;

	LayoutPage(this.code);

	@override
	State<StatefulWidget> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
	LayoutModel _layoutModel;
	Layout _layout;
	GlobalKey<LayoutState> _layoutStateKey;

	@override
	void initState() {
		super.initState();
		this._getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		if (this._layoutModel == null) {
			return Scaffold(
				appBar: AppBar(
					backgroundColor: Utils.getColorFromString("#ffffff"),
					brightness: Brightness.light,
          			iconTheme: IconThemeData(color: Colors.white)
				),
				body: PageStatus()
			);
		}
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Utils.getColorFromString(this._layoutModel.backgroundColor),
				brightness: Brightness.light,
				iconTheme: IconThemeData(color: Colors.black),
				title: Text(
					this._layoutModel.title,
					style: TextStyle(color: Utils.getColorFromString(this._layoutModel.frontColor))
				),
			),
			body: this._buildBody()
		);
	}

	Widget _buildBody() {
		this._layoutStateKey = GlobalKey<LayoutState>();
		this._layout = Layout(this._layoutModel.modules, key: this._layoutStateKey);
		return Container(
			color: Utils.getColorFromString("#F5F5F5"),
			child: RefreshIndicator(
				onRefresh: this._onRefresh,
				child: this._layout
			)
		);
	}

	Future<void> _onRefresh() async {
		this.setState(() => this._layoutModel = null);
		this._getLayouts();
	}

	void _getLayouts() async {
		LayoutModel layoutModel = await SiteController.getLayoutByCode(widget.code);
		if (layoutModel == null) {
			return;
		}
		this.setState(() => this._layoutModel = layoutModel);
	}
}
