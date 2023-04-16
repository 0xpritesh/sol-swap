class largetsAccountResponse {
  String? jsonrpc;
  Result? result;
  int? id;

  largetsAccountResponse({this.jsonrpc, this.result, this.id});

  largetsAccountResponse.fromJson(Map<String, dynamic> json) {
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
  List<Value>? value;

  Result({this.context, this.value});

  Result.fromJson(Map<String, dynamic> json) {
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.context != null) {
      data['context'] = this.context!.toJson();
    }
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
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
  int? lamports;
  String? address;

  Value({this.lamports, this.address});

  Value.fromJson(Map<String, dynamic> json) {
    lamports = json['lamports'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lamports'] = this.lamports;
    data['address'] = this.address;
    return data;
  }
}
