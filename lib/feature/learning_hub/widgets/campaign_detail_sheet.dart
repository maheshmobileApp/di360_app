import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:flutter/material.dart';

class CampaignDetailsBottomSheet extends StatelessWidget {
  final String campaignName;
  final String channel;
  final String recipients;
  final String sendMode;
  final String scheduledAt;
  final String status;
  final String createdAt;
  final String subject;
  final String body;

  const CampaignDetailsBottomSheet({
    super.key,
    required this.campaignName,
    required this.channel,
    required this.recipients,
    required this.sendMode,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
    required this.subject,
    required this.body,
  });

  static void show(
    BuildContext context, {
    required String campaignName,
    required String channel,
    required String recipients,
    required String sendMode,
    required String scheduledAt,
    required String status,
    required String createdAt,
    required String subject,
    required String body,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CampaignDetailsBottomSheet(
        campaignName: campaignName,
        channel: channel,
        recipients: recipients,
        sendMode: sendMode,
        scheduledAt: scheduledAt,
        status: status,
        createdAt: createdAt,
        subject: subject,
        body: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSent = status.toLowerCase() == 'sent';

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 12, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      campaignName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF17243F),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF536078),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F3F9),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFEDF0F5),
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Campaign details - two columns
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _detail(
                            'CHANNEL',
                            channel.toUpperCase(),
                          ),
                        ),
                        Expanded(
                          child: _detail(
                            'RECIPIENTS',
                            recipients,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _detail(
                            'SEND MODE',
                            sendMode,
                          ),
                        ),
                        Expanded(
                          child: _detail(
                            'STATUS',
                            status.toUpperCase(),
                            isBadge: true,
                            isSent: isSent,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _detail(
                            'SCHEDULED AT',
                            DateFormatUtils.formatDateToDmy(scheduledAt),
                          ),
                        ),
                        Expanded(
                          child: _detail(
                            'CREATED',
                            DateFormatUtils.formatDateToDmy(createdAt),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Subject and body card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFBFD),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE1E7F0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _messageSection('SUBJECT', subject, false),
                          const Divider(
                            height: 1,
                            color: Color(0xFFE7ECF3),
                          ),
                          _messageSection('BODY', body, true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(
    String title,
    String value, {
    bool isBadge = false,
    bool isSent = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF929BAD),
          ),
        ),
        const SizedBox(height: 8),
        if (isBadge)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isSent ? const Color(0xFFE5F7EE) : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color:
                    isSent ? const Color(0xFF0BA75D) : const Color(0xFFFF9800),
              ),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF35435C),
            ),
          ),
      ],
    );
  }

  Widget _messageSection(String title, String value, bool html) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF929BAD),
            ),
          ),
          const SizedBox(height: 9),
          html
              ? ExpandableHtmlText(htmlData: value)
              : Text(
                  value.isEmpty ? '-' : value,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF26334A),
                  ),
                ),
        ],
      ),
    );
  }
}
