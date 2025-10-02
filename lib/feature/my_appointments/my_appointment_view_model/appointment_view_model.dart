import 'package:di360_flutter/feature/my_appointments/model_class/appoinment_res.dart';
import 'package:di360_flutter/feature/my_appointments/repositorys/appointment_repository_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class AppointmentViewModel extends ChangeNotifier {
  AppointmentRepositoryImpl appointmentRepository = AppointmentRepositoryImpl();

  List<DirectoryAppointmentsList> appointmentList = [];

  Future<void> getAppointmentData(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final result = await appointmentRepository.getAppointments();
    if (result != false) {
      appointmentList = result;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
