class NFT_response {
  Metadata? metadata;
  String? owner;
  int? supply;
  String? type;

  NFT_response({this.metadata, this.owner, this.supply, this.type});

  NFT_response.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    owner = json['owner'];
    supply = json['supply'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['owner'] = this.owner;
    data['supply'] = this.supply;
    data['type'] = this.type;
    return data;
  }
}

class Metadata {
  String? id;
  String? uri;
  String? name;
  String? symbol;
  String? description;
  String? image;
  String? externalUrl;
  String? backgroundColor;

  Metadata(
      {this.id,
      this.uri,
      this.name,
      this.symbol,
      this.description,
      this.image,
      this.externalUrl,
      this.backgroundColor});

  Metadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uri = json['uri'];
    name = json['name'];
    symbol = json['symbol'];
    description = json['description'];
    image = json['image'];
    externalUrl = json['external_url'];
    backgroundColor = json['background_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uri'] = this.uri;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['description'] = this.description;
    data['image'] = this.image;
    data['external_url'] = this.externalUrl;
    data['background_color'] = this.backgroundColor;
    return data;
  }
}