
class ShareInfoModel {
	String _img;
	String _path;
	String _title;

	String get img => this._img;
	set img(String img) => this._img = img;

	String get path => this._path;
	set path(String path) => this._path = path;

	String get title => this._title;
	set title(String title) => this._title = title;

	static ShareInfoModel fromJson(Map<String, dynamic> json) {
		ShareInfoModel shareInfoModel = new ShareInfoModel();
		shareInfoModel.img = json["img"];
		shareInfoModel.path = json["path"];
		shareInfoModel.title = json["title"];
		return shareInfoModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"img": this._img,
			"path": this._path,
			"title": this._title
		};
	}
}