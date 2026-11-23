class SuppliesEnquiriesRes {
  SuppliesEnquiriesData? data;

  SuppliesEnquiriesRes({this.data});

  SuppliesEnquiriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SuppliesEnquiriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SuppliesEnquiriesData {
  List<SupplyEnquiries>? supplyEnquiries;

  SuppliesEnquiriesData({this.supplyEnquiries});

  SuppliesEnquiriesData.fromJson(Map<String, dynamic> json) {
    if (json['supply_enquiries'] != null) {
      supplyEnquiries = <SupplyEnquiries>[];
      json['supply_enquiries'].forEach((v) {
        supplyEnquiries!.add(new SupplyEnquiries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyEnquiries != null) {
      data['supply_enquiries'] =
          this.supplyEnquiries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplyEnquiries {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? supplyId;
  Supply? supply;
  String? supplyVariantId;
  SupplyVariant? supplyVariant;
  String? message;
  List<Attachments>? attachments;
  String? type;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  String? dentalProfessionalId;
  DentalSupplier? dentalProfessional;
  Null? dentalPracticeId;
  DentalSupplier? dentalPractice;
  String? sTypename;

  SupplyEnquiries(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.supplyId,
      this.supply,
      this.supplyVariantId,
      this.supplyVariant,
      this.message,
      this.attachments,
      this.type,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.dentalProfessionalId,
      this.dentalProfessional,
      this.dentalPracticeId,
      this.dentalPractice,
      this.sTypename});

  SupplyEnquiries.fromJson(Map<String, dynamic> json) {
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
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    type = json['type'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessionalId = json['dental_professional_id'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalSupplier.fromJson(json['dental_professional'])
        : null;
    dentalPracticeId = json['dental_practice_id'];
    dentalPractice = json['dental_practice'];
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
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_professional_id'] = this.dentalProfessionalId;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
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
  String? sTypename;

  Supply({this.id, this.name, this.image, this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
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

class SupplyVariant {
  String? id;
  String? title;
  Null? image;
  String? sTypename;

  SupplyVariant({this.id, this.title, this.image, this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Attachments {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Attachments(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Attachments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    directory = json['directory'];
    extension = json['extension'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
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
