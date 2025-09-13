class GetAppointmentsSlotsRes {
  SlotsData? data;

  GetAppointmentsSlotsRes({this.data});

  GetAppointmentsSlotsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SlotsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SlotsData {
  List<DirectoryAppointments>? directoryAppointments;

  SlotsData({this.directoryAppointments});

  SlotsData.fromJson(Map<String, dynamic> json) {
    if (json['directory_appointment_slots'] != null) {
      directoryAppointments = <DirectoryAppointments>[];
      json['directory_appointment_slots'].forEach((v) {
        directoryAppointments!.add(new DirectoryAppointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoryAppointments != null) {
      data['directory_appointment_slots'] =
          this.directoryAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoryAppointments {
  String? id;
  String? directoryId;
  List<String>? serviceName;
  List<String>? directoryServiceId;
  List<String>? serviceMember;
  List<String>? dayWiseTimeslots;
  List<String>? weekdays;
  String? sTypename;

  DirectoryAppointments(
      {this.id,
      this.directoryId,
      this.serviceName,
      this.directoryServiceId,
      this.serviceMember,
      this.dayWiseTimeslots,
      this.weekdays,
      this.sTypename});

  DirectoryAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    directoryId = json['directory_id'];
    serviceName = json['service_name'] is List
        ? List<String>.from(json['service_name'])
        : [];
    directoryServiceId = json['directory_service_id'] is List
        ? List<String>.from(json['directory_service_id'])
        : [];
    serviceMember = json['serviceMember'] is List
        ? List<String>.from(json['serviceMember'])
        : [];
    dayWiseTimeslots = json['day_wise_timeslots'] is List
        ? List<String>.from(json['day_wise_timeslots'])
        : [];
    weekdays =
        json['weekdays'] is List ? List<String>.from(json['weekdays']) : [];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['directory_id'] = this.directoryId;
    data['service_name'] = this.serviceName;
    data['directory_service_id'] = this.directoryServiceId;
    data['serviceMember'] = this.serviceMember;
    data['day_wise_timeslots'] = this.dayWiseTimeslots;
    data['weekdays'] = this.weekdays;
    data['__typename'] = this.sTypename;
    return data;
  }
}
