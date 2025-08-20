class AppoinmentsModel {
  final String? teamMemberName;
  final String? services;
  final String? selectADay;
  final DateTime? serviceTime;
  final DateTime? serviceStartTime;
  final DateTime? serviceEndTime;
  final DateTime? breakStartTime;
  final DateTime? breakEndTime;

  AppoinmentsModel({
    this.teamMemberName,
    this.services,
    this.selectADay,
    this.serviceTime,
    this.serviceStartTime,
    this.serviceEndTime,
    this.breakStartTime,
    this.breakEndTime,
  });
}

