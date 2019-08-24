import "package:flutter_app/models/layout/base_model.dart";

class GoodsListModel extends BaseModel {
	String _src;
	int _type;

	String get src => this._src;
	set src(String src) => this._src = src;

	int get type => this._type;
	set type(int type) => this._type = type;

	static GoodsListModel fromJson(Map<String, dynamic> json) {
		GoodsListModel goodsListModel = GoodsListModel();
		goodsListModel.src = json["src"];
		if (json["type"] is String) {
			json["type"] = int.parse(json["type"]);
		}
		goodsListModel.type = json["type"];
		goodsListModel.ts = DateTime.now().millisecondsSinceEpoch;
		goodsListModel.isShow = true;
		goodsListModel.isReachBottom = false;
		return goodsListModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "goods_list",
			"src": this.src,
			"type": this.type
		};
	}
}