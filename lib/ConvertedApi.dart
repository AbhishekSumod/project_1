class ConvertedApi {
  String? sId;
  String? name;
  String? quantity;
  int? price; // Change the type to int
  String? createdAt;
  String? star;
  String? updatedAt;
  String? Image;
  String? descrption;
  int? iV;

  ConvertedApi({
    this.sId,
    this.name,
    this.quantity,
    this.price,
    this.Image,
    this.descrption,
    this.createdAt,
    this.updatedAt,
    this.star,
    this.iV,
  });

  ConvertedApi.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    quantity = json['quantity'];
    descrption = json['descrption'];
    price = json['price'];
    Image = json['Image'];
    star = json['star'];
    //Image = json['Image'][0]['hostedLargeUrl'] as String;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['descrption'] = this.descrption;
    data['quantity'] = this.quantity;
    //data['Image'] = this.Image;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
