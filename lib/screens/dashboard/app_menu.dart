// a map of ("page name", WidgetBuilder) pairs
import 'package:data_warga/controller/app_controller.dart';
import 'package:data_warga/widget/list_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMenu extends GetView<AppController> {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        // Note: use ListView.builder if there are many items
        children: <Widget>[
          // iterate through the keys to get the page names
          for (var pageName in controller.availablePages.keys)
            Obx(
              () => PageListTile(
                pageName: pageName,
                selectedPageName: controller.selectedPage,
                onPressed: () => _selectPage(context, pageName),
              ),
            ),
          PageListTile(
            pageName: "Ubah Tema",
            onPressed: () {
              Navigator.of(context).pop();
              Get.defaultDialog(
                title: "Pilih Mode Tema",
                content: Wrap(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Radio<int>(
                              value: 0,
                              groupValue: controller.tema,
                              onChanged: (value) {
                                controller.tema = value!;
                              }),
                        ),
                        Text(
                          "Mode System".tr,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Radio<int>(
                              value: 1,
                              groupValue: controller.tema,
                              onChanged: (value) {
                                controller.tema = value!;
                              }),
                        ),
                        Text(
                          "Mode Gelap".tr,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Radio<int>(
                              value: 2,
                              groupValue: controller.tema,
                              onChanged: (value) {
                                controller.tema = value!;
                              }),
                        ),
                        Text(
                          "Mode Terang".tr,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _selectPage(BuildContext context, String pageName) {
    // only change the state if we have selected a different page
    if (controller.selectedPage != pageName) {
      controller.selectedPage = pageName;
      if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
        Navigator.of(context).pop();
      }
    }
  }
}
