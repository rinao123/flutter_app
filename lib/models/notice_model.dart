import 'base_model.dart';

class NoticeModel extends BaseModel {
	String _backgroundColor;
	String _textColor;
	String _notice;
	int _duration;
	int _startTime;
	int _endTime;
	bool _isRolling;

	NoticeModel() {
		this.backgroundColor = "#ffffff";
		this.textColor = "#333333";
		this.notice = "";
		this.duration = 0;
		this.startTime = 0;
		this.endTime = 0;
		this.isRolling = false;
		this.ts = DateTime.now().millisecondsSinceEpoch;
		this.isShow = false;
		this.isReachBottom = true;
	}

	String get backgroundColor => this._backgroundColor;
	set backgroundColor(String backgroundColor) => this._backgroundColor = backgroundColor;

	String get textColor => this._textColor;
	set textColor(String textColor) => this._textColor = textColor;

	String get notice => this._notice;
	set notice(String notice) => this._notice = notice;

	int get duration => this._duration;
	set duration(int duration) => this._duration = duration;

	int get startTime => this._startTime;
	set startTime(int startTime) => this._startTime = startTime;

	int get endTime => this._endTime;
	set endTime(int endTime) => this._endTime = endTime;

	bool get isRolling => this._isRolling;
	set isRolling(bool isRolling) => this._isRolling = isRolling;

	static NoticeModel fromJson(Map<String, dynamic> json) {
		NoticeModel noticeModel = NoticeModel();

		if (json.containsKey("backgroundColor")) {
			noticeModel.backgroundColor = json["backgroundColor"];
		}

		if (json.containsKey("textColor")) {
			noticeModel.textColor = json["textColor"];
		}

		noticeModel.notice = json["notice"];
		if (json.containsKey("duration")) {
			if (json["duration"] is String) {
				json["duration"] = int.parse(json["duration"]);
			}
			noticeModel.duration = json["duration"];
		}

		if (json.containsKey("startTime")) {
			if (json["startTime"] is String) {
				json["startTime"] = int.parse(json["startTime"]);
			}
			noticeModel.startTime = json["startTime"];
		}

		if (json.containsKey("endTime")) {
			if (json["endTime"] is String) {
				json["endTime"] = int.parse(json["endTime"]);
			}
			noticeModel.endTime = json["endTime"];
		}

		if (json.containsKey("isRolling")) {
			if (json["isRolling"] is int) {
				json["isRolling"] = json["isRolling"] > 0;
			} else if (json["isRolling"] is String) {
				json["isRolling"] = int.parse(json["isRolling"]) > 0;
			}
			noticeModel.isRolling = json["isRolling"];
		}

		return noticeModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "notice",
			"backgroundColor": this.backgroundColor,
			"textColor": this.textColor,
			"notice": this.notice,
			"duration": this.duration,
			"startTime": this.startTime,
			"isRolling": this.isRolling,
		};
	}
}