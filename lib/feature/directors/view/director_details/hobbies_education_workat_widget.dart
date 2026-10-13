import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view/director_details/director_basic_info.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HobbiesEducationWorkatWidget extends StatelessWidget
    with BaseContextHelpers {
  const HobbiesEducationWorkatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectoryViewModel>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (directionalVM.directorDetails?.hobbies?.isNotEmpty ?? false) ...[
        addVertical(10),
        sectionTitle(
            'HOBBIES',
            Column(
                children: directionalVM.directorDetails?.hobbies
                        ?.map((e) => Text(e))
                        .toList() ??
                    []))
      ],
      if (directionalVM.directorDetails?.education?.isNotEmpty ?? false) ...[
        addVertical(10),
        sectionTitle(
            'EDUCATION',
            Column(
                children: directionalVM.directorDetails?.education
                        ?.map((e) => Text(e))
                        .toList() ??
                    []))
      ],
      /*if (directionalVM.directorDetails?.universitySchool?.isNotEmpty ??
          false) ...[
        addVertical(10),
        sectionTitle(
            'university'.toUpperCase(),
            Column(
                children: directionalVM.directorDetails?.hobbies
                        ?.map((e) => Text(e))
                        .toList() ??
                    []))
      ],
      if (directionalVM.directorDetails?.workingAt?.isNotEmpty ?? false) ...[
        addVertical(10),
        sectionTitle(
            'WORKING AT',
            Column(
                children: directionalVM.directorDetails?.workingAt
                        ?.map((e) => Text(e))
                        .toList() ??
                    []))
      ],*/
    ]);
  }
}
