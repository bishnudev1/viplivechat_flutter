import 'dart:convert';

UpdatefcmModel updatefcmModelFromJson(String str) =>
    UpdatefcmModel.fromJson(json.decode(str));
String updatefcmModelToJson(UpdatefcmModel data) => json.encode(data.toJson());

class UpdatefcmModel {
  UpdatefcmModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  UpdatefcmModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  UpdatefcmModel copyWith({
    bool? status,
    String? message,
  }) =>
      UpdatefcmModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
