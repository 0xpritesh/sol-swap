class AirDropResponse {
  String? jsonrpc;
  String? result;
  int? id;

  AirDropResponse({this.jsonrpc, this.result, this.id});

  AirDropResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result = json['result'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['result'] = this.result;
    data['id'] = this.id;
    return data;
  }
}
