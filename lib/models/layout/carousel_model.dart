import "package:flutter_app/models/layout/base_model.dart";

class CarouselModel extends BaseModel {
	String _code;
	String _indicatorColor;
	String _indicatorActiveColor;
	int _num;

	String get code => this._code;
	set code(String code) => this._code = code;

	String get indicatorColor => this._indicatorColor;
	set indicatorColor(String indicatorColor) => this._indicatorColor = indicatorColor;

	String get indicatorActiveColor => this._indicatorActiveColor;
	set indicatorActiveColor(String indicatorActiveColor) => this._indicatorActiveColor = indicatorActiveColor;

	int get num => this._num;
	set num(int num) => this._num = num;

	static CarouselModel fromJson(Map<String, dynamic> json) {
		CarouselModel carouselModel = CarouselModel();
		carouselModel.code = json["code"];
		carouselModel.indicatorColor = json["indicatorColor"];
		carouselModel.indicatorActiveColor = json["indicatorActiveColor"];
		if (json["num"] is String) {
			carouselModel.num = json["num"] = int.parse(json["num"]);
		}
		carouselModel.num = json["num"];
		carouselModel.ts = DateTime.now().millisecondsSinceEpoch;
		carouselModel.isShow = true;
		carouselModel.isReachBottom = true;
		return carouselModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "swiper",
			"code": this.code,
			"indicatorColor": this.indicatorColor,
			"indicatorActiveColor": this.indicatorActiveColor,
			"num": this.num
		};
	}
}