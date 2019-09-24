import 'package:flutter/widgets.dart';

class StateReferenceModel {
	GlobalKey _key;
	Widget _widget;

	GlobalKey get key => this._key;
	set key(GlobalKey key) => this._key = key;

	Widget get widget => this._widget;
	set widget(Widget widget) => this._widget = widget;
}