class ContactsRes {
  ContactsData? data;

  ContactsRes({this.data});

  ContactsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ContactsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContactsData {
  List<PartnersContactBook>? partnersContactBook;
  PartnersContactBookAggregate? partnersContactBookAggregate;

  ContactsData({this.partnersContactBook, this.partnersContactBookAggregate});

  ContactsData.fromJson(Map<String, dynamic> json) {
    if (json['partners_contact_book'] != null) {
      partnersContactBook = <PartnersContactBook>[];
      json['partners_contact_book'].forEach((v) {
        partnersContactBook!.add(new PartnersContactBook.fromJson(v));
      });
    }
    partnersContactBookAggregate =
        json['partners_contact_book_aggregate'] != null
            ? new PartnersContactBookAggregate.fromJson(
                json['partners_contact_book_aggregate'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.partnersContactBook != null) {
      data['partners_contact_book'] =
          this.partnersContactBook!.map((v) => v.toJson()).toList();
    }
    if (this.partnersContactBookAggregate != null) {
      data['partners_contact_book_aggregate'] =
          this.partnersContactBookAggregate!.toJson();
    }
    return data;
  }
}

class PartnersContactBook {
  String? id;
  String? contactName;
  String? email;
  String? phone;
  String? companyName;
  String? state;
  String? createdAt;
  String? createdById;
  String? contactType;
  String? sTypename;

  PartnersContactBook(
      {this.id,
      this.contactName,
      this.email,
      this.phone,
      this.companyName,
      this.state,
      this.createdAt,
      this.createdById,
      this.contactType,
      this.sTypename});

  PartnersContactBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactName = json['contact_name'];
    email = json['email'];
    phone = json['phone'];
    companyName = json['company_name'];
    state = json['state'];
    createdAt = json['created_at'];
    createdById = json['created_by_id'];
    contactType = json['contact_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_name'] = this.contactName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['created_by_id'] = this.createdById;
    data['contact_type'] = this.contactType;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PartnersContactBookAggregate {
  Aggregate? aggregate;
  String? sTypename;

  PartnersContactBookAggregate({this.aggregate, this.sTypename});

  PartnersContactBookAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}
