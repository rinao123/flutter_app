import "package:flutter_app/models/layout/goods_list_model.dart";
import "package:flutter_app/models/layout/icons_model.dart";
import "package:flutter_app/models/layout/share_info_model.dart";
import "package:flutter_app/models/layout/base_model.dart";
import "package:flutter_app/models/layout/img1_model.dart";
import "package:flutter_app/models/layout/carousel_model.dart";
import "package:flutter_app/models/layout/search_model.dart";
import 'package:flutter_app/models/layout/tabs_view_model.dart';

class LayoutModel {
	String _backgroundColor;
	String _frontColor;
	String _title;
	ShareInfoModel _shareInfo;
	List<BaseModel> _modules;

	String get backgroundColor => this._backgroundColor;
	set backgroundColor(String backgroundColor) => this._backgroundColor = backgroundColor;

	String get frontColor => this._frontColor;
	set frontColor(String frontColor) => this._frontColor = frontColor;

	String get title => this._title;
	set title(String title) => this._title = title;

	ShareInfoModel get shareInfo => this._shareInfo;
	set shareInfo(ShareInfoModel shareInfo) => this._shareInfo = shareInfo;

	List<BaseModel> get modules => this._modules;
	set modules(List<BaseModel> modules) => this._modules = modules;

	static LayoutModel fromJson(Map<String, dynamic> json) {
		LayoutModel layoutModel = LayoutModel();
		layoutModel.backgroundColor = json["backgroundColor"];
		layoutModel.frontColor = json["frontColor"];
		layoutModel.title = json["title"];
		layoutModel.shareInfo = ShareInfoModel.fromJson(json["shareInfo"]);
		List<BaseModel> modules = [];
		for (Map<String, dynamic> item in json["layout"]) {
			BaseModel module = getModule(item);
			if (module != null) {
				modules.add(module);
			}
		}
		layoutModel.modules = modules;
		return layoutModel;
	}

	Map<String, dynamic> toJson(){
		List<Map<String, dynamic>> modules = [];
		for (BaseModel module in this._modules) {
			modules.add(module.toJson());
		}
		return {
			"backgroundColor": this.backgroundColor,
			"frontColor": this.frontColor,
			"title": this.title,
			"shareInfo": this.shareInfo.toJson(),
			"modules": modules.toString()
		};
	}

	static BaseModel getModule(Map<String, dynamic> item) {
		switch (item["module"]) {
			case "swiper":
				return CarouselModel.fromJson(item);
			case "img1":
				return Img1Model.fromJson(item);
			case "icons":
				return IconsModel.fromJson(item);
			case "goods_list":
				return GoodsListModel.fromJson(item);
			case "search":
				return SearchModel.fromJson(item);
			case "tabs_view":
				return TabsViewModel.fromJson(item);
			default:
				print("getModule unknown module");
				return null;
		}
	}
}