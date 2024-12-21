import 'package:register_func/models/tab_item_model.dart';
import 'package:register_func/core/theme/my_theme.dart';
import 'package:register_func/ui/views/home/home_screen.dart';
import 'package:register_func/ui/widgets/Appbars/custom_app_bar.dart';
import 'package:register_func/ui/widgets/Customs/custom_search_container.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
    required this.tabItemsList,
  });

  final List<TabItemModel> tabItemsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        // color: MyTheme.primaryColor,
      ),
      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(),
              CustomSearchContainer(),
            ],
          ),
          Positioned(
            bottom: -30,
            child: TabItemsList(tabItemsList: tabItemsList),
          )
        ],
      ),
    );
  }
}
