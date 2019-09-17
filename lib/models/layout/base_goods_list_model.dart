import '../goods_model.dart';
import '../seckill_info_model.dart';


class BaseGoodsListModel {
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
	bool _isShowOriginalPrice;
	bool _isShowCountDown;
	bool _isShowStock;
	bool _isShowSales;
	int _btn;
	String _btnTitle;
	String _corner;
	int _cornerWidth;
	int _cornerHeight;
	SeckillInfoModel _seckillInfo;
	bool _isPintuan;
	List<GoodsModel> _goodsList;
	bool _isShowLoading;
	bool _isReachBottom;

	BaseGoodsListModel() {
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
		this.isShowOriginalPrice = false;
		this.isShowCountDown = false;
		this.isShowStock = false;
		this.isShowSales = false;
		this.btn = 0;
		this.btnTitle = "";
		this.corner = "";
		this.cornerWidth = 0;
		this.cornerHeight = 0;
		this.seckillInfo = null;
		this.isPintuan = false;
		this.goodsList = null;
		this.isShowLoading = false;
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

	bool get isShowOriginalPrice => this._isShowOriginalPrice;
	set isShowOriginalPrice(bool isShowOriginalPrice) => this._isShowOriginalPrice = isShowOriginalPrice;

	bool get isShowCountDown => this._isShowCountDown;
	set isShowCountDown(bool isShowCountDown) => this._isShowCountDown = isShowCountDown;

	bool get isShowStock => this._isShowStock;
	set isShowStock(bool isShowStock) => this._isShowStock = isShowStock;

	bool get isShowSales => this._isShowSales;
	set isShowSales(bool isShowSales) => this._isShowSales = isShowSales;

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

	SeckillInfoModel get seckillInfo => this._seckillInfo;
	set seckillInfo(SeckillInfoModel seckillInfo) => this._seckillInfo = seckillInfo;

	bool get isPintuan => this._isPintuan;
	set isPintuan(bool isPintuan) => this._isPintuan = isPintuan;

	List<GoodsModel> get goodsList => this._goodsList;
	set goodsList(List<GoodsModel> goodsList) => _goodsList = goodsList;

	bool get isShowLoading => this._isShowLoading;
	set isShowLoading(bool isShowLoading) => this._isShowLoading = isShowLoading;

	bool get isReachBottom => this._isReachBottom;
	set isReachBottom(bool isReachBottom) => _isReachBottom = isReachBottom;

	static BaseGoodsListModel fromJson(Map<String, dynamic> json) {
		BaseGoodsListModel baseGoodsListModel = BaseGoodsListModel();

		if (json["type"] is String) {
			json["type"] = int.parse(json["type"]);
		}
		baseGoodsListModel.type = json["type"];

		if (json["goodsStyle"] is String) {
			json["goodsStyle"] = int.parse(json["goodsStyle"]);
		}
		baseGoodsListModel.goodsStyle = json["goodsStyle"];

		if (json["pageMargin"] is String) {
			json["pageMargin"] = int.parse(json["pageMargin"]);
		}
		baseGoodsListModel.pageMargin = json["pageMargin"];

		if (json["goodsMargin"] is String) {
			json["goodsMargin"] = int.parse(json["goodsMargin"]);
		}
		baseGoodsListModel.goodsMargin = json["goodsMargin"];

		if (json["borderRadius"] is String) {
			json["borderRadius"] = int.parse(json["borderRadius"]);
		}
		baseGoodsListModel.borderRadius = json["borderRadius"];

		if (json.containsKey("pictureScale")) {
			if (json["pictureScale"] is String) {
				json["pictureScale"] = int.parse(json["pictureScale"]);
			}
			baseGoodsListModel.pictureScale = json["pictureScale"];
		}

		baseGoodsListModel.bold = json.containsKey("bold") && json["bold"];

		baseGoodsListModel.textAlign = json["textAlign"];

		baseGoodsListModel.isShowGoodsName = json.containsKey("goodsName") && json["goodsName"];

		baseGoodsListModel.isShowSubTitle = json.containsKey("subTitle") && json["subTitle"];

		baseGoodsListModel.isShowPrice = json.containsKey("price") && json["price"];

		baseGoodsListModel.isShowOriginalPrice = json.containsKey("originalPrice") && json["originalPrice"];

		baseGoodsListModel.isShowCountDown = json.containsKey("countDown") && json["countDown"];

		baseGoodsListModel.isShowStock = json.containsKey("stock") && json["stock"];

		baseGoodsListModel.isShowSales = json.containsKey("sales") && json["sales"];

		if (json.containsKey("btn")) {
			if (json["btn"] is String) {
				if (json["btn"].isNotEmpty) {
					json["btn"] = int.parse(json["btn"]);
				} else {
					json["btn"] = 0;
				}
			}
			baseGoodsListModel.btn = json["btn"];
		}

		if (json.containsKey("btnTitle")) {
			baseGoodsListModel.btnTitle = json["btnTitle"];
		}

		if (json.containsKey("corner")) {
			baseGoodsListModel.corner = json["corner"];
		}

		if (json.containsKey("cornerWidth")) {
			if (json["cornerWidth"] is String) {
				if (json["cornerWidth"].isNotEmpty) {
					json["cornerWidth"] = int.parse(json["cornerWidth"]);
				} else {
					json["cornerWidth"] = 0;
				}
			}
			baseGoodsListModel.cornerWidth = json["cornerWidth"];
		}

		if (json.containsKey("cornerHeight")) {
			if (json["cornerHeight"] is String) {
				if (json["cornerHeight"].isNotEmpty) {
					json["cornerHeight"] = int.parse(json["cornerHeight"]);
				} else {
					json["cornerHeight"] = 0;
				}
			}
			baseGoodsListModel.cornerHeight = json["cornerHeight"];
		}

		if (json.containsKey("seckillInfo")) {
			SeckillInfoModel seckillInfo = SeckillInfoModel.fromJson(json["seckillInfo"]);
			baseGoodsListModel.seckillInfo = seckillInfo;
		}

		baseGoodsListModel.isPintuan = json.containsKey("isPintuan") && json["isPintuan"];

		List<GoodsModel> goodsList = [];
		for (Map<String, dynamic> item in json["goods_list"]) {
			GoodsModel goodsModel = GoodsModel.fromJson(item);
			goodsList.add(goodsModel);
		}
		baseGoodsListModel.goodsList = goodsList;

		baseGoodsListModel.isShowLoading = json.containsKey("isShowLoading") && json["isShowLoading"];

		baseGoodsListModel.isReachBottom = json.containsKey("isReachBottom") && json["isReachBottom"];

		return baseGoodsListModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "goods_list"
		};
	}
}