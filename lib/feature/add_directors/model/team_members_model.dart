import 'dart:io';

class TeamMembersModel {
  final String name;
  final String Designation;
  final int PhoneNumber;
  final String EmailID;
  final File? imageFile;
  final bool appointment;
  final bool ourTeam;
  TeamMembersModel({
    required this.name,
    required this.Designation,
    required this.PhoneNumber,
    required this. EmailID,
    required this.appointment,
    required this.ourTeam,
    this.imageFile,
  });
}