import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/carousel.dart";
import "package:flutter_app/components/layout/goods_list.dart";
import "package:flutter_app/components/page_status.dart";
import "package:flutter_app/components/layout/icons.dart" as icons;
import "package:flutter_app/components/layout/img1.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/layout_model.dart";

class Layout extends StatefulWidget {

	final String _code;

	Layout(this._code);

	@override
	State<StatefulWidget> createState() {
		return _LayoutState(this._code);
	}
}

class _LayoutState extends State<Layout> {
	String _code;
	LayoutModel _layoutModel;

	_LayoutState(String code) {
		this._code = code;
	}

	@override
	void initState() {
		super.initState();
		this.getLayouts();
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
		return Container(
			color: Utils.getColorFromString("#F5F5F5"),
			child: RefreshIndicator(
				onRefresh: this._onRefresh,
				child: ListView.builder(
					itemBuilder: this._buildBodyItem,
					itemCount: this._layoutModel.modules.length
				)
			)
		);
	}

	Widget _buildBodyItem(BuildContext context, int index) {
		BaseModel module = this._layoutModel.modules[index];
		switch (module.runtimeType.toString()) {
			case "CarouselModel":
				return Carousel(module);
			case "Img1Model":
				return Img1(module);
			case "IconsModel":
				return icons.Icons(module);
			case "GoodsListModel":
				return GoodsList(module);
			default:
				print("_buildBodyItem unknown module");
				return null;
		}
	}

	Future<void> _onRefresh() async {
		this.setState(() => this._layoutModel = null);
		this.getLayouts();
	}

	void getLayouts() async {
		LayoutModel layoutModel = await SiteController.getLayoutByCode(this._code);
		if (layoutModel == null) {
			return;
		}
		this.setState(() => this._layoutModel = layoutModel);
	}
}
