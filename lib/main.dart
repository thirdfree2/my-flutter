import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/loading.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:flutter_application_1/view/main.layout.dart';
import 'package:flutter_application_1/view/psychologist_screens/psycholonist_home_page.dart';
import 'package:flutter_application_1/view/screens/auth_page.dart';
import 'package:flutter_application_1/view/screens/register_page.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(
    token: prefs.getString('token'),
  ));
}

class App extends StatelessWidget {
  final String? token;
  const App({@required this.token, Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashView(token: token),
        'psy_main': (context) => PsyHomePage(token: token,),
        'auth': (context) => const AuthPage(),
        'loading': (context) => LoadingView(token: token),
        'register': (context) => const RigisterPage(),
        'main': (context) => MainView(token: token),
      },
    );
  }
}
