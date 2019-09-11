import "package:flutter/widgets.dart";
import "package:flutter_app/common/navigation_helper.dart";

class LayoutBehaviorsMixin {
	onTap(BuildContext context, {String link}) {
		if (link.isNotEmpty) {
			NavigationHelper.navigateTo(context, link);
		}
	}
}
