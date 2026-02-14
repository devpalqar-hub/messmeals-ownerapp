class MessPlanModel {
  String? id;
  String? planName;
  String? price;
  String? minPrice;
  String? description;
  String? messId;
  bool? isMonthlyPlan;
  bool? isDailyPlan;
  bool? isActive;
  List<Images>? images;
  List<Variation>? variation;

  MessPlanModel(
      {this.id,
      this.planName,
      this.price,
      this.minPrice,
      this.description,
      this.messId,
      this.isMonthlyPlan,
      this.isDailyPlan,
      this.isActive,
      this.images,
      this.variation});

  MessPlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['planName'];
    price = json['price'];
    minPrice = json['minPrice'];
    description = json['description'];
    messId = json['messId'];
    isMonthlyPlan = json['isMonthlyPlan'];
    isDailyPlan = json['isDailyPlan'];
    isActive = json['isActive'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['Variation'] != null) {
      variation = <Variation>[];
      json['Variation'].forEach((v) {
        variation!.add(new Variation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['planName'] = this.planName;
    data['price'] = this.price;
    data['minPrice'] = this.minPrice;
    data['description'] = this.description;
    data['messId'] = this.messId;
    data['isMonthlyPlan'] = this.isMonthlyPlan;
    data['isDailyPlan'] = this.isDailyPlan;
    data['isActive'] = this.isActive;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['Variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? id;
  String? url;
  int? sortOrder;

  Images({this.id, this.url, this.sortOrder});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}

class Variation {
  String? id;
  String? title;
  String? description;

  Variation({this.id, this.title, this.description});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
