import 'package:logging/logging.dart';

class AdviceModel {
	static final Logger logger = Logger("AdviceModel");
	int _id;
	int _adposId;
	String _picUrl;
	int _width;
	int _height;
	String _title;
	String _originLink;
	String _link;

	int get id => this._id;
	set id(int id) => this._id = id;

	int get adposId => this._adposId;
	set adposId(int adposId) => this._adposId = adposId;

	String get picUrl => this._picUrl;
	set picUrl(String picUrl) => this._picUrl = picUrl;

	int get width => this._width;
	set width(int width) => this._width = width;

	int get height => this._height;
	set height(int height) => this._height = height;

	String get title => this._title;
	set title(String title) => this._title = title;

	String get originLink => this._originLink;
	set originLink(String originLink) => this._originLink = originLink;

	String get link => this._link;
	set link(String link) => this._link = link;

	static AdviceModel fromJson(Map<String, dynamic> json) {
		AdviceModel adviceModel = AdviceModel();
		adviceModel.id = json["id"];
		adviceModel.adposId = json["adposId"];
		adviceModel.picUrl = json["picUrl"];
		adviceModel.width = json["width"];
		adviceModel.height = json["height"];
		adviceModel.title = json["title"];
		adviceModel.originLink = json["link"];
		adviceModel.link = getLink(json["link"]);
		return adviceModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"id": this.id,
			"adposId": this.adposId,
			"picUrl": this.picUrl,
			"width": this.width,
			"height": this.height,
			"title": this.title,
			"originLink": this.originLink,
			"link": this.link,
		};
	}

	static String getLink(String originLink) {
		int index = originLink.indexOf(":");
		if (index > -1) {
			String schema = originLink.substring(0, index);
			String link = originLink.substring(index + 1, originLink.length);
			switch (schema) {
				case "special":
					return "/pages/special/special?code=$link";
				default:
					logger.warning("getLink unknown schema");
					return "";
			}
		} else {
			return originLink;
		}
	}
}