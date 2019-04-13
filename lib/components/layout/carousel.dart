import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/components/layout/layout_behaviors.dart";
import "package:flutter_app/controllers/site_controller.dart";
import "package:flutter_app/models/advice.dart";
import "package:flutter_app/models/layout/carousel_model.dart";
import "package:flutter_swiper/flutter_swiper.dart";

class Carousel extends StatefulWidget {
	final CarouselModel _carouselModel;

	Carousel(this._carouselModel);

	@override
	State<StatefulWidget> createState() {
		return _CarouselState(this._carouselModel);
	}
}

class _CarouselState extends State<Carousel> with LayoutBehaviors, AutomaticKeepAliveClientMixin<Carousel> {
	CarouselModel _carouselModel;
	List<Advice> _advices;
	int curIndex = 0;

	_CarouselState(this._carouselModel, {this.curIndex = 0});

	@override
	void initState() {
		super.initState();
		this.getAdList();
	}

	@override
	Widget build(BuildContext context) {
		//TODO 加载中样式
		if (this._advices == null) {
			return Container(
				width: Utils.px2dp(750),
				height: Utils.px2dp(400),
				child: Center(
					child: Text("正在加载中…")
				)
			);
		}
		return Container(
			width: Utils.px2dp(this._advices[0].width),
			height: Utils.px2dp(this._advices[0].height),
			child: Stack(
				children: <Widget>[
					Swiper(
						autoplay: true,
						duration: 500,
						itemCount: this._advices.length,
						itemBuilder: (BuildContext context, int index) {
							Advice advice = this._advices[index];
							return FadeInImage.assetNetwork(
									image: advice.picUrl,
									placeholder: "assets/images/loading.gif",
									width: Utils.px2dp(advice.width),
									height: Utils.px2dp(advice.height)
							);
						},
						onTap: (int index) => this.onTap(context, this._advices[index]),
						onIndexChanged: (int index) {
							this.setState(() => this.curIndex = index);
						}
					),
					this._buildIndicator()
				]
			)
		);
	}

	Widget _buildIndicator() {
		if (this._advices.length == 1) {
			return null;
		}
		return Positioned(
			bottom: Utils.px2dp(20),
			left: 0,
			width: Utils.px2dp(750),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: this._buildIndicatorItems()
			)
		);
	}

	List<Widget> _buildIndicatorItems() {
		List<Widget> items = [];
		for (int i = 0; i < this._advices.length; i++) {
			Color color = Utils.getColorFromString(i == this.curIndex ? this._carouselModel.indicatorActiveColor : this._carouselModel.indicatorColor);
			items.add(Container(
				color: color,
				width: Utils.px2dp(32),
				height: Utils.px2dp(4)
			));
			if (i < this._advices.length - 1) {
				items.add(Padding(
					padding: EdgeInsets.only(right: Utils.px2dp(6))
				));
			}
		}
		return items;
	}

	void getAdList() async {
		List<Advice> advices = await SiteController.getAdList(this._carouselModel.code);
		if (advices == null) {
			return;
		}
		this.setState(() => this._advices = advices);
	}

  @override
  bool get wantKeepAlive => true;
}
