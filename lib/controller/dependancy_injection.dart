import 'package:get/get.dart';
import 'package:simro/controller/network_controller.dart';

class DependancyInjection extends GetxController{

   void init() {
   Get.put<NetworkController>(NetworkController(), permanent: true);
  }

  
}