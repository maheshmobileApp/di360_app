import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';

class GetClientsResponse {
  ClientsData? data;

  GetClientsResponse({this.data});

  GetClientsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ClientsData.fromJson(json['data']) : null;
  }
}

class ClientsData {
  List<Clients>? clients;

  ClientsData({this.clients});

  ClientsData.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
  }
}

class Clients {
  String? abnNumber;
  dynamic blockedAt;
  dynamic blockedReason;
  String? businessName;
  String? clientVerificationKey;
  bool? clientVerified;
  dynamic country;
  String? createdAt;
  int? credits;
  String? dashboardStatus;
  String? directoryBusinessTypeId;
  dynamic directoryCategoryOtherName;
  String? email;
  dynamic employeeDetails;
  dynamic firstName;
  String? id;
  dynamic internalNote;
  dynamic lastName;
  dynamic managerUserId;
  String? name;
  String? password;
  Payload? payload;
  bool? paymentStatus;
  String? phone;
  String? postalCode;
  DirectoryCategories? professionType;
  bool? profileStatus;
  String? state;
  String? status;
  dynamic subscriptionExpiresAt;
  String? subscriptionPlanId;
  dynamic timezone;
  String? trackingDetails;
  String? type;
  String? updatedAt;
  String? subType;
  SubscriptionPlans? subscriptionPlans;
  dynamic clientSource;
  String? sTypename;

  Clients(
      {this.abnNumber,
      this.blockedAt,
      this.blockedReason,
      this.businessName,
      this.clientVerificationKey,
      this.clientVerified,
      this.country,
      this.createdAt,
      this.credits,
      this.dashboardStatus,
      this.directoryBusinessTypeId,
      this.directoryCategoryOtherName,
      this.email,
      this.employeeDetails,
      this.firstName,
      this.id,
      this.internalNote,
      this.lastName,
      this.managerUserId,
      this.name,
      this.password,
      this.payload,
      this.paymentStatus,
      this.phone,
      this.postalCode,
      this.professionType,
      this.profileStatus,
      this.state,
      this.status,
      this.subscriptionExpiresAt,
      this.subscriptionPlanId,
      this.timezone,
      this.trackingDetails,
      this.type,
      this.updatedAt,
      this.subType,
      this.subscriptionPlans,
      this.clientSource,
      this.sTypename});

  Clients.fromJson(Map<String, dynamic> json) {
    abnNumber = json['abn_number'];
    blockedAt = json['blocked_at'];
    blockedReason = json['blocked_reason'];
    businessName = json['businessName'];
    clientVerificationKey = json['client_verification_key'];
    clientVerified = json['client_verified'];
    country = json['country'];
    createdAt = json['created_at'];
    credits = json['credits'];
    dashboardStatus = json['dashboard_status'];
    directoryBusinessTypeId = json['directory_business_type_id'];
    directoryCategoryOtherName = json['directory_category_other_name'];
    email = json['email'];
    employeeDetails = json['employee_details'];
    firstName = json['first_name'];
    id = json['id'];
    internalNote = json['internal_note'];
    lastName = json['last_name'];
    managerUserId = json['manager_user_id'];
    name = json['name'];
    password = json['password'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    paymentStatus = json['payment_status'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    professionType = json['professionType'] != null
        ? new DirectoryCategories.fromJson(json['professionType'])
        : null;

    profileStatus = json['profile_status'];
    state = json['state'];
    status = json['status'];
    subscriptionExpiresAt = json['subscription_expires_at'];
    subscriptionPlanId = json['subscription_plan_id'];
    timezone = json['timezone'];
    trackingDetails = json['tracking_details'];
    type = json['type'];
    updatedAt = json['updated_at'];
    subType = json['sub_type'];
    subscriptionPlans = json['subscription_plans'] != null
        ? new SubscriptionPlans.fromJson(json['subscription_plans'])
        : null;
    clientSource = json['client_source'];
    sTypename = json['__typename'];
  }
}

class Payload {
  String? subscriptionId;

  Payload({this.subscriptionId});

  Payload.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId;
    return data;
  }
}

class SubscriptionPlans {
  String? id;
  String? name;
  String? sTypename;

  SubscriptionPlans({this.id, this.name, this.sTypename});

  SubscriptionPlans.fromJson(Map<String, dynamic> json) {
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
