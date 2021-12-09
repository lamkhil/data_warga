import 'dart:convert';
import 'dart:io';

import 'package:data_warga/controller/controller.dart';
import 'package:data_warga/data/database/database_helper.dart';
import 'package:data_warga/data/models/anggota.dart';
import 'package:data_warga/data/models/domisili.dart';
import 'package:data_warga/data/models/jenis_kelamin.dart';
import 'package:data_warga/data/models/pekerjaan.dart';
import 'package:data_warga/data/models/status.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ExportImportController extends GetxController {
  final Database _db = DatabaseHandler.instance;
  String dataAnggota = "";
  Future<void> fetchData() async {
    final List<Map<String, dynamic>> maps = await _db.query(Anggota.tableName);
    maps.first.forEach((key, value) {
      dataAnggota += key;
      dataAnggota += ";";
    });
    dataAnggota += "\n";
    for (var element in maps) {
      element.forEach((key, value) {
        if (value is int) {
          dataAnggota += value.toString();
        } else {
          dataAnggota += value;
        }
        dataAnggota += ";";
      });
      dataAnggota += "\n";
    }
  }

  String dataAnggotaString = "";
  Future<void> fetchData2() async {
    final List<Map<String, dynamic>> maps = await _db.query(Anggota.tableName);
    List anggota = List.generate(
        maps.length, (index) => Anggota.fromMap(maps[index]).toMapString());
    maps.first.forEach((key, value) {
      dataAnggotaString += key;
      dataAnggotaString += ";";
    });
    dataAnggotaString += "\n";
    for (var element in anggota) {
      element.forEach((key, value) {
        dataAnggotaString += value;
        dataAnggotaString += ";";
      });
      dataAnggotaString += "\n";
    }
  }

  @override
  onInit() async {
    await Future.wait([fetchData(), fetchData2()]);
    super.onInit();
  }

  Future<bool> requestPermission(Permission p) async {
    if (await p.isGranted) {
      return true;
    } else {
      var result = await p.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  save(String contents, String format) async {
    try {
      if (await requestPermission(Permission.manageExternalStorage)) {
        String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath();

        if (selectedDirectory != null) {
          var specialName = "Data Anggota " +
              DateTime.now().toString().split(".")[0].replaceAll(":", "");
          String path = "$selectedDirectory/$specialName.$format";
          final file = await File(join(path)).create(recursive: true);
          file.writeAsString(contents);

          Get.snackbar("Berhasil!", "Data berhasil diexport",
              backgroundColor: Get.theme.secondaryHeaderColor);
        }
      }
    } catch (e) {
      Get.snackbar("Oops!", e.toString(),
          backgroundColor: Get.theme.secondaryHeaderColor);
    }
  }

  Future<void> open() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        Get.snackbar("Mohon Tunggu!", "Sedang import data",
            backgroundColor: Get.theme.secondaryHeaderColor);
        File file = File(result.files.single.path!);
        String text = await file.readAsString();
        LineSplitter ls = const LineSplitter();
        List<String> lines = ls.convert(text);
        var key = lines[0].split(";");
        List listMap = [];
        for (var i = 1; i < lines.length; i++) {
          Map<String, dynamic> data = {};
          var item = lines[i].split(";");
          for (var j = 0; j < item.length; j++) {
            if (item[j].isNotEmpty) {
              data[key[j]] = item[j];
            }
          }
          listMap.add(data);
        }
        for (var item in listMap) {
          await _db.insert(Anggota.tableName, item,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        Get.find<DataController>().fetchData();
        Get.snackbar("Berhasil!", "Data berhasil diimport",
            backgroundColor: Get.theme.secondaryHeaderColor);
      }
    } catch (e) {
      Get.snackbar("Oops!", e.toString(),
          backgroundColor: Get.theme.secondaryHeaderColor);
    }
  }

  Future<void> openString() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        Get.snackbar("Mohon Tunggu!", "Sedang import data",
            backgroundColor: Get.theme.secondaryHeaderColor);
        File file = File(result.files.single.path!);
        String text = await file.readAsString();
        LineSplitter ls = const LineSplitter();
        List<String> lines = ls.convert(text);
        var key = lines[0].split(";");
        List listMap = [];
        for (var i = 1; i < lines.length; i++) {
          Map<String, dynamic> data = {};
          var item = lines[i].split(";");
          for (var j = 0; j < item.length; j++) {
            if (item[j].isNotEmpty) {
              switch (key[j]) {
                case Anggota.kolomDOMISILI:
                  data[key[j]] = Domisili.domisiliID(item[j]);
                  break;
                case Anggota.kolomJK:
                  data[key[j]] = JK.jkID(item[j]);
                  break;
                case Anggota.kolomPEKERJAAN:
                  data[key[j]] = Pekerjaan.pekerjaanID(item[j]);
                  break;
                case Anggota.kolomSTATUS:
                  data[key[j]] = Status.statusID(item[j]);
                  break;
                default:
                  data[key[j]] = item[j];
              }
            }
          }
          listMap.add(data);
        }
        for (var item in listMap) {
          await _db.insert(Anggota.tableName, item,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        Get.find<DataController>().fetchData();
        Get.snackbar("Berhasil!", "Data berhasil diimport",
            backgroundColor: Get.theme.secondaryHeaderColor);
      }
    } catch (e) {
      Get.snackbar("Oops!", e.toString(),
          backgroundColor: Get.theme.secondaryHeaderColor);
    }
  }
}
