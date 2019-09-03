import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout/carousel.dart";
import "package:flutter_app/components/layout/goods_list.dart";
import "package:flutter_app/components/layout/icons.dart" as icons;
import "package:flutter_app/components/layout/img1.dart";
import "package:flutter_app/components/layout/search.dart";
import "package:flutter_app/components/layout/tabs_view.dart";
import "package:flutter_app/models/layout/base_model.dart";

class Layout extends StatefulWidget {

	final List<BaseModel> _modules;

	Layout(this._modules);

	@override
	State<StatefulWidget> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

	@override
	Widget build(BuildContext context) {
		return Column(
			children: this._buildBodyItems()
		);
	}

	List<Widget> _buildBodyItems() {
		List<Widget> items = [];
		for (BaseModel module in widget._modules) {
			Widget item = this._buildBodyItem(module);
			items.add(item);
		}
		return items;
	}

	Widget _buildBodyItem(BaseModel module) {
		switch (module.runtimeType.toString()) {
			case "CarouselModel":
				return Carousel(module);
			case "Img1Model":
				return Img1(module);
			case "IconsModel":
				return icons.Icons(module);
			case "GoodsListModel":
				return GoodsList(module);
			case "SearchModel":
				return Search(module);
			case "TabsViewModel":
				return TabsView(module);
			default:
				print("_buildBodyItem unknown module");
				return null;
		}
	}
}
