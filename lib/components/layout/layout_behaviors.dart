import "package:flutter/widgets.dart";
import "package:flutter_app/common/navigation_helper.dart";

class LayoutBehaviors {
	onTap(BuildContext context, dynamic item) {
		print(item.link);
		if (!item.link.isEmpty) {
			NavigationHelper.navigateTo(context, item.link);
		}
	}
}
