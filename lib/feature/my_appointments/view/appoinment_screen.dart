import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/my_appointments/my_appointment_view_model/appointment_view_model.dart';
import 'package:di360_flutter/feature/my_appointments/view/appointment_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppoinmentScreen extends StatelessWidget {
  const AppoinmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentVM = Provider.of<AppointmentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () => navigationService.goBack(),
              child: Icon(Icons.arrow_back)),
          title: Text('My Appointments',
              style: TextStyles.bold4(color: AppColors.primaryColor))),
      body: ListView.builder(
          itemCount: appointmentVM.appointmentList.length,
          itemBuilder: (context, index) {
            final appointment = appointmentVM.appointmentList[index];
            return AppointmentCard(item: appointment);
          }),
    );
  }
}
