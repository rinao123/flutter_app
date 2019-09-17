import 'package:money/money.dart';

class GoodsModel {
	int _id;
	String _name;
	String _subTitle;
	String _introduction;
	String _picture;
	String _banner;
	Money _price;
	Money _promotionPrice;
	int _state;
	int _stock;
	int _pintuanNum;
	Money _pintuanPrice;
	int _sales;
	int _shares;
	Money _commission;
	int _promotionState;
	int _positiveRating;
	bool _isPresell;
	int _arrivalTime;
	bool _isDistributionSuit;

	int get id => this._id;
	set id(int id) => this._id = id;

	String get name => this._name;
	set name(String name) => this._name = name;

	get subTitle => this._subTitle;
	set subTitle(String subTitle) => this._subTitle = subTitle;

	String get introduction => this._introduction;
	set introduction(String introduction) => this._introduction = introduction;

	String get picture => this._picture;
	set picture(String picture) => this._picture = picture;

	String get banner => this._banner;
	set banner(String banner) => this._banner = banner;

	Money get price => this._price;
	set price(Money price) => this._price = price;

	Money get promotionPrice => this._promotionPrice;
	set promotionPrice(Money promotionPrice) => this._promotionPrice = promotionPrice;

	int get state => this._state;
	set state(int state) => this._state = state;

	int get stock => this._stock;
	set stock(int stock) => this._stock = stock;

	int get pintuanNum => this._pintuanNum;
	set pintuanNum(int pintuanNum) => this._pintuanNum = pintuanNum;

	Money get pintuanPrice => this._pintuanPrice;
	set pintuanPrice(Money pintuanPrice) => this._pintuanPrice = pintuanPrice;

	int get sales => this._sales;
	set sales(int sales) => this._sales = sales;

	int get shares => this._shares;
	set shares(int shares) => this._shares = shares;

	Money get commission => this._commission;
	set commission(Money commission) => this._commission = commission;

	int get promotionState => this._promotionState;
	set promotionState(int promotionState) => this._promotionState = promotionState;

	int get positiveRating => this._positiveRating;
	set positiveRating(int positiveRating) => this._positiveRating = positiveRating;

	bool get isPresell => this._isPresell;
	set isPresell(bool isPresell) => this._isPresell = isPresell;

	int get arrivalTime => this._arrivalTime;
	set arrivalTime(int arrivalTime) => this._arrivalTime = arrivalTime;

	bool get isDistributionSuit => this._isDistributionSuit;
	set isDistributionSuit(bool isDistributionSuit) => this._isDistributionSuit = isDistributionSuit;

	static GoodsModel fromJson(Map<String, dynamic> json) {
		GoodsModel goodsModel = GoodsModel();
		goodsModel.id = json["id"];
		goodsModel.name = json["goods_name"];
		goodsModel.subTitle = json["sub_title"];
		goodsModel.introduction = json["introduction"];
		goodsModel.picture = json["picture"];
		goodsModel.banner = json["banner"];
		if (json["price"] is int) {
			json["price"] = json["price"].toDouble();
		}
		goodsModel.price = Money.fromDouble(json["price"], Currency("CNY"));
		if (json["promotion_price"] is int) {
			json["promotion_price"] = json["promotion_price"].toDouble();
		}
		goodsModel.promotionPrice = Money.fromDouble(json["promotion_price"], Currency("CNY"));
		goodsModel.state = json["state"];
		goodsModel.stock = json["stock"];
		goodsModel.pintuanNum = json["pintuan_num"];
		if (json["pintuan_price"] is int) {
			json["pintuan_price"] = json["pintuan_price"].toDouble();
		}
		goodsModel.pintuanPrice = Money.fromDouble(json["pintuan_price"], Currency("CNY"));
		goodsModel.sales = json["sales"];
		goodsModel.shares = json["shares"];
		if (json["commission"] is int) {
			json["commission"] = json["commission"].toDouble();
		}
		goodsModel.commission = Money.fromDouble(json["commission"], Currency("CNY"));
		goodsModel.promotionState = json["promotion_state"];
		goodsModel.positiveRating = json["positive_rating"];
		goodsModel.isPresell = json["is_presell"];
		goodsModel.arrivalTime = json["arrival_time"];
		if (json["is_distribution_suit"] is int) {
			json["is_distribution_suit"] = json["is_distribution_suit"] > 0;
		}
		goodsModel.isDistributionSuit = json["is_distribution_suit"];
		return goodsModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"id": this.id,
			"goods_name": this.name,
			"sub_title": this.subTitle,
			"introduction": this.introduction,
			"picture": this.picture,
			"banner": this.banner,
			"price": double.parse(this.price.amountAsString),
			"promotion_price": double.parse(this.promotionPrice.amountAsString),
			"state": this.state,
			"stock": this.stock,
			"pintuan_num": this.pintuanNum,
			"pintuan_price": double.parse(this.pintuanPrice.amountAsString),
			"sales": this.sales,
			"shares": this.shares,
			"commission": double.parse(this.commission.amountAsString),
			"promotion_state": this.promotionState,
			"positive_rating": this.positiveRating,
			"is_presell": this.isPresell,
			"arrival_time": this.arrivalTime,
			"is_distribution_suit": this.isDistributionSuit
		};
	}
}