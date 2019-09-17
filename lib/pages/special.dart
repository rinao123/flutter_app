import 'package:flutter/widgets.dart';

import '../components/layout.dart';

class Special extends StatelessWidget {
	final String code;

	Special(this.code);

	@override
	Widget build(BuildContext context) {
		return Layout(this.code);
	}
}
