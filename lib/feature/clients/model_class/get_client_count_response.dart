class GetClientCountResponse {
  ClientCountData? data;

  GetClientCountResponse({this.data});

  GetClientCountResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ClientCountData.fromJson(json['data'])
        : null;
  }
}

class ClientCountData {
  PracticeTotal? practiceTotal;
  PracticeActive? practiceActive;
  PracticeInactive? practiceInactive;
  SupplierTotal? supplierTotal;
  SupplierActive? supplierActive;
  SupplierInactive? supplierInactive;
  ProfessionalTotal? professionalTotal;
  ProfessionalActive? professionalActive;
  ProfessionalInactive? professionalInactive;
  TeamMemberTotal? teamMemberTotal;
  TeamMemberActive? teamMemberActive;
  TeamMemberInActive? teamMemberInactive;
  AllTotal? allTotal;
  AllActive? allActive;
  AllInActive? allInactive;

  ClientCountData(
      {this.practiceTotal,
      this.practiceActive,
      this.practiceInactive,
      this.supplierTotal,
      this.supplierActive,
      this.supplierInactive,
      this.professionalTotal,
      this.professionalActive,
      this.professionalInactive,
      this.teamMemberTotal,
      this.teamMemberActive,
      this.teamMemberInactive,
      this.allTotal,
      this.allActive,
      this.allInactive});

  ClientCountData.fromJson(Map<String, dynamic> json) {
    practiceTotal = json['practiceTotal'] != null
        ? new PracticeTotal.fromJson(json['practiceTotal'])
        : null;
    practiceActive = json['practiceActive'] != null
        ? new PracticeActive.fromJson(json['practiceActive'])
        : null;
    practiceInactive = json['practiceInactive'] != null
        ? new PracticeInactive.fromJson(json['practiceInactive'])
        : null;
    supplierTotal = json['supplierTotal'] != null
        ? new SupplierTotal.fromJson(json['supplierTotal'])
        : null;
    supplierActive = json['supplierActive'] != null
        ? new SupplierActive.fromJson(json['supplierActive'])
        : null;
    supplierInactive = json['supplierInactive'] != null
        ? new SupplierInactive.fromJson(json['supplierInactive'])
        : null;
    professionalTotal = json['professionalTotal'] != null
        ? new ProfessionalTotal.fromJson(json['professionalTotal'])
        : null;
    professionalActive = json['professionalActive'] != null
        ? new ProfessionalActive.fromJson(json['professionalActive'])
        : null;
    professionalInactive = json['professionalInactive'] != null
        ? new ProfessionalInactive.fromJson(json['professionalInactive'])
        : null;
    teamMemberTotal = json['teamMemberTotal'] != null
        ? new TeamMemberTotal.fromJson(json['teamMemberTotal'])
        : null;
    teamMemberActive = json['teamMemberActive'] != null
        ? new TeamMemberActive.fromJson(json['teamMemberActive'])
        : null;
    teamMemberInactive = json['teamMemberInactive'] != null
        ? new TeamMemberInActive.fromJson(json['teamMemberInactive'])
        : null;
    allTotal = json['allTotal'] != null
        ? new AllTotal.fromJson(json['allTotal'])
        : null;
    allActive = json['allActive'] != null
        ? new AllActive.fromJson(json['allActive'])
        : null;
    allInactive = json['allInactive'] != null
        ? new AllInActive.fromJson(json['allInactive'])
        : null;
  }
}

class PracticeTotal {
  PracticeTotalAggregate? aggregate;

  PracticeTotal({this.aggregate});

  PracticeTotal.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new PracticeTotalAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class PracticeTotalAggregate {
  int? count;

  PracticeTotalAggregate({this.count});

  PracticeTotalAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class PracticeActive {
  PracticeActiveAggregate? aggregate;

  PracticeActive({this.aggregate});

  PracticeActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new PracticeActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class PracticeActiveAggregate {
  int? count;

  PracticeActiveAggregate({this.count});

  PracticeActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class PracticeInactive {
  PracticeInactiveAggregate? aggregate;

  PracticeInactive({this.aggregate});

  PracticeInactive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new PracticeInactiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class PracticeInactiveAggregate {
  int? count;

  PracticeInactiveAggregate({this.count});

  PracticeInactiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class SupplierTotal {
  SupplierTotalAggregate? aggregate;

  SupplierTotal({this.aggregate});

  SupplierTotal.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new SupplierTotalAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class SupplierTotalAggregate {
  int? count;

  SupplierTotalAggregate({this.count});

  SupplierTotalAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class SupplierActive {
  SupplierActiveAggregate? aggregate;

  SupplierActive({this.aggregate});

  SupplierActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new SupplierActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class SupplierActiveAggregate {
  int? count;

  SupplierActiveAggregate({this.count});

  SupplierActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class SupplierInactive {
  SupplierInactiveAggregate? aggregate;

  SupplierInactive({this.aggregate});

  SupplierInactive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new SupplierInactiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class SupplierInactiveAggregate {
  int? count;

  SupplierInactiveAggregate({this.count});

  SupplierInactiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class ProfessionalTotal {
  ProfessionalTotalAggregate? aggregate;

  ProfessionalTotal({this.aggregate});

  ProfessionalTotal.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ProfessionalTotalAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class ProfessionalTotalAggregate {
  int? count;

  ProfessionalTotalAggregate({this.count});

  ProfessionalTotalAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class ProfessionalActive {
  ProfessionalActiveAggregate? aggregate;

  ProfessionalActive({this.aggregate});

  ProfessionalActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ProfessionalActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class ProfessionalActiveAggregate {
  int? count;

  ProfessionalActiveAggregate({this.count});

  ProfessionalActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class ProfessionalInactive {
  ProfessionalInactiveAggregate? aggregate;

  ProfessionalInactive({this.aggregate});

  ProfessionalInactive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new ProfessionalInactiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class ProfessionalInactiveAggregate {
  int? count;

  ProfessionalInactiveAggregate({this.count});

  ProfessionalInactiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class TeamMemberTotal {
  TeamMemberTotalAggregate? aggregate;

  TeamMemberTotal({this.aggregate});

  TeamMemberTotal.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new TeamMemberTotalAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class TeamMemberTotalAggregate {
  int? count;

  TeamMemberTotalAggregate({this.count});

  TeamMemberTotalAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class TeamMemberActive {
  TeamMemberActiveAggregate? aggregate;

  TeamMemberActive({this.aggregate});

  TeamMemberActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new TeamMemberActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class TeamMemberActiveAggregate {
  int? count;

  TeamMemberActiveAggregate({this.count});

  TeamMemberActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class TeamMemberInActive {
  TeamMemberInActiveAggregate? aggregate;

  TeamMemberInActive({this.aggregate});

  TeamMemberInActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new TeamMemberInActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class TeamMemberInActiveAggregate {
  int? count;

  TeamMemberInActiveAggregate({this.count});

  TeamMemberInActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class AllTotal {
  AllTotalAggregate? aggregate;

  AllTotal({this.aggregate});

  AllTotal.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new AllTotalAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class AllTotalAggregate {
  int? count;

  AllTotalAggregate({this.count});

  AllTotalAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class AllActive {
  AllActiveAggregate? aggregate;

  AllActive({this.aggregate});

  AllActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new AllActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class AllActiveAggregate {
  int? count;

  AllActiveAggregate({this.count});

  AllActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}

class AllInActive {
  AllInActiveAggregate? aggregate;

  AllInActive({this.aggregate});

  AllInActive.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new AllInActiveAggregate.fromJson(json['aggregate'])
        : null;
  }
}

class AllInActiveAggregate {
  int? count;

  AllInActiveAggregate({this.count});

  AllInActiveAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
