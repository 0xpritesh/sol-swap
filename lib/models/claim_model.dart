class claim_model {
  String? claimedAddresses;

  claim_model({this.claimedAddresses});

  claim_model.fromJson(Map<String, dynamic> json) {
    claimedAddresses = json['claimedAddresses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimedAddresses'] = this.claimedAddresses;
    return data;
  }
}