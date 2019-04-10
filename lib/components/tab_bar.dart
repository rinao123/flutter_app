import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/configs/config.dart";

class BottomTabBar extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return new _BottomTabBarState();
    }
}

class _BottomTabBarState extends State<BottomTabBar> {
    int _curIndex = 0;

    @override
    Widget build(BuildContext context) {
        return Container(
            width: Utils.px2dp(750),
            height: Utils.px2dp(98),
            color: Utils.getColorFromHex(Config.TAB_BAR["backgroundColor"]),
            child: Row(
                children: this._buildList(),
            )
        );
    }

    List<Widget> _buildList() {
        List<Widget> list = [];
        for (int i = 0; i < Config.TAB_BAR["list"].length; i++) {
            Map<String, String> item = Config.TAB_BAR["list"][i];
            Widget tab = this._buildItem(i, item);
            list.add(tab);
        }
        return list;
    }

    Widget _buildItem(int index, Map<String, String> item) {
        return Expanded(
            child: Center(
                child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                        Image(
                            image: index == this._curIndex ? AssetImage(item["selectedIconPath"]) : AssetImage(item["iconPath"]),
                            width: Utils.px2dp(64),
                            height: Utils.px2dp(64)
                        ),
                        Column(
                            children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: Utils.px2dp(66))),
                                this._buildTitle(index, item)
                            ]
                        )
                    ],
                )
            ),
            flex: 1
        );
    }

    Text _buildTitle(int index, Map<String, String> item) {
        if (index == this._curIndex) {
            return this._buildTitleSelected(index, item);
        } else {
            return this._buildTitleCommon(index, item);
        }
    }

    Text _buildTitleCommon(int index, Map<String, String> item) {
        return Text(
            item["text"],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Utils.px2dp(20),
                color: Utils.getColorFromHex(Config.TAB_BAR["color"]),
                height: Utils.px2dp(1.4)
            )
        );
    }

    Text _buildTitleSelected(int index, Map<String, String> item) {
        return Text(
            item["text"],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Utils.px2dp(20),
                color: Utils.getColorFromHex(Config.TAB_BAR["selectedColor"]),
                fontWeight: FontWeight.bold,
                    height: Utils.px2dp(1.4)
            )
        );
    }

}
