import 'package:component_library/component_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tab_container/src/l10n/tab_container_localizations.dart';
import 'package:tab_container/src/tab_container_cubit.dart';
import 'package:user_repository/user_repository.dart';

const tabBarHeight = 70.0;

class TabContainerScreen extends StatefulWidget {
  const TabContainerScreen({
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  State<TabContainerScreen> createState() => _TabContainerScreenState();
}

class _TabContainerScreenState extends State<TabContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabContainerCubit>(
      create: (_) => TabContainerCubit(
        userRepository: widget.userRepository,
      ),
      child: const TabContainerView(),
    );
  }
}

class TabContainerView extends StatelessWidget {
  const TabContainerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabContainerCubit, TabContainerState>(
      builder: (context, state) {
        final tabPage = TabPage.of(context);
        final l10n = TabContainerLocalizations.of(context);
        final localizedNavBarTabs = localizeNavBarTabs(l10n);
        final colorScheme =
            GrowthInTheme.of(context).materialThemeData.colorScheme;
        final theme = GrowthInTheme.of(context);
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
          body: TabBarView(
            controller: tabPage.controller,
            physics: const NeverScrollableScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            children: [
              for (final stack in tabPage.stacks)
                PageStackNavigator(
                  stack: stack,
                )
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: tabBarHeight,
              decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.borderColor))),
              child: TabBar(
                controller: tabPage.controller,
                labelStyle:
                    textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 10),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: colorScheme.primary,
                unselectedLabelColor: theme.dimmedTextColor,
                dividerColor: Colors.green,
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                tabs: <Widget>[
                  for (int i = 0; i < tabPage.stacks.length; i++)
                    NavBarTab(
                      title: localizedNavBarTabs[i].title,
                      svgPath: tabPage.index == i
                          ? localizedNavBarTabs[i].selectedSvgPath
                          : localizedNavBarTabs[i].unselectedSvgPath,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<NavBarTabModel> localizeNavBarTabs(
  TabContainerLocalizations l10n,
) {
  final navBarTabs = [
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.homeUnselectedPath,
      selectedSvgPath: AssetPathConstants.homeSelectedPath,
      title: l10n.homeTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.cmsUnselectedPath,
      selectedSvgPath: AssetPathConstants.cmsSelectedPath,
      title: l10n.cmsTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.messagesUnselectedPath,
      selectedSvgPath: AssetPathConstants.messagesSelectedPath,
      title: l10n.messagesTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.filesUnselectedPath,
      selectedSvgPath: AssetPathConstants.filesSelectedPath,
      title: l10n.filesTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.menuUnselectedPath,
      selectedSvgPath: AssetPathConstants.menuSelectedPath,
      title: l10n.menuTabLabel,
    ),
  ];
  return navBarTabs;
}

class NavBarTabModel {
  const NavBarTabModel({
    required this.title,
    required this.unselectedSvgPath,
    required this.selectedSvgPath,
  });

  final String title;
  final String unselectedSvgPath;
  final String selectedSvgPath;
}
