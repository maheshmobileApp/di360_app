import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalentsView extends StatelessWidget {
  const TalentsView({super.key});

  @override
  Widget build(BuildContext context) {
     final talentViewModel = Provider.of<TalentsViewModel>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: talentViewModel.talentList.length,
        itemBuilder: (BuildContext context, int index) {
          final talentData= talentViewModel.talentList[index];
          return TalentsCard(
            talentList: talentData,
          );
        },
      ),
    );
  }
}
