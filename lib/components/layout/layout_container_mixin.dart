import "package:flutter/widgets.dart";
import "package:flutter_app/components/layout/carousel.dart";
import "package:flutter_app/components/layout/goods_list.dart";
import "package:flutter_app/components/layout/icons.dart";
import "package:flutter_app/components/layout/img1.dart";
import "package:flutter_app/components/layout/list_layout.dart";
import "package:flutter_app/components/layout/search.dart";
import "package:flutter_app/components/layout/tabs_view.dart";
import "package:flutter_app/components/loading.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/carousel_model.dart";
import "package:flutter_app/models/layout/goods_list_model.dart";
import "package:flutter_app/models/layout/icons_model.dart";
import "package:flutter_app/models/layout/img1_model.dart";
import "package:flutter_app/models/layout/layout_model.dart";
import "package:flutter_app/models/layout/list_model.dart";
import "package:flutter_app/models/layout/search_model.dart";
import "package:flutter_app/models/layout/tabs_view_model.dart";

class LayoutContainerMixin {
	bool isChild;
	State state;
	List<Map> items;
	bool isLoading;

	Future<LayoutModel> getLayouts(String code) async {
		LayoutModel layoutModel = await SiteController.getLayoutByCode(code);
		if (layoutModel == null) {
			return null;
		}
		bool hasList = false;
		for (BaseModel module in layoutModel.modules) {
			module.isShow = !hasList;
			if (module is ListModel) {
				hasList = true;
			}
		}
		return layoutModel;
	}

	List<Map> getLayoutWidgets(List<BaseModel> models) {
		List<Map> items = [];
		for (BaseModel model in models) {
			if (!model.isShow) {
				break;
			}
			Map item = this.getLayoutWidget(model);
			if (item != null) {
				items.add(item);
			}
		}
		return items;
	}

	Map getLayoutWidget(BaseModel model) {
		switch (model.runtimeType) {
			case CarouselModel:
				return {"key": null, "widget": Carousel(model: model)};
			case Img1Model:
				return {"key": null, "widget": Img1(model: model)};
			case IconsModel:
				return {"key": null, "widget": Icons(model: model)};
			case GoodsListModel:
				GlobalKey<GoodsListState> key = GlobalKey<GoodsListState>();
				GoodsListModel goodsListModel = model as GoodsListModel;
				goodsListModel.isLoadingControlByPage = true;
				return {"key": key, "widget": GoodsList(key: key, model: model, eventListener: this.onListEvent)};
			case SearchModel:
				return {"key": null, "widget": Search(model: model)};
			case TabsViewModel:
				GlobalKey<TabsViewState> key = GlobalKey<TabsViewState>();
				return {"key": key, "widget": TabsView(key: key, model: model, eventListener: this.onListEvent)};
			default:
				print("_buildBodyItem unknown module");
				return null;
		}
	}

	void onListEvent(int event, Key key) {

	}

	void showLoading() {
		this.isLoading = true;
		for (Map item in this.items) {
			if (item["key"] != null && item["widget"] is Loading) {
				item["key"].currentState.show();
				break;
			}
		}
	}

	void hideLoading() {
		this.isLoading = false;
		for (Map item in this.items) {
			if (item["key"] != null && item["widget"] is Loading && item["key"].currentState != null) {
				item["key"].currentState.hide();
				break;
			}
		}
	}


}