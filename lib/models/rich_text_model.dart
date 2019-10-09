import 'base_model.dart';

class RichTextModel extends BaseModel {
	String _backgroundColor;
	String _text;

	RichTextModel() {
		this.backgroundColor = "#f5f5f5";
		this.text = "";
		this.ts = DateTime.now().millisecondsSinceEpoch;
		this.isShow = false;
		this.isReachBottom = true;
	}

	String get backgroundColor => this._backgroundColor;
	set backgroundColor(String backgroundColor) => this._backgroundColor = backgroundColor;

	String get text => this._text;
	set text(String text) => this._text = text;

	static RichTextModel fromJson(Map<String, dynamic> json) {
		RichTextModel richTextModel = RichTextModel();
		richTextModel.backgroundColor = json["backgroundColor"];
		richTextModel.text = json["text"];
		return richTextModel;
	}

	Map<String, dynamic> toJson(){
		return {
			"module": "rich_text",
			"backgroundColor": this.backgroundColor,
			"text": this.text
		};
	}
}