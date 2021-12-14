import 'package:data_warga/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Menggunakan [StatefulWidget] untuk mengambil dan menghapus Controller
///pada saat Screen EditMasterPage tidak dalam tree secara permanen
///yaitu pada saat pindah halaman menu
class EditVariablePage extends StatefulWidget {
  const EditVariablePage({Key? key}) : super(key: key);

  @override
  _EditVariablePageState createState() => _EditVariablePageState();
}

class _EditVariablePageState extends State<EditVariablePage> {
  late EditVariableController controller;
  @override
  initState() {
    controller = Get.put(EditVariableController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<EditVariableController>();
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                controller: controller.textController["RT"],
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                controller: controller.textController["RW"],
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                controller: controller.textController["KEL"],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  label: const Text("KEL"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                controller: controller.textController["KEC"],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  label: const Text("KEC"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                controller: controller.textController["KOTA"],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(14),
                  label: const Text("KOTA"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                onPressed: () async {
                  controller.insertData();
                  FocusScope.of(context).requestFocus(FocusNode());
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
    );
  }
}
