import 'package:data_warga/screens/dashboard/dashboard.dart';
import 'package:data_warga/screens/dashboard/menu/add_data.dart';
import 'package:data_warga/screens/dashboard/menu/export_import_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  final availablePages = <String, Widget>{
    'Data Warga': const HomePage(),
    'Input/Edit Data': const AddData(),
    'Edit Master': const EditVariablePage(),
    'Import/Export Data': const ExportImportPage(),
  };

  GetStorage storage = GetStorage();

  //Menu page state
  final _selectedPage = "Data Warga".obs;
  String get selectedPage => _selectedPage.value;
  set selectedPage(String val) => _selectedPage.value = val;

  final _tema = 0.obs;
  get tema => _tema.value;
  set tema(value) {
    _tema.value = value;
    storage.write("tema", value);
    switch (value) {
      case 0:
        Get.changeThemeMode(ThemeMode.system);
        break;
      case 1:
        Get.changeThemeMode(ThemeMode.dark);
        break;
      case 2:
        Get.changeThemeMode(ThemeMode.light);
        break;
    }
    Get.back();
  }

  @override
  void onReady() {
    tema = storage.read('tema') ?? 0;
    super.onReady();
  }
}
