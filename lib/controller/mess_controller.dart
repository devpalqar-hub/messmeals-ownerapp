import 'package:get/get.dart';
import '../service/api_service.dart';

class MessController extends GetxController {
  RxList<dynamic> messList = <dynamic>[].obs;
  RxString selectedMessId = "".obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchMesses();
    super.onInit();
  }

  Future<void> fetchMesses() async {
    try {
      isLoading.value = true;

      final data = await ApiService.getAllMesses();

      messList.value = data;

      if (messList.isNotEmpty) {
        selectedMessId.value = messList.first["_id"].toString();
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Mess fetch error: $e");
    }
  }

  void changeMess(String id) {
    selectedMessId.value = id;
  }
}