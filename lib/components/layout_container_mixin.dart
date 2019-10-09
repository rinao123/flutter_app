import 'package:flutter/widgets.dart';

import 'package:logging/logging.dart';

import 'buoy.dart';
import 'carousel.dart';
import 'goods_list.dart';
import 'icons.dart';
import 'img1.dart';
import 'notice.dart';
import 'placeholder.dart' as PlaceHolder;
import 'rich_text.dart' as Html;
import 'search.dart';
import 'tabs_view.dart';
import '../controllers/site_controller.dart';
import '../models/base_model.dart';
import '../models/buoy_model.dart';
import '../models/carousel_model.dart';
import '../models/goods_list_model.dart';
import '../models/icons_model.dart';
import '../models/img1_model.dart';
import '../models/layout_model.dart';
import '../models/list_model.dart';
import '../models/notice_model.dart';
import '../models/placeholder_model.dart';
import '../models/rich_text_model.dart';
import '../models/search_model.dart';
import '../models/state_reference_model.dart';
import '../models/tabs_view_model.dart';

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

	List<StateReferenceModel> getLayoutWidgets(List<BaseModel> models) {
		List<StateReferenceModel> items = [];
		for (BaseModel model in models) {
			StateReferenceModel item = this.getLayoutWidget(model);
			if (item != null) {
				items.add(item);
			}
		}
		return items;
	}

	StateReferenceModel getLayoutWidget(BaseModel model) {
		StateReferenceModel stateReferenceModel = StateReferenceModel();
		switch (model.runtimeType) {
			case CarouselModel:
				GlobalKey<CarouselState> key = GlobalKey<CarouselState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Carousel(key: key, model: model);
				return stateReferenceModel;
			case Img1Model:
				GlobalKey<Img1State> key = GlobalKey<Img1State>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Img1(key: key, model: model);
				return stateReferenceModel;
			case IconsModel:
				GlobalKey<IconsState> key = GlobalKey<IconsState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Icons(key: key, model: model);
				return stateReferenceModel;
			case GoodsListModel:
				GoodsListModel goodsListModel = model as GoodsListModel;
				goodsListModel.isLoadingControlByPage = true;
				GlobalKey<GoodsListState> key = GlobalKey<GoodsListState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = GoodsList(key: key, model: model, eventListener: this.onListEvent);
				return stateReferenceModel;
			case SearchModel:
				GlobalKey<SearchState> key = GlobalKey<SearchState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Search(key: key, model: model);
				return stateReferenceModel;
			case TabsViewModel:
				GlobalKey<TabsViewState> key = GlobalKey<TabsViewState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = TabsView(key: key, model: model, eventListener: this.onListEvent);
				return stateReferenceModel;
			case RichTextModel:
				GlobalKey<Html.RichTextState> key = GlobalKey<Html.RichTextState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Html.RichText(key: key, model: model);
				return stateReferenceModel;
			case NoticeModel:
				GlobalKey<NoticeState> key = GlobalKey<NoticeState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Notice(key: key, model: model);
				return stateReferenceModel;
			case BuoyModel:
				GlobalKey<BuoyState> key = GlobalKey<BuoyState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = Buoy(key: key, model: model);
				return stateReferenceModel;
			case PlaceholderModel:
				GlobalKey<PlaceHolder.PlaceholderState> key = GlobalKey<PlaceHolder.PlaceholderState>();
				stateReferenceModel.key = key;
				stateReferenceModel.widget = PlaceHolder.Placeholder(key: key, model: model);
				return stateReferenceModel;
			default:
				logger.warning("getLayoutWidget unknown module");
				return null;
		}
	}

	void onListEvent(int event, Key key) {

	}
}