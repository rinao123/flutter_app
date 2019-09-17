import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/utils.dart';
import 'configs/config.dart';
import 'pages/splash.dart';
import 'provider/theme_provider.dart';

void main() {
    runApp(App());
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class App extends StatelessWidget {

    App() {
        this.init();
    }

    void init() {
        fluwx.register(appId:"wx1722b6440ea7da77");
        Logger.root.level = Level.ALL;
        Logger.root.onRecord.listen((LogRecord rec) {
            print("${rec.level.name}: ${rec.time}: ${rec.loggerName}: ${rec.message}");
        });
    }

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(builder: (_) => ThemeProvider()),
            ],
            child: RefreshConfiguration(
                footerBuilder: () => CustomFooter(builder: this._buildRefreshFooter),
                child: MaterialApp(
                    title: Config.APP_NAME,
                    home: Splash()
                )
            )
        );
    }

    Widget _buildRefreshFooter(BuildContext context, LoadStatus mode) {
        Widget content ;
        if (mode == LoadStatus.loading) {
            content =  Image.asset("assets/images/loading.gif", width: Utils.px2dp(64), height: Utils.px2dp(64));
        } else if (mode == LoadStatus.noMore){
            content = Text("—— 云来商城提供技术支持 ——", style: TextStyle(fontSize: Utils.px2dp(24), color: Utils.getColorFromString("rgba(85,85,85,0.3)")));
        }
        return Container(
                width: Utils.px2dp(Utils.DESIGN_WIDTH),
                height: Utils.px2dp(112),
                child: Center(
                    child: content
                )
        );
    }
}
