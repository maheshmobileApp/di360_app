import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_notification_campaign_res.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/campaign_detail_sheet.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationCampaignCard extends StatelessWidget {
  final CourseNotificationCampaigns? notificationData;

  const NotificationCampaignCard({
    super.key,
    this.notificationData,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationData?.campaignName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormatUtils.formatDateTime(
                          notificationData?.scheduledAt ?? ''),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7B8494),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'preview') {
                    await vm.notificationCampaignDetails(
                        context, notificationData?.id ?? '');
                        final data = vm.notificationCampaignDetailData?.courseNotificationCampaignsByPk;
                    CampaignDetailsBottomSheet.show(
                      context,
                      campaignName: data?.campaignName ?? '',
                      channel: data?.notificationChannel ?? '',
                      recipients:
                          "${data?.recipientsCount.toString() ?? ''}/${data?.totalRecipients.toString() ?? ''}",
                      sendMode: data?.sendMode ?? '',
                      scheduledAt: data?.scheduledAt ?? '',
                      status: data?.status ?? '',
                      createdAt: DateFormatUtils.formatDateTime(
                          data?.createdAt ?? ''),
                      subject: data?.emailSubject ?? '',
                      body: data?.messageBody ?? "",
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'preview',
                    child: Text('Preview'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEF0F4)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _detail(
                  'TYPE',
                  notificationData?.notificationType ?? '',
                  color: AppColors.primaryColor.withOpacity(0.1),
                  textColor: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: _detail(
                  'RECIPIENTS',
                  "${notificationData?.recipientsCount.toString() ?? ''}/${notificationData?.totalRecipients.toString() ?? ''}",
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _detail(
                  'SEND MODE',
                  notificationData?.sendMode == "NOW"
                      ? "Immediate"
                      : "Scheduled",
                  color: const Color(0xFFF0F2F7),
                  textColor: const Color(0xFF536078),
                ),
              ),
              Expanded(
                child: _detail('STATUS', notificationData?.status ?? '',
                    color: AppColors.greenColor.withOpacity(0.1),
                    textColor: AppColors.greenColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detail(
    String title,
    String value, {
    Color? color,
    Color? textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929AAA),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        if (color != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF273247),
            ),
          ),
      ],
    );
  }
}
