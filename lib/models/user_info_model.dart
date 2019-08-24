
class UserInfoModel {
	int _uid;
	String _nickname;
	String _avatar;
	int _gender;
	String _mobile;
	bool _authorized;

	int get uid => this._uid;
	set uid(int value) => this._uid = value;

	String get nickname => this._nickname;
	set nickname(String value) => this._nickname = value;

	String get avatar => this._avatar;
	set avatar(String value) => this._avatar = value;

	int get gender => this._gender;
	set gender(int value) => this._gender = value;

	String get mobile => this._mobile;

	set mobile(String value) => this._mobile = value;

	bool get authorized => this._authorized;
	set authorized(bool value) => this._authorized = value;

	static UserInfoModel fromJson(Map<String, dynamic> json) {
		UserInfoModel userInfoModel = UserInfoModel();
		userInfoModel.uid = json["uid"];
		userInfoModel.nickname = json["nickname"];
		userInfoModel.avatar = json["avatar"];
		userInfoModel.gender = json["gender"];
		userInfoModel.mobile = json["mobile"];
		userInfoModel.authorized = json["authorized"];
		return userInfoModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"uid": this.uid,
			"nickname": this.nickname,
			"avatar": this.avatar,
			"gender": this.gender,
			"mobile": this.mobile,
			"authorized": this.authorized
		};
	}
}