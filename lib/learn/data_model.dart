class DataModel {
  int? code;
  Data? data;
  String? msg;

  DataModel({this.code, this.data, this.msg});
  @override
  String toString() {
    return 'code:$code; data:${data.toString()}; msg:$msg';
  }

  DataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  int? code;
  String? method;
  JsonParams? jsonParams;

  Data({this.code, this.method, this.jsonParams});
  @override
  String toString() {
    return 'data_code:$code; method:$method; jsonParams:${jsonParams.toString()}';
  }

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    method = json['method'];
    jsonParams =
        json['jsonParams'] != null
            ? JsonParams.fromJson(json['jsonParams'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['method'] = method;
    if (jsonParams != null) {
      data['jsonParams'] = jsonParams!.toJson();
    }
    return data;
  }
}

class JsonParams {
  String? jsonData;

  JsonParams({this.jsonData});
  @override
  String toString() {
    return 'jsonData: $jsonData';
  }

  JsonParams.fromJson(Map<String, dynamic> json) {
    jsonData = json['jsonData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonData'] = jsonData;
    return data;
  }
}
