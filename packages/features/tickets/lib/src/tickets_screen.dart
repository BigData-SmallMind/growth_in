import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets/src/l10n/tickets_localizations.dart';
import 'package:tickets/src/tickets_cubit.dart';
import 'package:user_repository/user_repository.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketsCubit>(
      create: (_) => TicketsCubit(
        userRepository: userRepository,
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
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: state.tickets == null
              ? CenteredCircularProgressIndicator()
              : state.tickets!.isEmpty
                  ? NoTicketsIndicator()
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
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
                          height: 45,
                          child: TabBar(
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
                            unselectedLabelColor: Color(0xFF757D8A),
                            labelColor: theme.secondaryColor,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                text: l10n.activeTicketsTabLabel,
                              ),
                              Tab(
                                text: l10n.inActiveTicketsTabLabel,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.screenMargin,
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Tickets(active: true),
                                Tickets(active: false),
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

class NoTicketsIndicator extends StatelessWidget {
  const NoTicketsIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = TicketsLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgAsset(AssetPathConstants.noTicketsPath),
        VerticalGap.xLarge(),
        Text(
          l10n.noTicketsMessageTitle,
          style: textTheme.titleMedium,
        ),
        VerticalGap.medium(),
        Text(
          l10n.noTicketsMessageSubtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
        VerticalGap.medium(),
        GrowthInElevatedButton(
          label: 'l10n.noTicketsButtonLabel',
          onTap: () {},
        ),
      ],
    );
  }
}

class Tickets extends StatelessWidget {
  const Tickets({
    Key? key,
    required this.active,
  }) : super(key: key);
  final bool active;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsCubit, TicketsState>(
      builder: (context, state) {
        final tickets = active ? state.activeTickets : state.inActiveTickets;
        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return;
          },
        );
      },
    );
  }
}
