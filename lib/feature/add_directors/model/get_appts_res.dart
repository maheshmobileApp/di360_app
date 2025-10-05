class GetApptsRes {
  AppointmentsData? data;

  GetApptsRes({this.data});

  GetApptsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new AppointmentsData.fromJson(json['data'])
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

class AppointmentsData {
  List<DirectoryApptsSlots>? directoryAppointmentSlots;

  AppointmentsData({this.directoryAppointmentSlots});

  AppointmentsData.fromJson(Map<String, dynamic> json) {
    if (json['directory_appointment_slots'] != null) {
      directoryAppointmentSlots = <DirectoryApptsSlots>[];
      json['directory_appointment_slots'].forEach((v) {
        directoryAppointmentSlots!.add(new DirectoryApptsSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoryAppointmentSlots != null) {
      data['directory_appointment_slots'] =
          this.directoryAppointmentSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoryApptsSlots {
  String? id;
  List<String>? dayWiseTimeslots;
  List<String>? serviceMember;
  List<String>? serviceName;
  int? durationInMinites;
  List<String>? directoryServiceId;
  List<String>? weekdays;
  String? sTypename;

  DirectoryApptsSlots(
      {this.id,
      this.dayWiseTimeslots,
      this.serviceMember,
      this.serviceName,
      this.durationInMinites,
      this.directoryServiceId,
      this.weekdays,
      this.sTypename});

  DirectoryApptsSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayWiseTimeslots =
        (json['day_wise_timeslots'] as List?)?.cast<String>() ?? [];
    serviceMember = (json['serviceMember'] as List?)?.cast<String>() ?? [];
    serviceName = (json['service_name'] as List?)?.cast<String>() ?? [];
    durationInMinites = json['duration_in_minites'];
    directoryServiceId =
        (json['directory_service_id'] as List?)?.cast<String>() ?? [];
    weekdays = (json['weekdays'] as List?)?.cast<String>() ?? [];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_wise_timeslots'] = this.dayWiseTimeslots;
    data['serviceMember'] = this.serviceMember;
    data['service_name'] = this.serviceName;
    data['duration_in_minites'] = this.durationInMinites;
    data['directory_service_id'] = this.directoryServiceId;
    data['weekdays'] = this.weekdays;
    data['__typename'] = this.sTypename;
    return data;
  }
}
