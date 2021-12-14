import 'package:data_warga/controller/controller.dart';
import 'package:data_warga/data/models/anggota.dart';
import 'package:data_warga/data/models/domisili.dart';
import 'package:data_warga/data/models/jenis_kelamin.dart';
import 'package:data_warga/data/models/pekerjaan.dart';
import 'package:data_warga/data/models/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  late AddDataController controller;

  @override
  void dispose() {
    Get.delete<AddDataController>();
    super.dispose();
  }

  @override
  void initState() {
    controller = Get.put(AddDataController());
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 1. look for an ancestor Scaffold
    final ancestorScaffold = Scaffold.maybeOf(context);
    // 2. check if it has a drawer
    final hasDrawer = ancestorScaffold != null && ancestorScaffold.hasDrawer;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: hasDrawer
              ? InkWell(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Icon(Icons.menu),
                  ),
                  // 4. open the drawer if we have one
                  onTap:
                      hasDrawer ? () => ancestorScaffold!.openDrawer() : null,
                )
              : Container(),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Obx(
                          () => TextFormField(
                            enabled: controller.isUpdateFrom,
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
                            value: controller.addData[Anggota.kolomSTATUS],
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
                            controller: controller
                                .textController[Anggota.kolomTGLLAHIR],
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
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Tidak boleh Kosong';
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(14),
                                label: const Text("Tanggal Lahir"),
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
                            value: controller.addData[Anggota.kolomJK],
                            validator: (value) {
                              if (value == null) {
                                return 'Tidak boleh Kosong';
                              }
                            },
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
                            validator: (value) {
                              if (value == null) {
                                return 'Tidak boleh Kosong';
                              }
                            },
                            value: controller.addData[Anggota.kolomPEKERJAAN],
                            items: List.generate(
                                Pekerjaan.pekerjaan.length,
                                (index) => DropdownMenuItem(
                                    value: Pekerjaan.pekerjaan[index + 1]
                                        .toString(),
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
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Tidak boleh Kosong';
                              }
                            },
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
                            validator: (value) {
                              if (value == null) {
                                return 'Tidak boleh Kosong';
                              }
                            },
                            value: controller.addData[Anggota.kolomDOMISILI],
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
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Obx(
                          () => TextFormField(
                            maxLines: 3,
                            textInputAction: TextInputAction.go,
                            enabled: controller.nextInput,
                            controller:
                                controller.textController[Anggota.kolomCATATAN],
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(14),
                              label: const Text("Catatan"),
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
                    Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        onPressed: controller.nextInput
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  if (controller.addData.containsValue("")) {
                                    Get.defaultDialog(
                                      title: "Oops!",
                                      middleText:
                                          "Ada form kosong, Lanjut Simpan data?",
                                      textCancel: "Tidak",
                                      textConfirm: "Simpan",
                                      confirmTextColor:
                                          Get.theme.scaffoldBackgroundColor,
                                      onCancel: () => Get.back(),
                                      onConfirm: () async {
                                        Get.back();
                                        await controller.insertData(
                                            Anggota.fromMap(
                                                controller.addData));
                                      },
                                    );
                                  } else {
                                    await controller.insertData(
                                        Anggota.fromMap(controller.addData));
                                  }
                                }
                              }
                            : null,
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Simpan",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )))))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future _selectDate(BuildContext context) async {
    String tgl = controller.addData[Anggota.kolomTGLLAHIR] ?? "";
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tgl != "" ? DateTime.parse(tgl) : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2055));
    if (picked != null) {
      String val = DateFormat('yyyy-MM-dd').format(picked);
      controller.textController[Anggota.kolomTGLLAHIR]!.text = val;
    }
  }
}
