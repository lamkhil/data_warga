import 'package:data_warga/routes/routes.dart';
import 'package:data_warga/screens/dashboard/menu/add_data.dart';
import 'package:data_warga/screens/dashboard/dashboard.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.dashboard, page: () => const Dashboard()),
  ];
}
