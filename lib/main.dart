import 'package:data_warga/bindings/bindings.dart';
import 'package:data_warga/data/database/database_helper.dart';
import 'package:data_warga/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    GetStorage.init(),
    DatabaseHandler().initializeDB(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Warga',
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system,
      initialBinding: AppBindings(),
      getPages: AppPages.pages,
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(secondary: Colors.green),
        primaryColor: Colors.amber,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: ThemeData.light().scaffoldBackgroundColor),
        textTheme: _myTextTheme(Colors.black));
  }

  ThemeData _darkTheme() {
    return ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.amber, brightness: Brightness.dark)
            .copyWith(secondary: Colors.green),
        primaryColor: Colors.amber,
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: ThemeData.dark().scaffoldBackgroundColor),
        textTheme: _myTextTheme(Colors.white));
  }

  TextTheme _myTextTheme(Color color) {
    return TextTheme(
        headline1:
            TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: color),
        headline2:
            TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: color),
        headline3:
            TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: color),
        headline4:
            TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color),
        headline5:
            TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        headline6:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        subtitle1: TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: color),
        subtitle2: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: color),
        bodyText1: TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: color),
        bodyText2: TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: color),
        caption: TextStyle(
            fontSize: 12, fontWeight: FontWeight.normal, color: color),
        button: TextStyle(
            fontSize: 15, fontWeight: FontWeight.normal, color: color),
        overline: TextStyle(fontSize: 10, color: color));
  }
}
