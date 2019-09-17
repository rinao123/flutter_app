import 'package:flutter/widgets.dart';

import '../../common/navigation_helper.dart';

class LayoutBehaviorsMixin {
	onTap(BuildContext context, {String link}) {
		if (link.isNotEmpty) {
			NavigationHelper.navigateTo(context, link);
		}
	}
}
