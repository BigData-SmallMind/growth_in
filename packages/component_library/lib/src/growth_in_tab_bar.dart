import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class GrowthInTabBar extends StatelessWidget {
  const GrowthInTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      this.isScrollable,
      this.tabAlignment});

  final TabController tabController;
  final List<Widget> tabs;
  final bool? isScrollable;
  final TabAlignment? tabAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return Container(
      width: double.infinity,
      height: 45,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.xSmall,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: theme.screenMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        tabAlignment: tabAlignment,
        physics: const NeverScrollableScrollPhysics(),
        isScrollable: isScrollable ?? false,
        labelPadding: EdgeInsets.symmetric(
          horizontal: theme.screenMargin,
          vertical: 0,
        ),
        dividerColor: theme.borderColor,
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
        indicatorPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: const Color(0xFF757D8A),
        labelColor: theme.secondaryColor,
        controller: tabController,
        tabs: tabs,
      ),
    );
  }
}
