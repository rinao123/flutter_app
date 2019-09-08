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
		return Scaffold(
			body: RefreshIndicator(
				child: CustomScrollView(
					slivers: <Widget>[
						this._buildHeader(),
						this._buildBody()
					]
				),
				onRefresh: this._onRefresh
			)
		);
	}

	Widget _buildHeader() {
		String backgroundColor = this._layoutModel == null ? "#ffffff" : this._layoutModel.backgroundColor;
		String titleColor = this._layoutModel == null ? "#000000" : this._layoutModel.frontColor;
		String title = this._layoutModel == null ? "" : this._layoutModel.title;
		return SliverAppBar(
			backgroundColor: Utils.getColorFromString(backgroundColor),
			brightness: Brightness.light,
			iconTheme: IconThemeData(color: Colors.black),
			title: Text(
				title,
				style: TextStyle(color: Utils.getColorFromString(titleColor))
			),
			pinned: true
		);
	}

	Widget _buildBody() {
		this._layoutStateKey = GlobalKey<LayoutState>();
		this._layout = Layout(this._layoutModel.modules, key: this._layoutStateKey);
		return SliverToBoxAdapter(
			child: this._layout
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
