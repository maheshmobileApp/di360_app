class AppoinmentRes {
  AppoinmentData? data;

  AppoinmentRes({this.data});

  AppoinmentRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AppoinmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AppoinmentData {
  List<Directories>? directories;

  AppoinmentData({this.directories});

  AppoinmentData.fromJson(Map<String, dynamic> json) {
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Directories {
  List<DirectoryAppointmentsList>? directoryAppointments;

  Directories({this.directoryAppointments});

  Directories.fromJson(Map<String, dynamic> json) {
    if (json['directory_appointments'] != null) {
      directoryAppointments = <DirectoryAppointmentsList>[];
      json['directory_appointments'].forEach((v) {
        directoryAppointments!.add(new DirectoryAppointmentsList.fromJson(v));
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

class DirectoryAppointmentsList {
  String? id;
  String? directoryId;
  String? directoryServiceId;
  String? appointmentDate;
  String? serviceName;
  String? name;
  String? email;
  String? phone;
  String? status;
  Timeslot? timeslot;
  String? sTypename;

  DirectoryAppointmentsList(
      {this.id,
      this.directoryId,
      this.directoryServiceId,
      this.appointmentDate,
      this.serviceName,
      this.name,
      this.email,
      this.phone,
      this.status,
      this.timeslot,
      this.sTypename});

  DirectoryAppointmentsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    directoryId = json['directory_id'];
    directoryServiceId = json['directory_service_id'];
    appointmentDate = json['appointment_date'];
    serviceName = json['service_name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    timeslot = json['timeslot'] != null
        ? new Timeslot.fromJson(json['timeslot'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['directory_id'] = this.directoryId;
    data['directory_service_id'] = this.directoryServiceId;
    data['appointment_date'] = this.appointmentDate;
    data['service_name'] = this.serviceName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    if (this.timeslot != null) {
      data['timeslot'] = this.timeslot!.toJson();
    }
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
