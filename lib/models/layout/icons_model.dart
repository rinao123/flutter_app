import "package:flutter_app/models/layout/base_model.dart";

class IconsModel extends BaseModel {
	int _numPerLine;
	List<IconModel> _items;

	int get numPerLine => this._numPerLine;
	set numPerLine(int numPerLine) => this._numPerLine = numPerLine;

	List<IconModel> get items => this._items;
	set items(List<IconModel> items) => this._items = items;

	static IconsModel fromJson(Map<String, dynamic> json) {
		IconsModel iconsModel = new IconsModel();
		if (json["numPerLine"] is String) {
			json["numPerLine"] = int.parse(json["numPerLine"]);
		}
		iconsModel.numPerLine = json["numPerLine"];
		List<IconModel> items = [];
		for (dynamic item in json["items"]) {
			IconModel iconModel = IconModel.fromJson(item);
			items.add(iconModel);
		}
		iconsModel.items = items;
		iconsModel.ts = DateTime.now().millisecondsSinceEpoch;
		iconsModel.isShow = true;
		return iconsModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "icons",
			"numPerLine": this._numPerLine,
			"items": this._items
		};
	}
}

class IconModel {
	String _img;
	String _title;
	int _width;
	int _height;
	String _switchTab;
	String _link;
	String _openType;
	String _copy;

	String get img => this._img;
	set img(String img) => this._img = img;

	String get title => this._title;
	set title(String title) => this._title = title;

	int get width => this._width;
	set width(int width) => this._width = width;

	int get height => this._height;
	set height(int height) => this._height = height;

	String get switchTab => this._switchTab;
	set switchTab(String switchTab) => this._switchTab = switchTab;

	String get link => this._link;
	set link(String link) => this._link = link;

	String get openType => this._openType;
	set openType(String openType) => this._openType = openType;

	String get copy => this._copy;
	set copy(String copy) => this._copy = copy;

	static IconModel fromJson(Map<String, dynamic> json) {
		IconModel iconModel = new IconModel();
		iconModel.img = json["img"];
		iconModel.title = json["title"];
		iconModel.width = json["width"];
		iconModel.height = json["height"];
		iconModel.switchTab = json["switchTab"];
		iconModel.link = json["link"];
		iconModel.openType = json["openType"];
		iconModel.copy = json["copy"];
		return iconModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"img": this._img,
			"title": this._title,
			"width": this._width,
			"height": this._height,
			"switchTab": this._switchTab,
			"link": this._link,
			"openType": this._openType,
			"copy": this.copy
		};
	}
}