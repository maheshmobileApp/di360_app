import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderImageView extends StatelessWidget {
  final String? logo;
  final String? title;
  final Widget? body;
  const HeaderImageView({super.key, this.logo, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          foregroundColor: AppColors.black,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final top = constraints.biggest.height;
              final isCollapsed =
                  top <= kToolbarHeight + MediaQuery.of(context).padding.top;
              return FlexibleSpaceBar(
                  centerTitle: false,
                  title: isCollapsed
                      ? Text(
                          title ?? '',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      : null, // No title when expanded
                  background: Stack(
                    children: [
                      ListBanner(),
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        left: 10,
                        child: isCollapsed
                            ? IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    size: 24, color: Colors.black),
                                onPressed: () => Navigator.pop(context),
                              )
                            : CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                radius: 20,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                      ),
                    ],
                  ));
            },
          ),
          leading: SizedBox.shrink(),
        ),
        SliverToBoxAdapter(
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: body),
        ),
      ],
    );
  }
}
