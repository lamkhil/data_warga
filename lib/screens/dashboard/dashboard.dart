import 'package:data_warga/controller/app_controller.dart';
import 'package:data_warga/screens/dashboard/app_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:data_warga/screens/dashboard/app_menu.dart';
export 'package:data_warga/screens/dashboard/menu/home_page.dart';
export 'package:data_warga/screens/dashboard/menu/edit_variable_page.dart';

class Dashboard extends GetView<AppController> {
  const Dashboard({
    Key? key,
    // these values are now configurable with sensible default values
    this.breakpoint = 600,
    this.menuWidth = 240,
  }) : super(key: key);
  final double breakpoint;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= breakpoint) {
      // widescreen: menu on the left, content on the right
      return WillPopScope(
        onWillPop: () async {
          if (controller.selectedPage != controller.availablePages.keys.first) {
            controller.selectedPage = controller.availablePages.keys.first;
            if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
              Navigator.of(context).pop();
            }
            return false;
          } else {
            return true;
          }
        },
        child: Row(
          children: [
            SizedBox(
              width: menuWidth,
              child: const AppMenu(),
            ),
            Container(width: 0.5, color: Colors.grey),
            Expanded(
              child: Obx(
                  () => controller.availablePages[controller.selectedPage]!),
            )
          ],
        ),
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return WillPopScope(
        onWillPop: () async {
          if (controller.selectedPage != controller.availablePages.keys.first) {
            controller.selectedPage = controller.availablePages.keys.first;
            if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
              Navigator.of(context).pop();
            }
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Obx(() => controller.availablePages[controller.selectedPage]!),
          drawer: SizedBox(
            width: menuWidth,
            child: const Drawer(
              child: AppMenu(),
            ),
          ),
        ),
      );
    }
  }
}
