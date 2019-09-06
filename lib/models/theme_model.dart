
class ThemeModel {
	String _mainColor;
	String _secondaryColor;

	String get mainColor => this._mainColor;
	set mainColor(String mainColor) => this._mainColor = mainColor;

	String get secondaryColor => this._secondaryColor;
	set secondaryColor(String secondaryColor) => this._secondaryColor = secondaryColor;

	static ThemeModel fromJson(Map<String, dynamic> json) {
		ThemeModel themeModel = ThemeModel();
		themeModel.mainColor = json["mainColor"];
		themeModel.secondaryColor = json["secondaryColor"];
		return themeModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"mainColor": this.mainColor,
			"secondaryColor": this.secondaryColor
		};
	}


}