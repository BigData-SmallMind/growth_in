import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_info/src/l10n/profile_info_localizations.dart';
import 'package:profile_info/src/profile_info_cubit.dart';
import 'package:user_repository/user_repository.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileInfoCubit>(
      create: (_) => ProfileInfoCubit(
        userRepository: userRepository,
      ),
      child: const ProfileInfoView(),
    );
  }
}

class ProfileInfoView extends StatefulWidget {
  const ProfileInfoView({
    super.key,
  });

  @override
  State<ProfileInfoView> createState() => _ProfileInfoViewState();
}

class _ProfileInfoViewState extends State<ProfileInfoView>
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
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = ProfileInfoLocalizations.of(context);
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.profileInfoTitle),
          ),
          body: state.user == null
              ? CenteredCircularProgressIndicator()
              : Column(
                  children: [
                    GrowthInTabBar(
                      tabController: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            l10n.infoTabLabel,
                          ),
                        ),
                        Tab(
                          text: l10n.filesTabLabel,
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
                            Info(),
                            Center(child: Text('Files')),
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

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        final selectedCompany =
            state.user?.companies.firstWhere((company) => company.isSelected);
        final l10n = ProfileInfoLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final theme = GrowthInTheme.of(context);
        return ListView(
          children: [
            VerticalGap.large(),
            Text(
              l10n.companyRepresentativeSectionTitle,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Company rep name goes here',
              style: textTheme.bodySmall?.copyWith(
                color: Color(0xFF8D9695),
              ),
            ),
            VerticalGap.large(),
            Text(l10n.fullNameFieldLabel),
            VerticalGap.small(),
            TextFormField(
              initialValue: state.user!.name,
              style: TextStyle(color: Color(0xFFADADAD)),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Spacing.small,
                ),
              ),
            ),
            VerticalGap.large(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.countryFieldLabel),
                    VerticalGap.small(),
                    SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: Spacing.small,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${state.user!.countryCode} +',
                                style: textTheme.titleMedium?.copyWith(
                                  color: Color(0xFFADADAD),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                HorizontalGap.medium(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.phoneNumberFieldLabel),
                      VerticalGap.small(),
                      TextFormField(
                        initialValue: state.user!.phone,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Color(0xFFADADAD)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: Spacing.small,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalGap.large(),
            Text(l10n.companyNameFieldLabel),
            VerticalGap.small(),
            TextFormField(
              initialValue: selectedCompany!.name,
              style: TextStyle(color: Color(0xFFADADAD)),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: Spacing.small,
                ),
              ),
            ),
            VerticalGap.large(),
            Divider(),
            VerticalGap.xxxLarge(),
            // social media
            Text(
              l10n.socialMediaSectionTitle,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            VerticalGap.large(),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F7F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    child: SvgAsset(
                      AssetPathConstants.facebookPath,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  HorizontalGap.xSmall(),
                  Expanded(
                    child: Stack(
                      children: [
                        TextFormField(
                          initialValue: 'facebook.com/dummy_user',
                          style: textTheme.titleSmall
                              ?.copyWith(color: Color(0xFFADADAD)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: Spacing.small,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          top: 0,
                          bottom: 0,
                          child: Row(
                            children: [
                              Container(
                                width: 1,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme.borderColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFFB22F2F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalGap.medium(),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F7F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    child: SvgAsset(
                      AssetPathConstants.instaPath,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  HorizontalGap.xSmall(),
                  Expanded(
                    child: Stack(
                      children: [
                        TextFormField(
                          initialValue: 'instagram.com/dummy_user',
                          style: textTheme.titleSmall
                              ?.copyWith(color: Color(0xFFADADAD)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: Spacing.small,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          end: 0,
                          top: 0,
                          bottom: 0,
                          child: Row(
                            children: [
                              Container(
                                width: 1,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme.borderColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFFB22F2F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
