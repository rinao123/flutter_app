import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/vip.dart';
import 'package:flutter_app/pages/cart.dart';
import 'package:flutter_app/pages/index.dart';
import 'package:flutter_app/pages/myinfo.dart';
import 'package:flutter_app/pages/posts.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '购物圈', 'VIP', '购物车', '我的'];

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xFFFF7E1A)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xFFD0D0D0)));
    }
  }
  /*
   * 存储的四个页面，和Fragment一样
   */
  var _bodys;

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [
        getTabImage('assets/images/index.png'),
        getTabImage('assets/images/index_selected.png')
      ],
      [
        getTabImage('assets/images/posts.png'),
        getTabImage('assets/images/posts_selected.png')
      ],
      [
        getTabImage('assets/images/vip.png'),
        getTabImage('assets/images/vip.png')
      ],
      [
        getTabImage('assets/images/cart.png'),
        getTabImage('assets/images/cart_selected.png')
      ],
      [
        getTabImage('assets/images/myinfo.png'),
        getTabImage('assets/images/myinfo_selected.png')
      ]
    ];

    _bodys = [
      new Index(),
      new Posts(),
      new Vip(),
      new Cart(),
      new MyInfo()
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: getTabIcon(2), title: getTabTitle(2)),
          new BottomNavigationBarItem(
              icon: getTabIcon(3), title: getTabTitle(3)),
          new BottomNavigationBarItem(
              icon: getTabIcon(4), title: getTabTitle(4)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
