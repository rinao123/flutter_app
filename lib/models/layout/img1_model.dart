import 'base_model.dart';

class Img1Model extends BaseModel {
	String _img;
	int _width;
	int _height;
	int _borderRadius;
	bool _shadow;
	String _link;
	String _openType;
	String _copy;

	Img1Model() {
		this.img = "";
		this.width = 0;
		this.height = 0;
		this.borderRadius = 0;
		this.shadow = false;
		this.link = "";
		this.openType = "";
		this.copy = "";
		this.ts = DateTime.now().millisecondsSinceEpoch;
		this.isShow = false;
		this.isReachBottom = true;
	}

	String get img => this._img;
	set img(String img) => this._img = img;

	int get width => this._width;
	set width(int width) => this._width = width;

	int get height => this._height;
	set height(int height) => this._height = height;

	int get borderRadius => this._borderRadius;
	set borderRadius(int borderRadius) => this._borderRadius = borderRadius;

	bool get shadow => this._shadow;
	set shadow(bool shadow) => this._shadow = shadow;

	String get link => this._link;
	set link(String link) => this._link = link;

	String get openType => this._openType;
	set openType(String openType) => this._openType = openType;

	String get copy => this._copy;
	set copy(String copy) => this._copy = copy;

	static Img1Model fromJson(Map<String, dynamic> json) {
		Img1Model img1Model = Img1Model();

		img1Model.img = json["img"];

		if (json["width"] is String) {
			json["width"] = int.parse(json["width"]);
		}
		img1Model.width = json["width"];

		if (json["height"] is String) {
			json["height"] = int.parse(json["height"]);
		}
		img1Model.height = json["height"];

		if (json["borderRadius"] is String) {
			json["borderRadius"] = int.parse(json["borderRadius"]);
		}
		img1Model.borderRadius = json["borderRadius"];

		img1Model.shadow = json["shadow"];

		img1Model.link = json["link"];

		img1Model.openType = json["openType"];

		img1Model.copy = json["copy"];

		return img1Model;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "img1",
			"img": this.img,
			"width": this.width,
			"height": this.height,
			"borderRadius": this.borderRadius,
			"shadow": this.shadow,
			"link": this.link,
			"openType": this.openType,
			"copy": this.copy
		};
	}
}