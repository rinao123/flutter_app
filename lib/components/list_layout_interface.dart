import 'layout_interface.dart';

abstract class ListLayoutInterface extends LayoutInterface {
	bool get isReachBottom;
	void onReachBottom();
}
