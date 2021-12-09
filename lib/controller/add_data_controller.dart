import 'package:data_warga/data/database/database_helper.dart';
import 'package:data_warga/data/models/anggota.dart';
import 'package:data_warga/data/models/status.dart';
import 'package:data_warga/routes/routes.dart';
import 'package:data_warga/widget/list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AddDataController extends GetxController {
  //Database
  final Database _db = DatabaseHandler.instance;
  Map<String, TextEditingController?> textController = {
    Anggota.kolomNIK: TextEditingController(),
    Anggota.kolomALAMAT: TextEditingController(),
    Anggota.kolomNAMA: TextEditingController(),
    Anggota.kolomNORUMAH: TextEditingController(),
    Anggota.kolomRT: TextEditingController(),
    Anggota.kolomRW: TextEditingController(),
    Anggota.kolomDOMISILI: null,
    Anggota.kolomJK: null,
    Anggota.kolomPEKERJAAN: null,
    Anggota.kolomSTATUS: null,
    Anggota.kolomTGLLAHIR: null
  };

  @override
  void onInit() {
    _getVariable();
    textController.forEach((key, value) {
      if (value != null) {
        value.addListener(() {
          setAddData(key, value.text);
        });
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    textController.forEach((key, value) {
      if (value != null) {
        value.dispose();
      }
    });
    super.onClose();
  }

  final RxMap<String, dynamic> _addData = {
    Anggota.kolomNIK: '',
    Anggota.kolomALAMAT: '',
    Anggota.kolomDOMISILI: '',
    Anggota.kolomJK: '',
    Anggota.kolomNAMA: '',
    Anggota.kolomNORUMAH: '',
    Anggota.kolomPEKERJAAN: '',
    Anggota.kolomRT: '',
    Anggota.kolomRW: '',
    Anggota.kolomSTATUS: '',
    Anggota.kolomTGLLAHIR: ''
  }.obs;

  void _getVariable() async {
    var res = await _db.query('variable_tetap');
    textController[Anggota.kolomRT]!.text = res.first["RT"].toString();
    textController[Anggota.kolomRW]!.text = res.first["RW"].toString();
    textController[Anggota.kolomALAMAT]!.text =
        "KEL. ${res.first["KEL"].toString()} - KEC. ${res.first["KEC"].toString()} - KOTA ${res.first["KOTA"].toString()}";
  }

  Map<String, dynamic> get addData => _addData;
  void setAddData(String key, dynamic val) {
    _addData[key] = val;
    if (_addData[Anggota.kolomNORUMAH] != "" &&
        _addData[Anggota.kolomRT] != "" &&
        _addData[Anggota.kolomRW] != "" &&
        _addData[Anggota.kolomSTATUS] != "") {
      if (!nextInput) {
        nextInput = true;
        chechkData();
      }
    } else {
      nextInput = false;
    }
  }

  void clearAddData() {
    textController.forEach((key, value) {
      if (value != null) {
        value.text = '';
      } else {
        setAddData(key, '');
      }
    });
    nextInput = false;
    isUpdate = false;
  }

  final _nextInput = false.obs;
  bool get nextInput => _nextInput.value;
  set nextInput(bool val) => _nextInput.value = val;

  final _isUpdate = false.obs;
  bool get isUpdate => _isUpdate.value;
  bool get isUpdateFrom => !_isUpdate.value;
  set isUpdate(bool val) => _isUpdate.value = val;

  Future<void> chechkData() async {
    var res = await _db.query(Anggota.tableName,
        where: "${Anggota.kolomNORUMAH} = ? AND "
            "${Anggota.kolomRT} = ? AND "
            "${Anggota.kolomRW} = ? AND "
            "${Anggota.kolomSTATUS} = ?",
        whereArgs: [
          addData[Anggota.kolomNORUMAH],
          addData[Anggota.kolomRT],
          addData[Anggota.kolomRW],
          Status.statusID(addData[Anggota.kolomSTATUS].toString())
        ]);
    if (res.isNotEmpty) {
      Anggota anggota = Anggota.fromMap(res.first);
      Map<String, dynamic> data = anggota.toMapString();
      textController.forEach((key, value) {
        if (value != null) {
          value.text = data[key];
        } else {
          setAddData(key, data[key]);
        }
      });
      Get.defaultDialog(
          title: "Data sudah ada!\napakah anda ingin mengubahnya?",
          textCancel: "Tidak",
          textConfirm: "Ya",
          confirmTextColor: Get.theme.scaffoldBackgroundColor,
          content: cardAnggota(anggota: anggota),
          onCancel: () =>
              Get.until((route) => Get.currentRoute == Routes.dashboard),
          onConfirm: () {
            Get.back();
            isUpdate = true;
          });
    }
  }

  Future<void> insertData(Anggota anggota) async {
    try {
      if (isUpdate) {
        await _db.update(
          Anggota.tableName,
          anggota.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: "${Anggota.kolomNORUMAH} = ? AND "
              "${Anggota.kolomRT} = ? AND "
              "${Anggota.kolomRW} = ? AND "
              "${Anggota.kolomSTATUS} = ?",
          whereArgs: [
            addData[Anggota.kolomNORUMAH],
            addData[Anggota.kolomRT],
            addData[Anggota.kolomRW],
            Status.statusID(addData[Anggota.kolomSTATUS].toString())
          ],
        );
        clearAddData();
      } else {
        await _db.insert(Anggota.tableName, anggota.toMap());
        clearAddData();
      }
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar("Oops", "Data dengan NIK tertera sudah ada",
          backgroundColor: Get.theme.secondaryHeaderColor);
    }
  }
}
