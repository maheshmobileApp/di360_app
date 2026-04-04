class PracticesViewProfileRes {
  PracticeProfileData? data;

  PracticesViewProfileRes({this.data});

  PracticesViewProfileRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PracticeProfileData.fromJson(json['data'])
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

class PracticeProfileData {
  DentalPracticesByPk? dentalPracticesByPk;

  PracticeProfileData({this.dentalPracticesByPk});

  PracticeProfileData.fromJson(Map<String, dynamic> json) {
    dentalPracticesByPk = json['dental_practices_by_pk'] != null
        ? new DentalPracticesByPk.fromJson(json['dental_practices_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalPracticesByPk != null) {
      data['dental_practices_by_pk'] = this.dentalPracticesByPk!.toJson();
    }
    return data;
  }
}

class DentalPracticesByPk {
  String? id;
  String? email;
  String? name;
  Logo? logo;
  String? phone;
  String? address;
  String? city;
  int? zipcode;
  String? state;
  String? country;
  String? landMark;
  String? addressLineOne;
  String? addressLineTwo;
  String? proDetailsAphraRegistrationNumber;
  dynamic bankDetails; //null
  String? businessName;
  String? abnNumber;
  String? businessEmail;
  String? businessPhone;
  String? faxNumber;
  String? altEmail;
  String? altPhone;
  String? professionType;
  String? tgaNumber;
  bool? secondHand;
  bool? sellProducts;
  String? firstName;
  String? middleName;
  String? lastName;
  String? type;
  dynamic secondaryContact; //skip it
  String? sTypename;
  String? websiteLink;
  String? mobileNumber;
  List<Directories>? directories;

  DentalPracticesByPk(
      {this.id,
      this.email,
      this.name,
      this.logo,
      this.phone,
      this.address,
      this.city,
      this.zipcode,
      this.state,
      this.country,
      this.landMark,
      this.addressLineOne,
      this.addressLineTwo,
      this.proDetailsAphraRegistrationNumber,
      this.bankDetails,
      this.businessName,
      this.abnNumber,
      this.businessEmail,
      this.businessPhone,
      this.faxNumber,
      this.altEmail,
      this.altPhone,
      this.professionType,
      this.tgaNumber,
      this.secondHand,
      this.sellProducts,
      this.firstName,
      this.middleName,
      this.lastName,
      this.type,
      this.secondaryContact,
      this.mobileNumber,
      this.websiteLink,
      this.directories});

  DentalPracticesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    zipcode = json['zipcode'];
    state = json['state'];
    country = json['country'];
    landMark = json['land_mark'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    proDetailsAphraRegistrationNumber =
        json['pro_details_aphra_registration_number'];
    bankDetails = json['bank_details'];
    businessName = json['business_name'];
    abnNumber = json['abn_number'];
    businessEmail = json['business_email'];
    businessPhone = json['business_phone'];
    faxNumber = json['fax_number'];
    altEmail = json['alt_email'];
    altPhone = json['alt_phone'];
    professionType = json['profession_type'];
    tgaNumber = json['tga_number'];
    secondHand = json['second_hand'];
    sellProducts = json['sell_products'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    type = json['type'];
    secondaryContact = json['secondary_contact'];
    sTypename = json['__typename'];
    mobileNumber = json['mobile_number'];
    websiteLink = json['website_link'];
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['pro_details_aphra_registration_number'] =
        this.proDetailsAphraRegistrationNumber;
    data['bank_details'] = this.bankDetails;
    data['business_name'] = this.businessName;
    data['abn_number'] = this.abnNumber;
    data['business_email'] = this.businessEmail;
    data['business_phone'] = this.businessPhone;
    data['fax_number'] = this.faxNumber;
    data['alt_email'] = this.altEmail;
    data['alt_phone'] = this.altPhone;
    data['profession_type'] = this.professionType;
    data['tga_number'] = this.tgaNumber;
    data['second_hand'] = this.secondHand;
    data['sell_products'] = this.sellProducts;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['type'] = this.type;
    data['secondary_contact'] = this.secondaryContact;
    data['__typename'] = this.sTypename;
    data['address_line_one'] = this.addressLineOne;
    data['address_line_two'] = this.addressLineTwo;
    data['mobile_number'] = this.mobileNumber;
    data['website_link'] = this.websiteLink;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Logo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Logo.fromJson(Map<String, dynamic> json) {
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

class Directories {
  String? id;
  String? name;
  String? email;
  String? phone;
  dynamic profileImage;
  String? address;
  String? professionType;
  String? sTypename;

  Directories(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.profileImage,
      this.address,
      this.professionType,
      this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    address = json['address'];
    professionType = json['profession_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['profession_type'] = this.professionType;
    data['__typename'] = this.sTypename;
    return data;
  }
}
