import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout/carousel.dart";
import "package:flutter_app/components/layout/goods_list.dart";
import "package:flutter_app/components/layout/icons.dart" as icons;
import "package:flutter_app/components/layout/img1.dart";
import "package:flutter_app/components/layout/search.dart";
import "package:flutter_app/components/layout/tabs_view.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/carousel_model.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";
import "package:flutter_app/models/layout/icons_model.dart";
import "package:flutter_app/models/layout/img1_model.dart";
import "package:flutter_app/models/layout/search_model.dart";
import "package:flutter_app/models/layout/tabs_view_model.dart";

class Layout {
	final List<BaseModel> models;

	Layout({@required this.models});

	List<Map> getLayouts() {
		print("Layout getLayouts");
		List<Map> items = [];
		for (BaseModel model in this.models) {
			if (!model.isShow) {
				continue;
			}
			Map item = this._getItem(model);
			if (item != null) {
				items.add(item);
			}
		}
		return items;
	}

	Map _getItem(BaseModel model) {
		switch (model.runtimeType) {
			case CarouselModel:
				return {"key": null, "widget": Carousel(model: model)};
			case Img1Model:
				return {"key": null, "widget": Img1(model: model)};
			case IconsModel:
				return {"key": null, "widget": icons.Icons(model: model)};
			case GoodsListModel:
				GlobalKey<GoodsListState> key = GlobalKey<GoodsListState>();
				GoodsListModel goodsListModel = model as GoodsListModel;
				goodsListModel.isLoadingControlByPage = true;
				return {"key": key, "widget": GoodsList(key: key, model: model)};
			case SearchModel:
				return {"key": null, "widget": Search(model: model)};
			case TabsViewModel:
				GlobalKey<TabsViewState> key = GlobalKey<TabsViewState>();
				return {"key": key, "widget": TabsView(key: key, model: model)};
			default:
				print("_buildBodyItem unknown module");
				return null;
		}
	}
}
