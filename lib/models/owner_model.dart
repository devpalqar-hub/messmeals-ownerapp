class OwnerModel {
  final String name;
  final String phone;
  final String email;
  final String status;
  final int total;
  final String location;

  OwnerModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.total,
    required this.location,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['name'] ?? json['full_name'] ?? "Unknown",
      phone: json['phone'] ?? json['mobile'] ?? "",
      email: json['email'] ?? "",
      status: json['status'] ?? "inactive",
      total: json['total'] ?? json['total_mess'] ?? 0,
      location: json['location'] ?? json['city'] ?? "",
    );
  }
}
