class TotalSupplyResponse {
  String? jsonrpc;
  Result? result;
  int? id;

  TotalSupplyResponse({this.jsonrpc, this.result, this.id});

  TotalSupplyResponse.fromJson(Map<String, dynamic> json) {
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
  int? slot;

  Context({this.slot});

  Context.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    return data;
  }
}

class Value {
  int? circulating;
  int? nonCirculating;
  List<String>? nonCirculatingAccounts;
  int? total;

  Value(
      {this.circulating,
      this.nonCirculating,
      this.nonCirculatingAccounts,
      this.total});

  Value.fromJson(Map<String, dynamic> json) {
    circulating = json['circulating'];
    nonCirculating = json['nonCirculating'];
    nonCirculatingAccounts = json['nonCirculatingAccounts'].cast<String>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['circulating'] = this.circulating;
    data['nonCirculating'] = this.nonCirculating;
    data['nonCirculatingAccounts'] = this.nonCirculatingAccounts;
    data['total'] = this.total;
    return data;
  }
}
