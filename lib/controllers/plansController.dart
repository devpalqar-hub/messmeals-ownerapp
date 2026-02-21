import 'package:get/get.dart';
import '../models/mess_plan_model.dart';
import '../service/api_service.dart';

class PlansController extends GetxController {
  List<MessPlanModel> messPlanList = [];
  bool isMessPlanLoading = false;

  /// ⭐ FETCH PLANS WITH MESS ID
  Future<void> fetchMessPlan(String messId) async {
    try {
      messPlanList.clear();
      isMessPlanLoading = true;
      update();

      final response = await ApiService.getPlans(messId);

      if (response["data"] != null) {
        for (var data in response["data"]) {
          messPlanList.add(MessPlanModel.fromJson(data));
        }
      }

      isMessPlanLoading = false;
      update();

    } catch (e) {
      isMessPlanLoading = false;
      update();
      print("Plans error: $e");
    }
  }
}