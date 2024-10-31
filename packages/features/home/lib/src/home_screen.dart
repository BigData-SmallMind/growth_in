import 'package:cms_repository/cms_repository.dart';
import 'package:component_library/component_library.dart';
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
    required this.onMeetingTapped,
    required this.onPostTapped,
    required this.onRequestTapped,
  });

  final UserRepository userRepository;
  final CmsRepository cmsRepository;
  final MeetingRepository meetingRepository;
  final VoidCallback onViewAllPostsTapped;
  final VoidCallback onNavigateToFolders;
  final ValueSetter<int> onMeetingTapped;
  final ValueSetter<int> onPostTapped;
  final ValueSetter<int> onRequestTapped;

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
        onMeetingTapped: widget.onMeetingTapped,
        onPostTapped: widget.onPostTapped,
        onRequestTapped: widget.onRequestTapped,
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
                                  child: GestureDetector(
                                    onTap: () => cubit.onNavigateToMeeting(
                                        state.home!.meeting!),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.all(Spacing.medium),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: kElevationToShadow[1]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(l10n
                                                  .upcomingMeetingSectionTitle),
                                              const Spacer(),
                                              SvgAsset(
                                                AssetPathConstants.videoPath,
                                                color: theme.primaryColor,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            state.home!.meeting?.title ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                textTheme.titleMedium?.copyWith(
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // state.home.meeting.type
                                          VerticalGap.small(),
                                          Text(
                                            state.home!.meeting?.type ?? '',
                                            style:
                                                textTheme.labelSmall?.copyWith(
                                              color: theme.dimmedTextColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            state.home!.meeting?.startDate
                                                    ?.toIso8601String()
                                                    .split('T')
                                                    .first ??
                                                '',
                                            style:
                                                textTheme.bodyMedium?.copyWith(
                                              color: theme.dimmedTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                                  (state.home!.filesCount ?? 0)
                                                      .toString(),
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed:
                                                      cubit.onNavigateToFolders,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalGap.large(),
                          if (state.home!.requests.isNotEmpty) ...[
                            Text(
                              l10n.requestsSectionTitle,
                              style: textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            VerticalGap.medium(),
                            GestureDetector(
                              onTap: () => cubit
                                  .onRequestTapped(state.home!.requests[0].id),
                              child: Container(
                                padding: const EdgeInsets.all(Spacing.medium),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: theme.errorColor,
                                      width: 5,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: kElevationToShadow[1],
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.home!.requests[0].name,
                                          style: textTheme.titleMedium,
                                        ),
                                        Text(
                                          state.home!.requests[0].startDate
                                              .toIso8601String()
                                              .split('T')
                                              .first,
                                          style: textTheme.bodyMedium?.copyWith(
                                              color: theme.dimmedTextColor),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                            VerticalGap.large(),
                          ],
                          if (state.home!.posts.isNotEmpty) ...[
                            Row(
                              children: [
                                Text(
                                  l10n.postsSectionTitle,
                                  style: textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: cubit.onViewAllPostsTapped,
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
                            ColumnBuilder(
                                itemBuilder: (context, index) {
                                  final post = state.home!.posts[index];
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          DayNameWidget(
                                            dateTime: post.publicationDate,
                                          ),
                                          HorizontalGap.medium(),
                                          Expanded(
                                            child: PostCard(
                                              post: post,
                                              onTap: () =>
                                                  cubit.onNavigateToPost(post),
                                            ),
                                          ),
                                        ],
                                      ),
                                      VerticalGap.medium(),
                                    ],
                                  );
                                },
                                itemCount: state.home!.posts.length),
                            VerticalGap.large(),
                          ],
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
