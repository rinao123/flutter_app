import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout.dart";
import "package:flutter_app/components/page_status.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/layout/layout_model.dart";

class LayoutPage extends StatefulWidget {

	final String code;

	LayoutPage(this.code);

	@override
	State<StatefulWidget> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
	LayoutModel _layoutModel;
	ScrollController _scrollController;
	bool _isLoading;
	bool _isReachBottom;
	Layout _layout;
	GlobalKey<LayoutState> _layoutStateKey;

	@override
	void initState() {
		super.initState();
		this._scrollController = ScrollController();
		this._scrollController.addListener(this._onPageScroll);
		this._isLoading = false;
		this._isReachBottom = false;
		this._getLayouts();
	}

	@override
	Widget build(BuildContext context) {
		if (this._layoutModel == null) {
			return Scaffold(
				appBar: AppBar(
					backgroundColor: Utils.getColorFromString("#ffffff"),
					brightness: Brightness.light,
          			iconTheme: IconThemeData(color: Colors.white)
				),
				body: PageStatus()
			);
		}
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Utils.getColorFromString(this._layoutModel.backgroundColor),
				brightness: Brightness.light,
				iconTheme: IconThemeData(color: Colors.black),
				title: Text(
					this._layoutModel.title,
					style: TextStyle(color: Utils.getColorFromString(this._layoutModel.frontColor))
				),
			),
			body: this._buildBody()
		);
	}

	Widget _buildBody() {
		this._layoutStateKey = GlobalKey<LayoutState>();
		this._layout = Layout(this._layoutModel.modules, key: this._layoutStateKey);
		return Container(
			color: Utils.getColorFromString("#F5F5F5"),
			child: RefreshIndicator(
				onRefresh: this._onRefresh,
				child: SingleChildScrollView(
					controller: this._scrollController,
					child: this._layout
				)
			)
		);
	}

	Future<void> _onRefresh() async {
		this.setState(() => this._layoutModel = null);
		this._getLayouts();
	}

	void _onPageScroll() {
		if (this._scrollController.position.userScrollDirection == ScrollDirection.reverse && this._scrollController.offset >= this._scrollController.position.maxScrollExtent - 50 && !this._isLoading) {
			this._onReachBottom();
		}
	}

	void _onReachBottom() {
		if (this._isReachBottom) {
			return;
		}
		if (this._layoutStateKey != null) {
			this._layoutStateKey.currentState.onReachBottom();
		}
	}

	void _getLayouts() async {
		LayoutModel layoutModel = await SiteController.getLayoutByCode(widget.code);
		if (layoutModel == null) {
			return;
		}
		this.setState(() => this._layoutModel = layoutModel);
	}
}
