import 'package:data_warga/controller/export_import_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExportImportPage extends StatefulWidget {
  const ExportImportPage({Key? key}) : super(key: key);

  @override
  _ExportImportPageState createState() => _ExportImportPageState();
}

class _ExportImportPageState extends State<ExportImportPage> {
  late ExportImportController controller;
  @override
  void initState() {
    controller = Get.put(ExportImportController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ExportImportController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. look for an ancestor Scaffold
    final ancestorScaffold = Scaffold.maybeOf(context);
    // 2. check if it has a drawer
    final hasDrawer = ancestorScaffold != null && ancestorScaffold.hasDrawer;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Edit Variable Data"),
        leading: hasDrawer
            ? InkWell(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Icon(Icons.menu),
                ),
                // 4. open the drawer if we have one
                onTap: hasDrawer ? () => ancestorScaffold!.openDrawer() : null,
              )
            : Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.open();
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Import Data",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.openString();
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Import Data String",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.save(controller.dataAnggota, 'txt');
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Export Data TXT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.save(controller.dataAnggotaString, 'txt');
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Export Data String TXT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.save(controller.dataAnggota, 'csv');
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Export Data CSV",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                  onPressed: () async {
                    controller.save(controller.dataAnggotaString, 'csv');
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Export Data String CSV",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))),
            ],
          ),
        ),
      ),
    );
  }
}
