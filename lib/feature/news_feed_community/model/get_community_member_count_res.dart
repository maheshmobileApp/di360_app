class GetCommunityMemberCountRes {
  CommunityMemberData? data;

  GetCommunityMemberCountRes({this.data});

  GetCommunityMemberCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommunityMemberData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommunityMemberData {
  List<CommunityMembers>? communityMembers;
  CommunityMembersAggregate? communityMembersAggregate;

  CommunityMemberData({this.communityMembers, this.communityMembersAggregate});

  CommunityMemberData.fromJson(Map<String, dynamic> json) {
    if (json['community_members'] != null) {
      communityMembers = <CommunityMembers>[];
      json['community_members'].forEach((v) {
        communityMembers!.add(new CommunityMembers.fromJson(v));
      });
    }
    communityMembersAggregate = json['community_members_aggregate'] != null
        ? new CommunityMembersAggregate.fromJson(
            json['community_members_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.communityMembers != null) {
      data['community_members'] =
          this.communityMembers!.map((v) => v.toJson()).toList();
    }
    if (this.communityMembersAggregate != null) {
      data['community_members_aggregate'] =
          this.communityMembersAggregate!.toJson();
    }
    return data;
  }
}

class CommunityMembers {
  DentalSuppliers? dentalSuppliers;
  String? sTypename;

  CommunityMembers({this.dentalSuppliers, this.sTypename});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    dentalSuppliers = json['dental_suppliers'] != null
        ? new DentalSuppliers.fromJson(json['dental_suppliers'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] = this.dentalSuppliers!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSuppliers {
  String? businessName;
  List<Directories>? directories;
  String? sTypename;

  DentalSuppliers({this.businessName, this.directories, this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
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
    data['business_name'] = this.businessName;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Directories {
  String? id;
  List<DirectoryPartners>? directoryPartners;
 // List<DirectoryLocations>? directoryLocations;
  String? sTypename;

  Directories(
      {this.id,
      this.directoryPartners,
    //  this.directoryLocations,
      this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['directory_partners'] != null) {
      directoryPartners = <DirectoryPartners>[];
      json['directory_partners'].forEach((v) {
        directoryPartners!.add(new DirectoryPartners.fromJson(v));
      });
    }
    // if (json['directory_locations'] != null) {
    //   directoryLocations = <DirectoryLocations>[];
    //   json['directory_locations'].forEach((v) {
    //     directoryLocations!.add(new DirectoryLocations.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.directoryPartners != null) {
      data['directory_partners'] =
          this.directoryPartners!.map((v) => v.toJson()).toList();
    }
    // if (this.directoryLocations != null) {
    //   data['directory_locations'] =
    //       this.directoryLocations!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoryPartners {
  String? id;
  String? sTypename;

  DirectoryPartners({this.id, this.sTypename});

  DirectoryPartners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommunityMembersAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CommunityMembersAggregate({this.aggregate, this.sTypename});

  CommunityMembersAggregate.fromJson(Map<String, dynamic> json) {
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
