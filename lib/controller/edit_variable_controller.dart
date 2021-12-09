import 'package:data_warga/data/database/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class EditVariableController extends GetxController {
  //Database
  final Database _db = DatabaseHandler.instance;
  Map<String, TextEditingController> textController = {
    "RT": TextEditingController(),
    "RW": TextEditingController(),
    "KEL": TextEditingController(),
    "KEC": TextEditingController(),
    "KOTA": TextEditingController()
  };

  @override
  void onInit() {
    _getVariable();
    super.onInit();
  }

  @override
  void onClose() {
    textController.forEach((key, value) {
      value.dispose();
    });
    super.onClose();
  }

  void _getVariable() async {
    var res = await _db.query('variable_tetap');
    res.first.forEach((key, value) {
      textController[key]!.text = value.toString();
    });
  }

  final _nextInput = false.obs;
  bool get nextInput => _nextInput.value;
  set nextInput(bool val) => _nextInput.value = val;

  final _isUpdate = false.obs;
  bool get isUpdate => _isUpdate.value;
  bool get isUpdateFrom => !_isUpdate.value;
  set isUpdate(bool val) => _isUpdate.value = val;

  Future<void> insertData() async {
    Map<String, String> data = <String, String>{};
    textController.forEach((key, value) {
      data.assign(key, value.text);
    });
    try {
      await _db.update("variable_tetap", data);
      Get.snackbar("Berhasil!", "Data variable sudah diperbaharui",
          backgroundColor: Get.theme.secondaryHeaderColor);
    } catch (e) {
      Get.snackbar("Oops", e.toString(),
          backgroundColor: Get.theme.secondaryHeaderColor);
    }
  }
}
