
class BaseModel {
	int _ts;
	bool _isShow;

	int get ts => this._ts;
	set ts(int ts) => this._ts = ts;

	bool get isShow => this._isShow;
	set isShow(bool isShow) => this._isShow = isShow;
}