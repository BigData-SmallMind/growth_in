import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_cubit.dart';
import 'package:home/src/l10n/home_localizations.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userRepository,
    required this.cmsRepository,
    required this.meetingRepository,
    required this.onViewAllPostsTapped,
    required this.onNavigateToFolders,
    required this.onViewAlMeetingsTapped,
    required this.onMeetingTapped,
    required this.onPostTapped,
  });

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final MeetingRepository meetingRepository;
  final VoidCallback onViewAllPostsTapped;
  final VoidCallback onNavigateToFolders;
  final VoidCallback onViewAlMeetingsTapped;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<int> onPostTapped;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(
        cmsRepository: widget.cmsRepository,
        userRepository: widget.userRepository,
        meetingRepository: widget.meetingRepository,
        onNavigateToFolders: widget.onNavigateToFolders,
        onViewAllPostsTapped: widget.onViewAllPostsTapped,
        onViewAllMeetingsTapped: widget.onViewAlMeetingsTapped,
        onMeetingTapped: widget.onMeetingTapped,
        onPostTapped: widget.onPostTapped,
      ),
      child: const HomeView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = HomeLocalizations.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final loading = state.fetchingStatus == HomeFetchingStatus.inProgress;
        final error = state.fetchingStatus == HomeFetchingStatus.failure;
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            flexibleSpace: const SvgAsset(
              AssetPathConstants.appBarBgPath,
              fit: BoxFit.fitWidth,
            ),
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.appBarGreetingMessage,
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white)),
                if (state.user != null)
                  Text(
                    state.user!.name,
                    style: textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: () {
                        context.read<HomeCubit>().getHome();
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeCubit>().getHome();
                      },
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.screenMargin,
                          vertical: Spacing.medium,
                        ),
                        children: [
                          SizedBox(
                            height: 160,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(Spacing.medium),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: kElevationToShadow[1]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.unpublishedPostsContainerTitle,
                                          style:
                                              textTheme.titleMedium?.copyWith(
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          '25',
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'تبقى 5 منشورات لم تحمل بعد',
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xFF797979)),
                                            )),
                                            TextButton(
                                              onPressed: cubit.onViewAllPostsTapped,
                                              child: Row(
                                                children: [
                                                  Text(l10n
                                                      .continuePublishingButtonLabel),
                                                  const Icon(
                                                      Icons.arrow_forward)
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                HorizontalGap.smallMedium(),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 110,
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          top: Spacing.medium,
                                          start: Spacing.medium,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: kElevationToShadow[1]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              l10n.unapprovedFilesContainerTitle,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  '4',
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: cubit.onNavigateToFolders,
                                                  icon: Icon(
                                                    Icons.arrow_forward,
                                                    color: theme.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 40,
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          start: Spacing.medium,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: kElevationToShadow[1]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              l10n.dashboardContainerTitle,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                color: theme.primaryColor,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: state.home
                                                          ?.dashboardLink !=
                                                      null
                                                  ? () =>
                                                      cubit.onGoToDashboard()
                                                  : null,
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: theme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   height: 90,
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black.withOpacity(0.3),
                                      //     borderRadius: BorderRadius.circular(10),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalGap.large(),
                          if (state.home!.post != null) ...[
                            Row(
                              children: [
                                Text(l10n.recentPostsSectionTitle),
                                const Spacer(),
                                TextButton(
                                  onPressed: cubit.onViewAllPostsTapped,
                                  child: Text(
                                    l10n.viewAllButtonLabel,
                                    style: textTheme.bodyMedium?.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            VerticalGap.medium(),
                            Row(children: [
                              DayNameWidget(
                                dateTime: state.home!.post!.publicationDate,
                              ),
                              HorizontalGap.medium(),
                              Expanded(
                                child: PostCard(
                                  post: state.home!.post!,
                                  onTap: () =>
                                      cubit.onNavigateToPost(state.home!.post!),
                                ),
                              ),
                            ]),
                            VerticalGap.large(),
                          ],
                          if (state.home!.meeting != null) ...[
                            Row(
                              children: [
                                Text(l10n.upcomingMeetingSectionTitle),
                                const Spacer(),
                                TextButton(
                                  onPressed: cubit.onViewAllMeetingsTapped,
                                  child: Text(
                                    l10n.viewAllButtonLabel,
                                    style: textTheme.bodyMedium?.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalGap.medium(),
                            MeetingCard(
                              meeting: state.home!.meeting!,
                              type: MeetingCardVariation.upcoming,
                              onTap: () => cubit
                                  .onNavigateToMeeting(state.home!.meeting!),
                            )
                          ],
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
