class AddressModel {
  bool? status;
  String? message;
  Data? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? city;
  String? region;
  String? details;
  String? latitude;
  String? longitude;
  String? notes;
  int? id;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
    id = json['id'];
  }
}
