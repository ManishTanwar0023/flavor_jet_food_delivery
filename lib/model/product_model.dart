class Product{
  int? totalSize;
  int? typeId;
  int? offset;
  List<ProductModel>? products;
  List<ProductModel>? get productData => products;

  Product({
    required totelSize,
    required typeId,
    required offset,
    required product
}){
    this.totalSize = totelSize;
    this.typeId = typeId;
    this.offset = offset;
    this.products = product;
  }

  Product.fromJson(Map<String,dynamic> json){
    totalSize = json['totel_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    if(json['products']!= null){
      products = <ProductModel>[];
      json['products'].forEach((v){
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

  // Map<String,dynamic> toJson(){
  //   final Map<String,dynamic> data = new Map<String,dynamic>();
  //   data['totel_size'] = this.totelSize;
  //   data['type_id'] = this.typeId;
  //   data['offset'] = this.offset;
  //   if(this.product!= null){
  //     data['product'] = this.product!.map((v) => v.toJson()).toString();
  //   }
  //   return data;
  // }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? image;
  String? location;
  String? createAt;
  String? updateAt;
  int? typeId;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.image,
    this.location,
    this.typeId,
    this.createAt,
    this.updateAt
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    image = json['image']; // Adjust if the key from the API is different
    location = json['location'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    typeId = json['type_id'];
  }

  Map<String,dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "stars": this.stars,
      "image": this.image,
      "location": this.location,
      "createAt": this.createAt,
      "updateAt": this.updateAt,
      "typeId": this.typeId,
    };
  }

}
