import 'package:data_warga/controller/controller.dart';
import 'package:data_warga/data/database/filter_anggota.dart';
import 'package:data_warga/routes/routes.dart';
import 'package:data_warga/widget/list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<DataController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 1. look for an ancestor Scaffold
    final ancestorScaffold = Scaffold.maybeOf(context);
    // 2. check if it has a drawer
    final hasDrawer = ancestorScaffold != null && ancestorScaffold.hasDrawer;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(32)),
              child: Row(
                children: [
                  hasDrawer
                      ? InkWell(
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Icon(Icons.menu),
                          ),
                          // 4. open the drawer if we have one
                          onTap: hasDrawer
                              ? () => ancestorScaffold!.openDrawer()
                              : null,
                        )
                      : Container(),
                  Expanded(
                    child: TextFormField(
                      controller: controller.searchController,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(14),
                        hintText: "Cari Data",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.searchController.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(Icons.clear),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Routes.addData)!
                .then((value) => controller.fetchData());
          },
          label: const Text('Input/Edit'),
          icon: const Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      filter(context,
                          label: "Urutkan",
                          icon: Icons.filter_alt,
                          active: controller.order != FilterAnggota.noOrder,
                          onTap: () {
                        Get.defaultDialog(
                            title: "Urutkan data berdasarkan",
                            content: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: filter(context,
                                      label: "No. Rumah",
                                      active: controller.order ==
                                          FilterAnggota.orderNomerRumah,
                                      onTap: () {
                                    controller.order =
                                        FilterAnggota.orderNomerRumah;
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: filter(context,
                                      label: "Domisili",
                                      active: controller.order ==
                                          FilterAnggota.orderDomisili,
                                      onTap: () {
                                    controller.order =
                                        FilterAnggota.orderDomisili;
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: filter(context,
                                      label: "Nama",
                                      active: controller.order ==
                                          FilterAnggota.orderNama, onTap: () {
                                    controller.order = FilterAnggota.orderNama;
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: filter(context,
                                      label: "Tanggal Lahir",
                                      active: controller.order ==
                                          FilterAnggota.orderTanggalLahir,
                                      onTap: () {
                                    controller.order =
                                        FilterAnggota.orderTanggalLahir;
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: filter(context, label: "Batalkan",
                                      onTap: () {
                                    controller.order = FilterAnggota.noOrder;
                                  }),
                                )
                              ],
                            ));
                      }),
                      filter(context,
                          label: "Semua",
                          active: controller.filter == FilterAnggota.all,
                          onTap: () {
                        controller.filter = FilterAnggota.all;
                        controller.searchController.clear();
                      }),
                      filter(context,
                          label: "Usia Produktif",
                          active: controller.filter ==
                              FilterAnggota.usiaProduktif, onTap: () {
                        controller.filter = FilterAnggota.usiaProduktif;
                      }),
                      filter(context,
                          label: "Usia Lansia",
                          active: controller.filter == FilterAnggota.usiaLansia,
                          onTap: () {
                        controller.filter = FilterAnggota.usiaLansia;
                      }),
                      filter(context,
                          label: "Usia Sekolah",
                          active: controller.filter ==
                              FilterAnggota.usiaSekolah, onTap: () {
                        controller.filter = FilterAnggota.usiaSekolah;
                      }),
                      filter(context,
                          label: "Usia Balita",
                          active: controller.filter == FilterAnggota.usiaBalita,
                          onTap: () {
                        controller.filter = FilterAnggota.usiaBalita;
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return Scrollbar(
                  child: controller.listAnggota.isNotEmpty
                      ? ListView.builder(
                          clipBehavior: Clip.antiAlias,
                          itemCount: controller.listAnggota.length + 1,
                          itemBuilder: (context, i) {
                            if (i < controller.listAnggota.length) {
                              return Stack(
                                children: [
                                  cardAnggota(
                                      anggota: controller.listAnggota[i]),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Theme(
                                        data: Get.theme.copyWith(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        ),
                                        child: PopupMenuButton(
                                            onSelected: (value) {
                                              controller.deleteData(
                                                  controller.listAnggota[i]);
                                            },
                                            itemBuilder: (context) => [
                                                  const PopupMenuItem(
                                                    child: Text("Hapus Data"),
                                                    value: 1,
                                                  ),
                                                ]),
                                      ))
                                ],
                              );
                            } else {
                              return const SizedBox(
                                height: 64,
                              );
                            }
                          })
                      : Center(
                          child: Text(
                            "Tidak ada data",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                );
              }),
            ))
          ],
        ),
      ),
    );
  }

  filter(BuildContext context,
      {required String label,
      bool active = false,
      IconData? icon,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: active ? Colors.amber : null,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: Theme.of(context).dividerColor)),
        child: Center(
          child: Wrap(
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        size: 14,
                      ),
                    )
                  : Container(),
              Center(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: active ? Colors.black : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
