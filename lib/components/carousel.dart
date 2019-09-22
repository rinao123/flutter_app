import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'layout_behaviors_mixin.dart';
import '../common/utils.dart';
import '../controllers/site_controller.dart';
import '../models/advice_model.dart';
import 'package:flutter_app/models/carousel_model.dart';


class Carousel extends StatefulWidget {
	final CarouselModel model;

	Carousel({@required this.model});

	@override
	State<StatefulWidget> createState() => CarouselState();
}

class CarouselState extends State<Carousel> with LayoutBehaviorsMixin {
	CarouselModel _model;
	List<AdviceModel> _advices;
	int curIndex = 0;

	@override
	void initState() {
		super.initState();
		this._model = widget.model;
		this.getAdList();
	}

	@override
	Widget build(BuildContext context) {
		//TODO 加载中样式
		if (this._advices == null) {
			return Container(
				width: Utils.px2dp(Utils.DESIGN_WIDTH),
				height: Utils.px2dp(400),
				child: Center(
					child: Text("正在加载中…")
				)
			);
		}
		return Offstage(
			offstage: !this._model.isShow,
			child: Container(
				width: Utils.px2dp(this._advices[0].width),
				height: Utils.px2dp(this._advices[0].height),
				child: Stack(
					children: <Widget>[
						Swiper(
							autoplayDelay: 5000,
							autoplay: this._advices.length > 1,
							loop: this._advices.length > 1,
							duration: 500,
							itemCount: this._advices.length,
							itemBuilder: (BuildContext context, int index) {
								AdviceModel adviceModel = this._advices[index];
								return FadeInImage.assetNetwork(
									image: adviceModel.picUrl,
									placeholder: "assets/images/loading.gif",
									width: Utils.px2dp(adviceModel.width),
									height: Utils.px2dp(adviceModel.height)
								);
							},
							onTap: (int index) => this.onTap(context, link: this._advices[index].link),
							onIndexChanged: (int index) {
								this.setState(() => this.curIndex = index);
							}
						),
						this._buildIndicator()
					]
				)
			)
		);
	}

	Widget _buildIndicator() {
		if (this._advices.length == 1) {
			return Container();
		}
		return Positioned(
			bottom: Utils.px2dp(20),
			left: 0,
			width: Utils.px2dp(Utils.DESIGN_WIDTH),
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
			Color color = Utils.getColorFromString(i == this.curIndex ? this._model.indicatorActiveColor : this._model.indicatorColor);
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

	void show() {
		this.setState(() => this._model.isShow = true);
	}

	void hide() {
		this.setState(() => this._model.isShow = false);
	}

	void getAdList() async {
		List<AdviceModel> advices = await SiteController.getAdList(this._model.code);
		if (advices == null) {
			return;
		}
		this.setState(() => this._advices = advices);
	}
}
