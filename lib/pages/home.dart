import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_app/configs/config.dart";
import "package:flutter_app/common/utils.dart";
import "package:flutter_app/common//navigation_helper.dart";

class Home extends StatefulWidget {
    final int curIndex;

    Home({this.curIndex = 0});

    @override
    State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    int _curIndex;
    List<Widget> _pages = [];

    @override
    void initState() {
        super.initState();
        this._curIndex = widget.curIndex;
        this._pages = [];
        for (Map<String, String> item in Config.TAB_BAR["list"]) {
            Widget page = NavigationHelper.getPage(item["pagePath"]);
            this._pages.add(page);
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: IndexedStack(
                index: this._curIndex,
                children: this._pages
            ),
            bottomNavigationBar: this._buildBottomNavigationBar()
        );
    }

    Widget _buildBottomNavigationBar() {
        return BottomNavigationBar(
			type: BottomNavigationBarType.fixed,
            items: this._buildBottomNavigationBarItems(),
            onTap: (index) {
                this.setState(() => this._curIndex = index);
            },
        );
    }

    List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
        List<BottomNavigationBarItem> items = [];
        for (int i = 0; i < Config.TAB_BAR["list"].length; i++) {
            BottomNavigationBarItem item = this._buildBottomNavigationBarItem(i, Config.TAB_BAR["list"][i]);
            items.add(item);
        }
        return items;
    }

    BottomNavigationBarItem _buildBottomNavigationBarItem(index, item) {
        String iconPath = index == this._curIndex ? item["selectedIconPath"] : item["iconPath"];
        Color color = Utils.getColorFromString(index == this._curIndex ? item["selectedColor"] : item["color"]);
        FontWeight fontWeight = index == this._curIndex ? FontWeight.bold : FontWeight.normal;
        return BottomNavigationBarItem(
            icon: Image.asset(
                iconPath,
                width: Utils.px2dp(64),
                height: Utils.px2dp(64)
            ),
            title: Text(
                item["text"],
                style: TextStyle(
                    fontSize: Utils.px2dp(20),
                    color: color,
                    fontWeight: fontWeight
                )
            )
        );
    }
}
