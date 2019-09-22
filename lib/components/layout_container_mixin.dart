import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'carousel.dart';
import 'goods_list.dart';
import 'icons.dart';
import 'img1.dart';
import 'search.dart';
import 'tabs_view.dart';
import '../controllers/site_controller.dart';
import 'package:flutter_app/models/base_model.dart';
import 'package:flutter_app/models/carousel_model.dart';
import 'package:flutter_app/models/goods_list_model.dart';
import 'package:flutter_app/models/icons_model.dart';
import 'package:flutter_app/models/img1_model.dart';
import 'package:flutter_app/models/layout_model.dart';
import 'package:flutter_app/models/list_model.dart';
import 'package:flutter_app/models/search_model.dart';
import 'package:flutter_app/models/tabs_view_model.dart';

class LayoutContainerMixin {
	static final Logger logger = Logger("LayoutContainerMixin");

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
				GlobalKey<CarouselState> key = GlobalKey<CarouselState>();
				return {"key": key, "widget": Carousel(model: model)};
			case Img1Model:
				GlobalKey<Img1State> key = GlobalKey<Img1State>();
				return {"key": key, "widget": Img1(key: key, model: model)};
			case IconsModel:
				GlobalKey<IconsState> key = GlobalKey<IconsState>();
				return {"key": key, "widget": Icons(model: model)};
			case GoodsListModel:
				GlobalKey<GoodsListState> key = GlobalKey<GoodsListState>();
				GoodsListModel goodsListModel = model as GoodsListModel;
				goodsListModel.isLoadingControlByPage = true;
				return {"key": key, "widget": GoodsList(key: key, model: model, eventListener: this.onListEvent)};
			case SearchModel:
				GlobalKey<SearchState> key = GlobalKey<SearchState>();
				return {"key": key, "widget": Search(model: model)};
			case TabsViewModel:
				GlobalKey<TabsViewState> key = GlobalKey<TabsViewState>();
				return {"key": key, "widget": TabsView(key: key, model: model, eventListener: this.onListEvent)};
			default:
				logger.warning("getLayoutWidget unknown module");
				return null;
		}
	}

	void onListEvent(int event, Key key) {

	}
}