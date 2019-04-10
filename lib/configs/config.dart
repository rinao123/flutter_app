class Config {
    static const String APP_NAME = "优米共享";
    static const String APP_KEY = "fa5228891d96458e53fa2d9b10899c6d";
    static const String GATEWAY = "https://gateway.umi666.com";
    static const Map<String, dynamic> TAB_BAR = {
        "backgroundColor": "#FFFFFF",
        "borderStyle": "#FFFFFF",
        "color": "#B4B4B4",
        "selectedColor": "#C3AE8D",
        "list": [
            {
                "pagePath": "pages/index/index",
                "text": "首页",
                "iconPath": "assets/images/index.png",
                "selectedIconPath": "assets/images/index_selected.png"
            },
            {
                "pagePath": "pages/member/member",
                "text": "会员中心",
                "iconPath": "assets/images/member.png",
                "selectedIconPath": "assets/images/member_selected.png"
            },
            {
                "pagePath": "pages/cart/cart",
                "text": "购物车",
                "iconPath": "assets/images/cart.png",
                "selectedIconPath": "assets/images/cart_selected.png"
            },
            {
                "pagePath": "pages/myinfo/myinfo",
                "text": "我的",
                "iconPath": "assets/images/myinfo.png",
                "selectedIconPath": "assets/images/myinfo_selected.png"
            }
        ]
    };
}