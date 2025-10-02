import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/my_appointments/model_class/appoinment_res.dart';
import 'package:di360_flutter/feature/my_appointments/repositorys/appointment_repository_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

class AppointmentViewModel extends ChangeNotifier {
  AppointmentRepositoryImpl appointmentRepository = AppointmentRepositoryImpl();

  List<DirectoryAppointmentsList> appointmentList = [];

  Future<void> getAppointmentData() async {
   // Loaders.circularShowLoader(navigatorKey.currentContext!);
    final result = await appointmentRepository.getAppointments();
    if (result != false) {
      appointmentList = result;
      navigationService.navigateTo(RouteList.myAppointment);
    //  Loaders.circularHideLoader(navigatorKey.currentContext!);
    } else {
    //  Loaders.circularHideLoader(navigatorKey.currentContext!);
    }
    notifyListeners();
  }
}
