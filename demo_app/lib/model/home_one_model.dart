class HomeOneModel {
  bool? status;
  String? message;
  List<Banner>? banner;
  List<Services>? services;

  HomeOneModel({this.status, this.message, this.banner, this.services});

  HomeOneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(new Banner.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  bool? isDeleted;
  String? sId;
  String? imageUrl;
  String? name;
  String? imageName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Banner(
      {this.isDeleted,
        this.sId,
        this.imageUrl,
        this.name,
        this.imageName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Banner.fromJson(Map<String, dynamic> json) {
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    imageUrl = json['image_url'];
    name = json['name'];
    imageName = json['image_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_deleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    data['image_name'] = this.imageName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Services {
  bool? isDeleted;
  String? sId;
  String? imageUrl;
  String? name;
  String? backgroundColor;
  String? code;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? amount;

  Services(
      {this.isDeleted,
        this.sId,
        this.imageUrl,
        this.name,
        this.backgroundColor,
        this.code,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.amount});

  Services.fromJson(Map<String, dynamic> json) {
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    imageUrl = json['image_url'];
    name = json['name'];
    backgroundColor = json['background_color'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_deleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    data['background_color'] = this.backgroundColor;
    data['code'] = this.code;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['amount'] = this.amount;
    return data;
  }
}
