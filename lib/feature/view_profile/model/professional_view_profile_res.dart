import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';

class ProfessionalViewProfileRes {
  ProfessionalData? data;

  ProfessionalViewProfileRes({this.data});

  ProfessionalViewProfileRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ProfessionalData.fromJson(json['data'])
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

class ProfessionalData {
  DentalProfessionalsByPk? dentalProfessionalsByPk;

  ProfessionalData({this.dentalProfessionalsByPk});

  ProfessionalData.fromJson(Map<String, dynamic> json) {
    dentalProfessionalsByPk = json['dental_professionals_by_pk'] != null
        ? new DentalProfessionalsByPk.fromJson(
            json['dental_professionals_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalProfessionalsByPk != null) {
      data['dental_professionals_by_pk'] =
          this.dentalProfessionalsByPk!.toJson();
    }
    return data;
  }
}

class Professiontype {
  String? id;
  String? name;
  String? sTypename;

  Professiontype({this.id, this.name, this.sTypename});

  Professiontype.fromJson(Map<String, dynamic> json) {
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

class DentalProfessionalsByPk {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? firstName;
  String? middleName;
  String? lastName;
  bool? secondHand;
  String? altEmail;
  dynamic altPhone;
  Professiontype? professionType;
  DirectoryCategories? professiontype;
  String? directoryCategoryId;
  String? proDetailsAphraRegistrationNumber;
  String? aphraRegistrationNumber;
  BankDetails? bankDetails; //Todo remove this in feature
  String? dateOfBirth;
  String? salutation;
  dynamic drivingLicence; // Todo
  ProfileImage? profileImage; // Todo
  String? gender;
  String? type;
  String? address;
  String? city;
  int? zipcode;
  String? state;
  String? country;
  String? addressLineOne;
  String? addressLineTwo;
  String? landMark;
  Clients? clients; // table name is clients
  List<Directories>? directories;
  String? sTypename;
  String? directoryBusinessTypeId;

  DentalProfessionalsByPk(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.firstName,
      this.middleName,
      this.lastName,
      this.secondHand,
      this.altEmail,
      this.altPhone,
      this.professionType,
      this.professiontype,
      this.directoryCategoryId,
      this.proDetailsAphraRegistrationNumber,
      this.aphraRegistrationNumber,
      this.bankDetails,
      this.dateOfBirth,
      this.salutation,
      this.drivingLicence,
      this.profileImage,
      this.gender,
      this.type,
      this.address,
      this.city,
      this.zipcode,
      this.state,
      this.country,
      this.addressLineOne,
      this.addressLineTwo,
      this.landMark,
      this.clients,
      this.directories,
      this.sTypename,
      this.directoryBusinessTypeId});

  DentalProfessionalsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    secondHand = json['second_hand'];
    altEmail = json['alt_email'];
    altPhone = json['alt_phone'];
    professionType = json['professionType'] != null
        ? new Professiontype.fromJson(json['professionType'])
        : null;

    professiontype = json['professionType'] != null
        ? new DirectoryCategories.fromJson(json['professionType'])
        : null;
    directoryCategoryId = json['directory_category_id'];
    proDetailsAphraRegistrationNumber =
        json['pro_details_aphra_registration_number'];
    aphraRegistrationNumber = json['aphra_registration_number'];
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
    dateOfBirth = json['date_of_birth'];
    salutation = json['salutation'];
    drivingLicence = json['driving_licence'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    gender = json['gender'];
    type = json['type'];
    if (json['address'] is String) {
      address = json['address'];
    }
    city = json['city'];
    zipcode = json['zipcode'];
    state = json['state'];
    country = json['country'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    landMark = json['land_mark'];
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
    directoryBusinessTypeId = json['directory_business_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['second_hand'] = this.secondHand;
    data['alt_email'] = this.altEmail;
    data['alt_phone'] = this.altPhone;
    if (this.professionType != null) {
      data['professionType'] = this.professionType!.toJson();
    }

    data['professionType'] = this.professiontype!.toJson();
    data['aphra_registration_number'] = this.aphraRegistrationNumber;
    data['pro_details_aphra_registration_number'] =
        this.proDetailsAphraRegistrationNumber;
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['date_of_birth'] = this.dateOfBirth;
    data['salutation'] = this.salutation;
    data['driving_licence'] = this.drivingLicence;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['address_line_one'] = this.addressLineOne;
    data['address_line_two'] = this.addressLineTwo;
    data['land_mark'] = this.landMark;
    if (this.clients != null) {
      data['clients'] = this.clients!.toJson();
    }
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    data['directory_business_type_id'] = this.directoryBusinessTypeId;
    return data;
  }
}

class Clients {
  String? state;
  String? postalCode;
  String? sTypename;

  Clients({this.state, this.postalCode, this.sTypename});

  Clients.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    postalCode = json['postal_code'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class BankDetails {
  int? bsb;
  String? bankName;
  String? accountNumber;
  String? accountHolderName;

  BankDetails(
      {this.bsb, this.bankName, this.accountNumber, this.accountHolderName});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bsb = json['bsb'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bsb'] = this.bsb;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_holder_name'] = this.accountHolderName;
    return data;
  }
}

class ProfileImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ProfileImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ProfileImage.fromJson(Map<String, dynamic> json) {
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
  ProfileImage? profileImage;
  String? address;
  Professiontype? professionType;
  String? sTypename; // not need can remove this

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
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    address = json['address'];
    professionType = json['professionType'] != null
        ? new Professiontype.fromJson(json['professionType'])
        : null;

    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['address'] = this.address;
    if (this.professionType != null) {
      data['professionType'] = this.professionType!.toJson();
    }

    data['__typename'] = this.sTypename;
    return data;
  }
}
