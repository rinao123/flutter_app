import 'base_model.dart';

class PlaceholderModel extends BaseModel {
	String _backgroundColor;
	int _height;

	PlaceholderModel() {
		this.backgroundColor = "";
		this.height = 0;
		this.ts = DateTime.now().millisecondsSinceEpoch;
		this.isShow = false;
		this.isReachBottom = true;
	}

	String get backgroundColor => this._backgroundColor;
	set backgroundColor(String backgroundColor) => this._backgroundColor = backgroundColor;

	int get height => this._height;
	set height(int height) => this._height = height;

	static PlaceholderModel fromJson(Map<String, dynamic> json) {
		PlaceholderModel placeholderModel = PlaceholderModel();

		placeholderModel.backgroundColor = json["backgroundColor"];

		if (json["height"] is String) {
			json["height"] = int.parse(json["height"]);
		}
		placeholderModel.height = json["height"];

		return placeholderModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "placeholder",
			"backgroundColor": this.backgroundColor,
			"height": this.height
		};
	}
}