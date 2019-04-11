import "package:flutter_app/models/layout/base_model.dart";

class Img1Model extends BaseModel {
	String _img;
	int _width;
	int _height;
	String _link;
	String _switchTab;
	String _openType;
	String _copy;

	String get img => this._img;
	set img(String img) => this._img = img;

	int get width => this._width;
	set width(int width) => this._width = width;

	int get height => this._height;
	set height(int height) => this._height = height;

	String get switchTab => this._switchTab;
	set switchTab(String switchTab) => switchTab = switchTab;

	String get link => this._link;
	set link(String link) => this._link = link;

	String get openType => this._openType;
	set openType(String openType) => this._openType = openType;

	String get copy => this._copy;
	set copy(String copy) => this._copy = copy;

	static Img1Model fromJson(Map<String, dynamic> json) {
		Img1Model img1Model = new Img1Model();
		img1Model.img = json["img"];
		img1Model.width = json["width"];
		img1Model.height = json["height"];
		img1Model.switchTab = json["switch"];
		img1Model.link = json["link"];
		img1Model.openType = json["openType"];
		img1Model.copy = json["copy"];
		img1Model.ts = DateTime.now().millisecondsSinceEpoch;
		img1Model.isShow = true;
		return img1Model;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "img1",
			"img": this._img,
			"width": this._width,
			"height": this._height,
			"switch": this._switchTab,
			"link": this._link,
			"openType": this._openType,
			"copy": this.copy
		};
	}
}