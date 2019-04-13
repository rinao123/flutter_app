import "package:money/money.dart";

class Goods {
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
	List<String> _goodsTags;

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

	List<String> get goodsTags => this._goodsTags;
	set goodsTags(List<String> goodsTags) => this._goodsTags = goodsTags;

	static Goods fromJson(Map<String, dynamic> json) {
		Goods goods = Goods();
		goods.id = json["id"];
		goods.name = json["goods_name"];
		goods.subTitle = json["sub_title"];
		goods.introduction = json["introduction"];
		goods.picture = json["picture"];
		goods.banner = json["banner"];
		if (json["price"] is int) {
			json["price"] = json["price"].toDouble();
		}
		goods.price = Money.fromDouble(json["price"], Currency("CNY"));
		if (json["promotion_price"] is int) {
			json["promotion_price"] = json["promotion_price"].toDouble();
		}
		goods.promotionPrice = Money.fromDouble(json["promotion_price"], Currency("CNY"));
		goods.state = json["state"];
		goods.stock = json["stock"];
		goods.pintuanNum = json["pintuan_num"];
		if (json["pintuan_price"] is int) {
			json["pintuan_price"] = json["pintuan_price"].toDouble();
		}
		goods.pintuanPrice = Money.fromDouble(json["pintuan_price"], Currency("CNY"));
		goods.sales = json["sales"];
		goods.shares = json["shares"];
		if (json["commission"] is int) {
			json["commission"] = json["commission"].toDouble();
		}
		goods.commission = Money.fromDouble(json["commission"], Currency("CNY"));
		goods.promotionState = json["promotion_state"];
		goods.positiveRating = json["positive_rating"];
		goods.isPresell = json["is_presell"];
		goods.arrivalTime = json["arrival_time"];
		if (json["is_distribution_suit"] is int) {
			json["is_distribution_suit"] = json["is_distribution_suit"] > 0;
		}
		goods.isDistributionSuit = json["is_distribution_suit"];
		List<String> goodsTags = [];
		for (dynamic goodsTag in json["goods_tags"]) {
			goodsTags.add(goodsTag.toString());
		}
		goods.goodsTags = goodsTags;
		return goods;
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
			"is_distribution_suit": this.isDistributionSuit,
			"goods_tags": this.goodsTags,
		};
	}
}