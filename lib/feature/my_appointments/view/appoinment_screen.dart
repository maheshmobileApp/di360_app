import 'package:di360_flutter/feature/my_appointments/my_appointment_view_model/appointment_view_model.dart';
import 'package:di360_flutter/feature/my_appointments/view/appointment_card.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppoinmentScreen extends StatefulWidget {
  const AppoinmentScreen({super.key});

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      final appointVM = context.read<AppointmentViewModel>();
      appointVM.getAppointmentData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentVM = Provider.of<AppointmentViewModel>(context);
    return Scaffold(
      appBar: AppbarTitleBackIconWidget(title: 'My Appointments'),
      body: ListView.builder(
          itemCount: appointmentVM.appointmentList.length,
          itemBuilder: (context, index) {
            final appointment = appointmentVM.appointmentList[index];
            return AppointmentCard(item: appointment);
          }),
    );
  }
}
