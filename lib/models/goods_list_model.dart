import 'list_model.dart';

class GoodsListModel extends ListModel {
	int _type;
	int _goodsStyle;
	int _pageMargin;
	int _goodsMargin;
	int _borderRadius;
	int _pictureScale;
	bool _bold;
	String _textAlign;
	bool _isShowGoodsName;
	bool _isShowSubTitle;
	bool _isShowPrice;
	int _btn;
	String _btnTitle;
	String _corner;
	int _cornerWidth;
	int _cornerHeight;
	String _src;
	int _pageSize;
	bool _isLoadingControlByPage;

	GoodsListModel() {
		this.type = 1;
		this.goodsStyle = 1;
		this.pageMargin = 0;
		this.goodsMargin = 0;
		this.borderRadius = 0;
		this.pictureScale = 1;
		this.bold = false;
		this.textAlign = "left";
		this.isShowGoodsName = false;
		this.isShowSubTitle = false;
		this.isShowPrice = false;
		this.btn = 0;
		this.btnTitle = "";
		this.corner = "";
		this.cornerWidth = 0;
		this.cornerHeight = 0;
		this.src = "";
		this.pageSize = 12;
		this.isLoadingControlByPage = false;
		this.ts = DateTime.now().millisecondsSinceEpoch;
		this.isShow = false;
		this.isReachBottom = false;
	}

	int get type => this._type;
	set type(int type) => this._type = type;

	int get goodsStyle => this._goodsStyle;
	set goodsStyle(int goodsStyle) => this._goodsStyle = goodsStyle;

	int get pageMargin => this._pageMargin;
	set pageMargin(int pageMargin) => this._pageMargin = pageMargin;

	int get goodsMargin => this._goodsMargin;
	set goodsMargin(int goodsMargin) => this._goodsMargin = goodsMargin;

	int get borderRadius => this._borderRadius;
	set borderRadius(int borderRadius) => this._borderRadius = borderRadius;

	int get pictureScale => this._pictureScale;
	set pictureScale(int pictureScale) => this._pictureScale = pictureScale;

	bool get bold => this._bold;
	set bold(bool bold) => this._bold = bold;

	String get textAlign => this._textAlign;
	set textAlign(String textAlign) => this._textAlign = textAlign;

	bool get isShowGoodsName => this._isShowGoodsName;
	set isShowGoodsName(bool isShowGoodsName) => this._isShowGoodsName = isShowGoodsName;

	bool get isShowSubTitle => this._isShowSubTitle;
	set isShowSubTitle(bool isShowSubTitle) => this._isShowSubTitle = isShowSubTitle;

	bool get isShowPrice => this._isShowPrice;
	set isShowPrice(bool isShowPrice) => this._isShowPrice = isShowPrice;

	int get btn => this._btn;
	set btn(int btn) => this._btn = btn;

	String get btnTitle => this._btnTitle;
	set btnTitle(String btnTitle) => this._btnTitle = btnTitle;

	String get corner => this._corner;
	set corner(String corner) => this._corner = corner;

	int get cornerWidth => this._cornerWidth;
	set cornerWidth(int cornerWidth) => this._cornerWidth = cornerWidth;

	int get cornerHeight => this._cornerHeight;
	set cornerHeight(int cornerHeight) => this._cornerHeight = cornerHeight;

	String get src => this._src;
	set src(String src) => this._src = src;

	int get pageSize => this._pageSize;
	set pageSize(int value) => this._pageSize = value;

	bool get isLoadingControlByPage => this._isLoadingControlByPage;
	set isLoadingControlByPage(bool isLoadingControlByPage) => this._isLoadingControlByPage = isLoadingControlByPage;

	static GoodsListModel fromJson(Map<String, dynamic> json) {
		GoodsListModel goodsListModel = GoodsListModel();

		if (json["type"] is String) {
			json["type"] = int.parse(json["type"]);
		}
		goodsListModel.type = json["type"];

		if (json["goodsStyle"] is String) {
			json["goodsStyle"] = int.parse(json["goodsStyle"]);
		}
		goodsListModel.goodsStyle = json["goodsStyle"];

		if (json["pageMargin"] is String) {
			json["pageMargin"] = int.parse(json["pageMargin"]);
		}
		goodsListModel.pageMargin = json["pageMargin"];

		if (json["goodsMargin"] is String) {
			json["goodsMargin"] = int.parse(json["goodsMargin"]);
		}
		goodsListModel.goodsMargin = json["goodsMargin"];

		if (json["borderRadius"] is String) {
			json["borderRadius"] = int.parse(json["borderRadius"]);
		}
		goodsListModel.borderRadius = json["borderRadius"];

		if (json.containsKey("pictureScale")) {
			if (json["pictureScale"] is String) {
				json["pictureScale"] = int.parse(json["pictureScale"]);
			}
			goodsListModel.pictureScale = json["pictureScale"];
		}

		goodsListModel.bold = json.containsKey("bold") && json["bold"];

		goodsListModel.textAlign = json["textAlign"];

		goodsListModel.isShowGoodsName = json.containsKey("goodsName") && json["goodsName"];

		goodsListModel.isShowSubTitle = json.containsKey("subTitle") && json["subTitle"];

		goodsListModel.isShowPrice = json.containsKey("price") && json["price"];

		if (json.containsKey("btn")) {
			if (json["btn"] is String) {
				if (json["btn"].isNotEmpty) {
					json["btn"] = int.parse(json["btn"]);
				} else {
					json["btn"] = 0;
				}
			}
			goodsListModel.btn = json["btn"];
		}

		if (json.containsKey("btnTitle")) {
			goodsListModel.btnTitle = json["btnTitle"];
		}

		if (json.containsKey("corner")) {
			goodsListModel.corner = json["corner"];
		}

		if (json.containsKey("cornerWidth")) {
			if (json["cornerWidth"] is String) {
				if (json["cornerWidth"].isNotEmpty) {
					json["cornerWidth"] = int.parse(json["cornerWidth"]);
				} else {
					json["cornerWidth"] = 0;
				}
			}
			goodsListModel.cornerWidth = json["cornerWidth"];
		}

		if (json.containsKey("cornerHeight")) {
			if (json["cornerHeight"] is String) {
				if (json["cornerHeight"].isNotEmpty) {
					json["cornerHeight"] = int.parse(json["cornerHeight"]);
				} else {
					json["cornerHeight"] = 0;
				}
			}
			goodsListModel.cornerHeight = json["cornerHeight"];
		}

		goodsListModel.src = json["src"];

		if (json["pageSize"] is String) {
			json["pageSize"] = int.parse(json["pageSize"]);
		}
		goodsListModel.pageSize = json["pageSize"];

		return goodsListModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "goods_list",
			"type": this.type,
			"goodsStyle": this.goodsStyle,
			"pageMargin": this.pageMargin,
			"goodsMargin": this.goodsMargin,
			"borderRadius": this.borderRadius,
			"pictureScale": this.pictureScale,
			"bold": this.bold,
			"textAlign": this.textAlign,
			"goodsName": this.isShowGoodsName,
			"subTitle": this.isShowSubTitle,
			"price": this.isShowPrice,
			"btn": this.btn,
			"btnTitle": this.btnTitle,
			"corner": this.corner,
			"cornerWidth": this.cornerWidth,
			"cornerHeight": this.cornerHeight,
			"src": this.src,
			"pageSize": this.pageSize
		};
	}

}