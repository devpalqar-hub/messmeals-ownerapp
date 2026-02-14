import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:messmeals/main.dart';
import 'package:messmeals/models/mess_plan_model.dart';

class Planscontroller extends GetxController {
  List<MessPlanModel> messPlanList = [];
  TextEditingController planNameController = TextEditingController();

  TextEditingController planPriceController = TextEditingController();
  TextEditingController planDiscountController = TextEditingController();
  TextEditingController planDescriptionController = TextEditingController();
  List<String> selectedPlanVaritation = [];

  bool isMessPlanLoading = true;

  fetchMessPlan() async {
    messPlanList = [];

    isMessPlanLoading = true;
    update();
    var response = await get(Uri.parse(baseUrl + "/plans?page=1&limit=30"));
    if (response.statusCode == 200) {
      var messPlans = json.decode(response.body);
      for (var data in messPlans["data"]) {
        messPlanList.add(MessPlanModel.fromJson(data));
      }

      isMessPlanLoading = false;
      update();
      update();
    }
  }

  addMessPlan() {
    fetchMessPlan();
  }
}
