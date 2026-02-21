import 'package:get/get.dart';
import '../models/mess_plan_model.dart';
import '../service/api_service.dart';

class PlansController extends GetxController {
  List<MessPlanModel> messPlanList = [];
  bool isMessPlanLoading = false;

  Future<void> fetchMessPlan(String messId) async {
    try {
      print("Fetching plans for messId: $messId");

      messPlanList.clear();
      isMessPlanLoading = true;
      update();

      final response = await ApiService.getPlans(messId);

      print("Plans API response: $response");

      List dataList = [];

      if (response["data"] is List) {
        dataList = response["data"];
      } else if (response["data"] is Map && response["data"]["items"] != null) {
        dataList = response["data"]["items"];
      }

      for (var data in dataList) {
        messPlanList.add(MessPlanModel.fromJson(data));
      }

      print("Parsed plans count: ${messPlanList.length}");

      isMessPlanLoading = false;
      update();

    } catch (e) {
      isMessPlanLoading = false;
      update();
      print("Plans error: $e");
    }
  }
}