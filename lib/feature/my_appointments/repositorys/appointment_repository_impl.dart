import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/my_appointments/model_class/appoinment_res.dart';
import 'package:di360_flutter/feature/my_appointments/querys/appointment_query.dart';
import 'package:di360_flutter/feature/my_appointments/repositorys/appoinment_repository.dart';

class AppointmentRepositoryImpl extends AppoinmentRepository {
  final HttpService http = HttpService();

  @override
  Future<List<DirectoryAppointmentsList>> getAppointments() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res =
        await http.query(getAppointmentsQuery, variables: {"id": userId});
    final result = AppoinmentData.fromJson(res);
    return result.directories?.first.directoryAppointments ?? [];
  }
}
