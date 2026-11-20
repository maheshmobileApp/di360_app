
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingUrlCard extends StatelessWidget {
  final String bookingUrl;

  const BookingUrlCard({
    super.key,
    required this.bookingUrl,
  });

  Future<void> _copyUrl(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: bookingUrl));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking URL copied successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF7900);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE0E4EC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.link_rounded,
                color: primaryColor,
                size: 21,
              ),
              SizedBox(width: 9),
              Text(
                'BOOKING URL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF273247),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // URL and Copy button
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFDDE2EB),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: SelectableText(
                        bookingUrl,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF43516A),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                ElevatedButton.icon(
                  onPressed: () => _copyUrl(context),
                  icon: const Icon(
                    Icons.copy_rounded,
                    size: 15,
                  ),
                  label: const Text('Copy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Description
          const Text(
            'Share this link with users so they can book this course directly.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF8993A3),
            ),
          ),
        ],
      ),
    );
  }
}
