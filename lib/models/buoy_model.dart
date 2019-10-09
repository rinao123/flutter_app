import 'base_model.dart';

class BuoyModel extends BaseModel {
	String _img;
	int _width;
	int _height;
	String _link;
	String _openType;
	String _copy;

	BuoyModel() {
		this.img = "";
		this.width = 0;
		this.height = 0;
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

	String get link => this._link;
	set link(String link) => this._link = link;

	String get openType => this._openType;
	set openType(String openType) => this._openType = openType;

	String get copy => this._copy;
	set copy(String copy) => this._copy = copy;

	static BuoyModel fromJson(Map<String, dynamic> json) {
		BuoyModel buoyModel = BuoyModel();

		buoyModel.img = json["img"];

		if (json["width"] is String) {
			json["width"] = int.parse(json["width"]);
		}
		buoyModel.width = json["width"];

		if (json["height"] is String) {
			json["height"] = int.parse(json["height"]);
		}
		buoyModel.height = json["height"];

		if (json["borderRadius"] is String) {
			json["borderRadius"] = int.parse(json["borderRadius"]);
		}

		buoyModel.link = json["link"];

		buoyModel.openType = json["openType"];

		buoyModel.copy = json["copy"];

		return buoyModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "buoy",
			"img": this.img,
			"width": this.width,
			"height": this.height,
			"link": this.link,
			"openType": this.openType,
			"copy": this.copy
		};
	}
}