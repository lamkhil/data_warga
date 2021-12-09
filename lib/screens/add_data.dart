import 'package:data_warga/controller/controller.dart';
import 'package:data_warga/data/models/anggota.dart';
import 'package:data_warga/data/models/domisili.dart';
import 'package:data_warga/data/models/jenis_kelamin.dart';
import 'package:data_warga/data/models/pekerjaan.dart';
import 'package:data_warga/data/models/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddData extends GetView<AddDataController> {
  AddData({Key? key}) : super(key: key);

  @override
  final AddDataController controller = Get.put(AddDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Input/Edit Data",
              style: Theme.of(context).textTheme.headline6),
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  controller.clearAddData();
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text("Bersihkan Kolom"),
                        value: 1,
                      ),
                    ])
          ],
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.isUpdateFrom,
                          controller:
                              controller.textController[Anggota.kolomNORUMAH],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("No. Rumah"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.isUpdateFrom,
                          controller:
                              controller.textController[Anggota.kolomRT],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("RT"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.isUpdateFrom,
                          controller:
                              controller.textController[Anggota.kolomRW],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("RW"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          onChanged: controller.isUpdateFrom
                              ? (val) {
                                  controller.setAddData(
                                      Anggota.kolomSTATUS, val);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              : null,
                          value: controller.addData[Anggota.kolomSTATUS] != ''
                              ? controller.addData[Anggota.kolomSTATUS]
                                  .toString()
                              : null,
                          items: List.generate(
                              Status.status.length,
                              (index) => DropdownMenuItem(
                                  value: Status.status[index + 1].toString(),
                                  child: Text(
                                      Status.status[index + 1].toString()))),
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Status"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.nextInput,
                          controller:
                              controller.textController[Anggota.kolomNIK],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("NIK"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.nextInput,
                          controller:
                              controller.textController[Anggota.kolomNAMA],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Nama"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          enabled: controller.nextInput,
                          onTap: controller.nextInput
                              ? () {
                                  // Below line stops keyboard from appearing
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  // selectDate
                                  _selectDate(context);
                                }
                              : null,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(14),
                              label: Obx(() => Text(controller
                                          .addData[Anggota.kolomTGLLAHIR] !=
                                      ''
                                  ? controller.addData[Anggota.kolomTGLLAHIR]
                                      .toString()
                                  : "Tanggal Lahir")),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(),
                              ),
                              suffixIcon: const Icon(Icons.date_range)),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          onChanged: controller.nextInput
                              ? (val) {
                                  controller.setAddData(Anggota.kolomJK, val);

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              : null,
                          value: controller.addData[Anggota.kolomJK] != ''
                              ? controller.addData[Anggota.kolomJK].toString()
                              : null,
                          items: List.generate(
                              JK.jk.length,
                              (index) => DropdownMenuItem(
                                  value: JK.jk[index + 1].toString(),
                                  child: Text(JK.jk[index + 1].toString()))),
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Jenis Kelamin"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          onChanged: controller.nextInput
                              ? (val) {
                                  controller.setAddData(
                                      Anggota.kolomPEKERJAAN, val);

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              : null,
                          value:
                              controller.addData[Anggota.kolomPEKERJAAN] != ''
                                  ? controller.addData[Anggota.kolomPEKERJAAN]
                                      .toString()
                                  : null,
                          items: List.generate(
                              Pekerjaan.pekerjaan.length,
                              (index) => DropdownMenuItem(
                                  value:
                                      Pekerjaan.pekerjaan[index + 1].toString(),
                                  child: Text(Pekerjaan.pekerjaan[index + 1]
                                      .toString()))),
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Pekerjaan"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => TextFormField(
                          maxLines: 3,
                          textInputAction: TextInputAction.go,
                          enabled: controller.nextInput,
                          controller:
                              controller.textController[Anggota.kolomALAMAT],
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Alamat"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          onChanged: controller.nextInput
                              ? (val) {
                                  controller.setAddData(
                                      Anggota.kolomDOMISILI, val);

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              : null,
                          value: controller.addData[Anggota.kolomDOMISILI] != ''
                              ? controller.addData[Anggota.kolomDOMISILI]
                                  .toString()
                              : null,
                          items: List.generate(
                              Domisili.domisili.length,
                              (index) => DropdownMenuItem(
                                  value:
                                      Domisili.domisili[index + 1].toString(),
                                  child: Text(Domisili.domisili[index + 1]
                                      .toString()))),
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(14),
                            label: const Text("Domisili"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      onPressed: () async {
                        if (controller.addData.containsValue("")) {
                          Get.defaultDialog(
                              title: "Oops!",
                              middleText: "Tidak boleh ada form kosong");
                        } else {
                          await controller
                              .insertData(Anggota.fromMap(controller.addData));
                        }
                      },
                      child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Simpan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))))
                ],
              ),
            ),
          ),
        ));
  }

  Future _selectDate(BuildContext context) async {
    String tgl = controller.addData[Anggota.kolomTGLLAHIR];
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tgl != "" ? DateTime.parse(tgl) : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2055));
    if (picked != null) {
      String val = DateFormat('yyyy-MM-dd').format(picked);
      controller.setAddData(Anggota.kolomTGLLAHIR, val);
    }
  }
}
