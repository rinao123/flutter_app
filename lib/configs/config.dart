class Config {
    static const String APP_NAME = "优米共享";
    static const String APP_KEY = "f44554b21307902bd2dd918a355d10a6";
    static const String GATEWAY = "https://gateway.test.iyunlai.cn";
    static const String MAIN_COLOR = "#FC6D6E";
    static const String SECONDARY_COLOR = "#333333";
    static const Map<String, dynamic> TAB_BAR = {
        "backgroundColor": "#FFFFFF",
        "borderStyle": "#FFFFFF",
        "list": [
            {
                "pagePath": "/pages/index/index",
                "text": "首页",
                "iconPath": "assets/images/index.png",
                "selectedIconPath": "assets/images/index_selected.png",
                "color": "#B4B4B4",
                "selectedColor": "#C3AE8D",
            },
            {
                "pagePath": "/pages/member/member",
                "text": "会员中心",
                "iconPath": "assets/images/member.png",
                "selectedIconPath": "assets/images/member_selected.png",
                "color": "#B4B4B4",
                "selectedColor": "#C3AE8D",
            },
            {
                "pagePath": "/pages/recommend/recommend",
                "text": "优米推荐",
                "iconPath": "assets/images/recommend.png",
                "selectedIconPath": "assets/images/recommend_selected.png",
                "color": "#B4B4B4",
                "selectedColor": "#E75140"
            },
            {
                "pagePath": "/pages/cart/cart",
                "text": "购物袋",
                "iconPath": "assets/images/cart.png",
                "selectedIconPath": "assets/images/cart_selected.png",
                "color": "#B4B4B4",
                "selectedColor": "#C3AE8D",
            },
            {
                "pagePath": "/pages/myinfo/myinfo",
                "text": "我的",
                "iconPath": "assets/images/myinfo.png",
                "selectedIconPath": "assets/images/myinfo_selected.png",
                "color": "#B4B4B4",
                "selectedColor": "#C3AE8D",
            }
        ]
    };
}