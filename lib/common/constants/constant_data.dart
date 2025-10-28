import 'package:di360_flutter/common/constants/image_const.dart';

class ConstantData {
  ConstantData._();

  static List<String> homeGridImgs = [
    ImageConst.newsFeed,
    //ImageConst.supplies,
    //ImageConst.usedSupplies,
    ImageConst.learningHub,
    ImageConst.directory,
    ImageConst.jobSeek,
    //  ImageConst.buy,
    ImageConst.catalogue,
    ImageConst.support
  ];

  static List<String> homeGridTitles = [
    'News Feed',
    //'Supplies',
    //'Used Supplies',
    'Learning Hub',
    "Directory",
    'Job Seek',
    //'Buy & Sell',
    'Catalogue',
    'Support'
  ];

  static List<String> teamMemberList = ['All Team Member', 'George'];

  static List<String> serviceList = [
    '1',
    '2',
    '4',
    '5',
    '6',
  ];
  static List<String> DaysList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  static List<String> AccountList = [
    'Facebook',
    'Twitter',
    'Instagram',
    'LinkedIn',
    'Web url'
  ];

  static List<String> steps = [
    'Basic',
    'Services',
    'Certificates',
    'Achievements',
    'Documents',
    'OurTeam',
    'Gallery',
    'Appointments',
    'Faqs',
    'Testimonials',
    'OtherInformation',
  ];
  static List<String> profesSteps = [
    'Basic',
    'Education',
    'Certificates',
    'Achievements',
    'Gallery',
    'Testimonials',
    'OtherInformation',
  ];
}
