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
    if (json['directory_appointments'] != null) {
      directoryAppointments = <DirectoryAppointments>[];
      json['directory_appointments'].forEach((v) {
        directoryAppointments!.add(new DirectoryAppointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoryAppointments != null) {
      data['directory_appointments'] =
          this.directoryAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoryAppointments {
  String? id;
  Timeslot? timeslot;
  String? directoryServiceId;
  String? appointmentDate;
  String? sTypename;

  DirectoryAppointments(
      {this.id,
      this.timeslot,
      this.directoryServiceId,
      this.appointmentDate,
      this.sTypename});

  DirectoryAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeslot = json['timeslot'] != null
        ? new Timeslot.fromJson(json['timeslot'])
        : null;
    directoryServiceId = json['directory_service_id'];
    appointmentDate = json['appointment_date'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.timeslot != null) {
      data['timeslot'] = this.timeslot!.toJson();
    }
    data['directory_service_id'] = this.directoryServiceId;
    data['appointment_date'] = this.appointmentDate;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Timeslot {
  String? doctor;
  bool? desable;
  List<String>? service;
  String? timeSlotStart;

  Timeslot({this.doctor, this.desable, this.service, this.timeSlotStart});

  Timeslot.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'];
    desable = json['desable'];
    service = json['service'].cast<String>();
    timeSlotStart = json['timeSlotStart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctor;
    data['desable'] = this.desable;
    data['service'] = this.service;
    data['timeSlotStart'] = this.timeSlotStart;
    return data;
  }
}
