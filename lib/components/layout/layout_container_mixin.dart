import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../../components/layout/carousel.dart';
import '../../components/layout/goods_list.dart';
import '../../components/layout/icons.dart';
import '../../components/layout/img1.dart';
import '../../components/layout/search.dart';
import '../../components/layout/tabs_view.dart';
import '../../controllers/site_controller.dart';
import '../../models/layout/base_model.dart';
import '../../models/layout/carousel_model.dart';
import '../../models/layout/goods_list_model.dart';
import '../../models/layout/icons_model.dart';
import '../../models/layout/img1_model.dart';
import '../../models/layout/layout_model.dart';
import '../../models/layout/list_model.dart';
import '../../models/layout/search_model.dart';
import '../../models/layout/tabs_view_model.dart';

class LayoutContainerMixin {
	static final Logger logger = Logger("LayoutContainerMixin");
	bool isChild;
	State state;
	List<Map> items;

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