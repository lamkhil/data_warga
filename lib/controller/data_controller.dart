import 'package:data_warga/data/database/database_helper.dart';
import 'package:data_warga/data/database/filter_anggota.dart';
import 'package:data_warga/data/models/anggota.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DataController extends GetxController {
  ///######### Variable Declaration #########

  //Database
  final Database _db = DatabaseHandler.instance;

  ///Reactive List variable dengan GetX
  final RxList<Anggota> _listAnggota = RxList<Anggota>();

  ///Variable list anggota yang bersifat reaktif dengan GetX
  List<Anggota> get listAnggota => _listAnggota;
  set listAnggota(value) => _listAnggota.value = value;

  TextEditingController searchController = TextEditingController();

  ///Variabel Filter untuk filter data
  final _filter = "".obs;
  String get filter => _filter.value;
  set filter(val) {
    _filter.value = val;
    fetchData();
  }

  final _order = "".obs;
  String get order => _order.value;
  set order(val) {
    _order.value = val;
    fetchData();
    Get.back();
  }

  @override
  onInit() async {
    await fetchData();
    searchController.addListener(() {
      var search = FilterAnggota.nama(searchController.text) +
          " or " +
          FilterAnggota.noRumah(searchController.text);
      if (searchController.text != "") {
        filter = search;
      } else {
        filter = FilterAnggota.all;
      }
    });
    super.onInit();
  }

  @override
  onClose() async {
    searchController.dispose();
    super.onClose();
  }

  fetchData() async {
    final List<Map<String, dynamic>> maps = await _db.query(Anggota.tableName,
        where: filter != '' ? filter : null,
        orderBy: order != '' ? order : null);
    listAnggota =
        List.generate(maps.length, (index) => Anggota.fromMap(maps[index]));
  }

  void deleteData(Anggota listAnggota) {
    _db.delete(Anggota.tableName,
        where: "${Anggota.kolomNIK} = ? ", whereArgs: [listAnggota.nik]);
    fetchData();
  }
}
