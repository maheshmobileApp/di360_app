import 'package:di360_flutter/feature/directors/model_class/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_appointment_slots_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';

abstract class DirectorRepository {
  Future<List<Directories>> getDirectors(String catagoryId,String searchText);
  Future<List<Banners>> getBannersList();
  Future<List<DirectoryBusinessTypes>> directoriesCatagory();
  Future<DirectoriesByPk?> directoriesDetailsQuery(String id);
  Future<List<DirectoryAppointments>> appointmentsSlots(String id);
}