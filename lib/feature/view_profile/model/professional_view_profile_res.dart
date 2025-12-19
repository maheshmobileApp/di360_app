class ProfessionalViewProfileRes {
  ProfessionalData? data;

  ProfessionalViewProfileRes({this.data});

  ProfessionalViewProfileRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfessionalData.fromJson(json['data']) : null;
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
  String? professionType;
  Address? address;
  String? proDetailsAphraRegistrationNumber;
  BankDetails? bankDetails;
  String? dateOfBirth;
  String? salutation;
  dynamic drivingLicence;
  ProfileImage? profileImage;
  String? gender;
  String? type;
  Clients? clients;
  List<Directories>? directories;
  String? sTypename;

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
      this.address,
      this.proDetailsAphraRegistrationNumber,
      this.bankDetails,
      this.dateOfBirth,
      this.salutation,
      this.drivingLicence,
      this.profileImage,
      this.gender,
      this.type,
      this.clients,
      this.directories,
      this.sTypename});

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
    professionType = json['profession_type'];
    address = json['address'] != null && json['address'] is Map<String, dynamic>
        ? new Address.fromJson(json['address'])
        : null;
    proDetailsAphraRegistrationNumber =
        json['pro_details_aphra_registration_number'];
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
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
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
    data['profession_type'] = this.professionType;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
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
    if (this.clients != null) {
      data['clients'] = this.clients!.toJson();
    }
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? country;
  String? zipcode;
  double? latitude;
  double? longitude;
  String? addressName;

  Address(
      {this.city,
      this.state,
      this.country,
      this.zipcode,
      this.latitude,
      this.longitude,
      this.addressName});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressName = json['addressName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['addressName'] = this.addressName;
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

class Clients {
  dynamic state;
  dynamic postalCode;
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

class Directories {
  String? id;
  String? name;
  String? email;
  String? phone;
  ProfileImage? profileImage;
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
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
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
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['address'] = this.address;
    data['profession_type'] = this.professionType;
    data['__typename'] = this.sTypename;
    return data;
  }
}
