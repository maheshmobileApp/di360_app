import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectorQuickLinks extends StatefulWidget {
  const DirectorQuickLinks({super.key});

  @override
  State<DirectorQuickLinks> createState() => _DirectorQuickLinksState();
}

class _DirectorQuickLinksState extends State<DirectorQuickLinks> {
  int _selectedIndex = -1; 

  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectoryViewModel>(context);
    final items = directionalVM.quickLinkItems;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QUICK LINKS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = _selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        directionalVM.scrollToSectionByLabel(item.label);
                        Navigator.pop(context); 
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: isSelected
                                ? Colors.orange
                                : Colors.grey.shade200,
                            radius: 24,
                            child: Icon(
                              item.icon,
                              color: isSelected ? Colors.white : Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
