class viewProfileDataRes {
  profileViewData? data;

  viewProfileDataRes({this.data});

  viewProfileDataRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new profileViewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class profileViewData {
  DentalSuppliersByPk? dentalSuppliersByPk;

  profileViewData({this.dentalSuppliersByPk});

  profileViewData.fromJson(Map<String, dynamic> json) {
    dentalSuppliersByPk = json['dental_suppliers_by_pk'] != null
        ? new DentalSuppliersByPk.fromJson(json['dental_suppliers_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSuppliersByPk != null) {
      data['dental_suppliers_by_pk'] = this.dentalSuppliersByPk!.toJson();
    }
    return data;
  }
}

class DentalSuppliersByPk {
  String? id;
  String? email;
  String? name;
  Logo? logo;
  String? phone;
  String? address;
  String? proDetailsAphraRegistrationNumber;
  BankDetails? bankDetails;
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
  SecondaryContact? secondaryContact;
  String? sTypename;

  DentalSuppliersByPk(
      {this.id,
      this.email,
      this.name,
      this.logo,
      this.phone,
      this.address,
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
      this.sTypename});

  DentalSuppliersByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    phone = json['phone'];
    address = json['address'];
    proDetailsAphraRegistrationNumber =
        json['pro_details_aphra_registration_number'];
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
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
    secondaryContact = json['secondary_contact'] != null
        ? new SecondaryContact.fromJson(json['secondary_contact'])
        : null;
    sTypename = json['__typename'];
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
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
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
    if (this.secondaryContact != null) {
      data['secondary_contact'] = this.secondaryContact!.toJson();
    }
    data['__typename'] = this.sTypename;
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

class BankDetails {
  String? bankName;
  String? accountNumber;
  String? accountHolderName;

  BankDetails({this.bankName, this.accountNumber, this.accountHolderName});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_holder_name'] = this.accountHolderName;
    return data;
  }
}

class SecondaryContact {
  String? name;
  String? email;
  String? phone;

  SecondaryContact({this.name, this.email, this.phone});

  SecondaryContact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
