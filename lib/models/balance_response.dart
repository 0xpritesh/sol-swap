class BalanceResponse {
  String? jsonrpc;
  Result? result;
  int? id;

  BalanceResponse({this.jsonrpc, this.result, this.id});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Result {
  Context? context;
  Value? value;

  Result({this.context, this.value});

  Result.fromJson(Map<String, dynamic> json) {
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.context != null) {
      data['context'] = this.context!.toJson();
    }
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Context {
  String? apiVersion;
  int? slot;

  Context({this.apiVersion, this.slot});

  Context.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiVersion'] = this.apiVersion;
    data['slot'] = this.slot;
    return data;
  }
}

class Value {
  String? data;
  bool? executable;
  int? lamports;
  String? owner;
  int? rentEpoch;

  Value(
      {this.data, this.executable, this.lamports, this.owner, this.rentEpoch});

  Value.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    executable = json['executable'];
    lamports = json['lamports'];
    owner = json['owner'];
    rentEpoch = json['rentEpoch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['executable'] = this.executable;
    data['lamports'] = this.lamports;
    data['owner'] = this.owner;
    data['rentEpoch'] = this.rentEpoch;
    return data;
  }
}
