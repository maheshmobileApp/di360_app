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

  static List<String> salutationList = ['Mr', 'Mrs', 'Ms', 'Dr'];

  static List<String> genderList = ['Male', 'Female', 'Other'];

  static List<String> steps = [
    'Basic',
    'Services',
    'Certificates',
    'Achievements',
    'Documents',
    'OurTeam',
    'Partners',
    'Gallery',
    'Appointments',
    'Faqs',
    'Testimonials',
    'OtherInformation',
  ];
  static List<String> profesSteps = [
    'Basic',
    'Education',
    // 'Certificates',
    // 'Achievements',
    // 'Gallery',
    // 'Testimonials',
    'OtherInformation',
  ];

  static List<Map<String, String>> planTypes = [
    {
      "name": "Dental Professional",
      "type": "PROFESSIONAL",
      "subscription_plan_id": "7014ced9-df28-4775-bdba-3b7ac9a70fc8"
    },
    {
      "name": "Industry Partners",
      "type": "SUPPLIER",
      "subscription_plan_id": "cea36963-68fe-44d4-b94a-265ae4031405"
    },
    {
      "name": "Dental Practice",
      "type": "PRACTICE",
      "subscription_plan_id": "371b4307-6020-447e-af03-fae90301a3cb"
    }
  ];

  static List<String> phoneCodeList = ['AU (+61)'];// 'NZ (+64)';
}
