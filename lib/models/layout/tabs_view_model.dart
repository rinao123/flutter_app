import 'list_model.dart';

class TabsViewModel extends ListModel {
	List<TabViewModel> _items;
	String _bgColor;
	String _textColor;
	String _bgColorSelected;
	String _textColorSelected;
	String _lineColor;
	bool _isSticky;

	List<TabViewModel> get items => this._items;
	set items(List<TabViewModel> items) => this._items = items;

	String get bgColor => this._bgColor;
	set bgColor(String bgColor) => this._bgColor = bgColor;

	String get textColor => this._textColor;
	set textColor(String textColor) => this._textColor = textColor;

	String get bgColorSelected => this._bgColorSelected;
	set bgColorSelected(String bgColorSelected) => this._bgColorSelected = bgColorSelected;

	String get textColorSelected => this._textColorSelected;
	set textColorSelected(String textColorSelected) => this._textColorSelected = textColorSelected;

	String get lineColor => this._lineColor;
	set lineColor(String lineColor) => this._lineColor = lineColor;

	bool get isSticky => this._isSticky;
	set isSticky(bool isSticky) => this._isSticky = isSticky;

	static TabsViewModel fromJson(Map<String, dynamic> json) {
		TabsViewModel tabsViewModel = TabsViewModel();
		List<TabViewModel> items = [];
		for (dynamic item in json["items"]) {
			TabViewModel tabViewModel = TabViewModel.fromJson(item);
			items.add(tabViewModel);
		}
		tabsViewModel.items = items;
		tabsViewModel.bgColor = json["bgColor"];
		tabsViewModel.textColor = json["textColor"];
		tabsViewModel.bgColorSelected = json["bgColorSelected"];
		tabsViewModel.textColorSelected = json["textColorSelected"];
		tabsViewModel.lineColor = json["lineColor"];
		tabsViewModel.isSticky = json["isSticky"] == "1";
		tabsViewModel.ts = DateTime.now().millisecondsSinceEpoch;
		tabsViewModel.isShow = true;
		tabsViewModel.isReachBottom = true;
		return tabsViewModel;
	}

	Map<String, dynamic> toJson(){
		List<Map<String, dynamic>> items = [];
		for (TabViewModel item in this.items) {
			items.add(item.toJson());
		}
		return {
			"module": "search",
			"items": this.items,
			"bgColor": this.bgColor,
			"textColor": this.textColor,
			"bgColorSelected": this.bgColorSelected,
			"textColorSelected": this.textColorSelected,
			"lineColor": this.lineColor,
			"isSticky": this.isSticky
		};
	}
}

class TabViewModel {
	String _title;
	String _code;

	String get title => this._title;
	set title(String title) => this._title = title;

	String get code => this._code;
	set code(String code) => this._code = code;

	static TabViewModel fromJson(Map<String, dynamic> json) {
		TabViewModel tabViewModel = TabViewModel();
		tabViewModel.title = json["title"];
		tabViewModel.code = json["code"];
		return tabViewModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"title": this.title,
			"code": this.code
		};
	}
}