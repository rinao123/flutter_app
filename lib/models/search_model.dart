import 'base_model.dart';

class SearchModel extends BaseModel {
	String _backgroundColor;
	String _inputColor;
	String _title;

	String get backgroundColor => this._backgroundColor;
	set backgroundColor(String backgroundColor) => this._backgroundColor = backgroundColor;

	String get inputColor => this._inputColor;
	set inputColor(String inputColor) => this._inputColor = inputColor;

	String get title => this._title;
	set title(String title) => this._title = title;

	static SearchModel fromJson(Map<String, dynamic> json) {
		SearchModel searchModel = SearchModel();
		searchModel.backgroundColor = json["backgroundColor"];
		searchModel.inputColor = json["inputColor"];
		searchModel.title = json["title"];
		searchModel.ts = DateTime.now().millisecondsSinceEpoch;
		searchModel.isShow = true;
		searchModel.isReachBottom = true;
		return searchModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "search",
			"backgroundColor": this.backgroundColor,
			"inputColor": this.inputColor,
			"title": this.title
		};
	}
}