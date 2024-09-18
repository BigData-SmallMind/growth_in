import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets/src/l10n/tickets_localizations.dart';
import 'package:tickets/src/tickets_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    super.key,
    required this.userRepository,
    required this.onAddTicketTapped,
    required this.navigateToTicketMessages,
  });

  final UserRepository userRepository;
  final VoidCallback onAddTicketTapped;
  final ValueSetter<int> navigateToTicketMessages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketsCubit>(
      create: (_) => TicketsCubit(
        userRepository: userRepository,
        onAddTicketTapped: onAddTicketTapped,
        navigateToTicketMessages: navigateToTicketMessages,
      ),
      child: const TicketsView(),
    );
  }
}

class TicketsView extends StatefulWidget {
  const TicketsView({
    super.key,
  });

  @override
  State<TicketsView> createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsCubit, TicketsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = TicketsLocalizations.of(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.primaryColor,
            onPressed: () {
              context.read<TicketsCubit>().onAddTicketTapped();
            },
            child: const Icon(Icons.add),
          ),
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: state.tickets?.isEmpty == true
              ? NoTicketsIndicator()
              : Column(
                  children: [
                    GrowthInTabBar(
                      tabController: _tabController,
                      tabs: [
                        Tab(
                          text: l10n.activeTicketsTabLabel,
                        ),
                        Tab(
                          text: l10n.inActiveTicketsTabLabel,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.screenMargin,
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            TicketsList(active: true),
                            TicketsList(active: false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

