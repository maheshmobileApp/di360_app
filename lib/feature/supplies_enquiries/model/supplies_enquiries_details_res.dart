class SuppliesEnquiriesDetails {
  SuppliesEnquiriesDetailsData? data;

  SuppliesEnquiriesDetails({this.data});

  SuppliesEnquiriesDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SuppliesEnquiriesDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SuppliesEnquiriesDetailsData {
  SupplyEnquiriesByPk? supplyEnquiriesByPk;

  SuppliesEnquiriesDetailsData({this.supplyEnquiriesByPk});

  SuppliesEnquiriesDetailsData.fromJson(Map<String, dynamic> json) {
    supplyEnquiriesByPk = json['supply_enquiries_by_pk'] != null
        ? new SupplyEnquiriesByPk.fromJson(json['supply_enquiries_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyEnquiriesByPk != null) {
      data['supply_enquiries_by_pk'] = this.supplyEnquiriesByPk!.toJson();
    }
    return data;
  }
}

class SupplyEnquiriesByPk {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? supplyId;
  Supply? supply;
  String? supplyVariantId;
  SupplyVariant? supplyVariant;
  String? message;
  List<dynamic>? attachments;
  Null? reply;
  Null? replyAttachments;
  String? type;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  String? dentalProfessionalId;
  DentalProfessional? dentalProfessional;
  String? dentalPracticeId;
  DentalPractice? dentalPractice;
  String? sTypename;

  SupplyEnquiriesByPk(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.supplyId,
      this.supply,
      this.supplyVariantId,
      this.supplyVariant,
      this.message,
      this.attachments,
      this.reply,
      this.replyAttachments,
      this.type,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.dentalProfessionalId,
      this.dentalProfessional,
      this.dentalPracticeId,
      this.dentalPractice,
      this.sTypename});

  SupplyEnquiriesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplyId = json['supply_id'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    supplyVariantId = json['supply_variant_id'];
    supplyVariant = json['supply_variant'] != null
        ? new SupplyVariant.fromJson(json['supply_variant'])
        : null;
    message = json['message'];
    attachments = json['attachments'];
    reply = json['reply'];
    replyAttachments = json['reply_attachments'];
    type = json['type'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessionalId = json['dental_professional_id'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    dentalPracticeId = json['dental_practice_id'];
    dentalPractice = json['dental_practice'] != null
        ? new DentalPractice.fromJson(json['dental_practice'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['supply_id'] = this.supplyId;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    data['supply_variant_id'] = this.supplyVariantId;
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant!.toJson();
    }
    data['message'] = this.message;
    data['attachments'] = this.attachments;
    data['reply'] = this.reply;
    data['reply_attachments'] = this.replyAttachments;
    data['type'] = this.type;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_professional'] = this.dentalProfessional;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_practice'] = this.dentalPractice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? id;
  String? name;
  List<Image>? image;
  SupplyBrand? supplyBrand;
  SupplyBrand? supplyCategory;
  SupplyBrand? supplySubCategory;
  String? sTypename;

  Supply(
      {this.id,
      this.name,
      this.image,
      this.supplyBrand,
      this.supplyCategory,
      this.supplySubCategory,
      this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    supplyBrand = json['supply_brand'] != null
        ? new SupplyBrand.fromJson(json['supply_brand'])
        : null;
    supplyCategory = json['supply_category'] != null
        ? new SupplyBrand.fromJson(json['supply_category'])
        : null;
    supplySubCategory = json['supply_sub_category'] != null
        ? new SupplyBrand.fromJson(json['supply_sub_category'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.supplyBrand != null) {
      data['supply_brand'] = this.supplyBrand!.toJson();
    }
    if (this.supplyCategory != null) {
      data['supply_category'] = this.supplyCategory!.toJson();
    }
    if (this.supplySubCategory != null) {
      data['supply_sub_category'] = this.supplySubCategory!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Image {
  String? url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class SupplyBrand {
  String? id;
  String? name;
  String? sTypename;

  SupplyBrand({this.id, this.name, this.sTypename});

  SupplyBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyVariant {
  String? id;
  String? title;
  Null? image;
  dynamic? actualPrice;
  dynamic? sellingPrice;
  String? sTypename;

  SupplyVariant(
      {this.id,
      this.title,
      this.image,
      this.actualPrice,
      this.sellingPrice,
      this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    actualPrice = json['actual_price'];
    sellingPrice = json['selling_price'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['actual_price'] = this.actualPrice;
    data['selling_price'] = this.sellingPrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? sTypename;

  DentalSupplier({this.id, this.name, this.email, this.phone, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalProfessional {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? sTypename;

  DentalProfessional(
      {this.id, this.name, this.email, this.phone, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalPractice {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? sTypename;

  DentalPractice({this.id, this.name, this.email, this.phone, this.sTypename});

  DentalPractice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }
}
