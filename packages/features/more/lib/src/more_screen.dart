import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more/src/l10n/more_localizations.dart';
import 'package:more/src/more_cubit.dart';
import 'package:user_repository/user_repository.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({
    super.key,
    required this.userRepository,
    required this.onCompanyTileTap,
    required this.onRequestsTapped,
    required this.onFormsTapped,
    required this.onMeetingsTapped,
    required this.onLogout,
    required this.onHelpAndSupportTapped,
    required this.onProfileSettingsTapped,
  });

  final UserRepository userRepository;
  final VoidCallback onCompanyTileTap;
  final VoidCallback onRequestsTapped;
  final VoidCallback onFormsTapped;
  final VoidCallback onMeetingsTapped;
  final VoidCallback onLogout;
  final VoidCallback onHelpAndSupportTapped;
  final VoidCallback onProfileSettingsTapped;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MoreCubit>(
      create: (_) => MoreCubit(
        userRepository: widget.userRepository,
        onCompanyTileTap: widget.onCompanyTileTap,
        onLogout: widget.onLogout,
        onRequestsTapped: widget.onRequestsTapped,
        onFormsTapped: widget.onFormsTapped,
        onMeetingsTapped: widget.onMeetingsTapped,
        onHelpAndSupportTapped: widget.onHelpAndSupportTapped,
        onProfileSettingsTapped: widget.onProfileSettingsTapped,
      ),
      child: const MoreView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MoreView extends StatelessWidget {
  const MoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<MoreCubit, MoreState>(
      builder: (context, state) {
        final selectedCompany =
            state.user?.companies.firstWhere((company) => company.isSelected);
        final theme = GrowthInTheme.of(context);
        final cubit = context.read<MoreCubit>();
        final l10n = MoreLocalizations.of(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 0,
          ),
          body: state.user == null
              ? const CenteredCircularProgressIndicator()
              : ListView(
                  children: [
                    VerticalGap.large(),
                    CompanyTile(
                      company: selectedCompany!.copyWith(isSelected: false),
                      onTap: cubit.onCompanyTileTap,
                      trailing: const Icon(Icons.arrow_drop_down),
                    ),
                    VerticalGap.large(),
                    // Meetings tile
                    ListTile(
                      title: Text(l10n.meetingsTileTitle),
                      onTap: cubit.onMeetingsTapped,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.videoPath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    // Requests tile
                    ListTile(
                      title: Text(l10n.requestsTileTitle),
                      onTap: cubit.onRequestsTapped,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.taskSquarePath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    //forms tile
                    ListTile(
                      title: Text(l10n.formsTileTitle),
                      onTap: cubit.onFormsTapped,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.stickyNotePath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    // plans and services tile
                    ListTile(
                      title: Text(l10n.plansAndServicesTileTitle),
                      onTap: () {},
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.walletPath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    //settings tile
                    ListTile(
                      title: Text(l10n.settingsTileTitle),
                      onTap: cubit.onProfileSettingsTapped,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.gearPath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    //help tile
                    ListTile(
                      title: Text(l10n.helpTileTitle),
                      onTap: cubit.onHelpAndSupportTapped,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.headphonePath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    //logout tile
                    ListTile(
                      title: Text(l10n.logoutTileTitle),
                      onTap: cubit.onLogout,
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      leading: const SvgAsset(
                        AssetPathConstants.logoutPath,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    ),
                    const Divider(),
                    VerticalGap.large(),
                  ],
                ),
        );
      },
    );
  }
}
