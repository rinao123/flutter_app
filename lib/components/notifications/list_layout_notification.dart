import "package:flutter/widgets.dart";

class ListLayoutNotification extends Notification {
	final int message;
	static const MESSAGE_LOADED = 1;

	ListLayoutNotification({@required this.message});
}