import 'package:di360_flutter/feature/my_appointments/model_class/appoinment_res.dart';

abstract class AppoinmentRepository {
  Future<List<DirectoryAppointmentsList>> getAppointments();
}