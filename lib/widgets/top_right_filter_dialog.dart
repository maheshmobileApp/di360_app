import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';

class FilterOption {
  final String title;
  final Function(bool) onChanged;

  FilterOption({
    required this.title,
    required this.onChanged,
  });
}

class TopRightFilterDialog extends StatelessWidget {
  final List<FilterOption> filterOptions;
  final String title;
  final VoidCallback? onClose;
  final VoidCallback? clearAll;

  const TopRightFilterDialog({
    Key? key,
    required this.filterOptions,
    this.title = 'Filter',
    this.onClose,
    this.clearAll,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required List<FilterOption> filterOptions,
    String title = 'Filter',
    VoidCallback? onClose,
    VoidCallback? clearAll,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TopRightFilterDialog(
        filterOptions: filterOptions,
        title: title,
        onClose: onClose,
        clearAll: clearAll,
      ),
    );
  }

  bool _getValue(String title, CampaignViewModel viewModel) {
    switch (title) {
      case 'SMS':
        return viewModel.smsFilterStatus;
      case 'Email':
        return viewModel.emailFilterStatus;
      case 'HTML':
        return viewModel.htmlFilterStatus;
      case 'Email with PDF':
        return viewModel.emailWithPdfFilterStatus;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 80, right: 16),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.geryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyles.bold3(color: AppColors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (onClose != null) {
                            onClose!();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(Icons.close, color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Consumer<CampaignViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        children: [
                          ...filterOptions.map((option) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(option.title),
                              value: _getValue(option.title, viewModel),
                              onChanged: (val) {
                                option.onChanged(val ?? false);
                              },
                            );
                          }).toList(),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: clearAll,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Clear All",
                                style: TextStyles.semiBold(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
