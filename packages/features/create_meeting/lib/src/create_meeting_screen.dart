import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class CreateMeetingScreen extends StatelessWidget {
  const CreateMeetingScreen({
    required this.meetingRepository,
    required this.userRepository,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMeetingCubit>(
      create: (_) => CreateMeetingCubit(
        meetingRepository: meetingRepository,
        userRepository: userRepository,
      ),
      child: GestureDetector(
        onTap: context.releaseFocus,
        child: const CreateMeetingView(),
      ),
    );
  }
}

class CreateMeetingView extends StatelessWidget {
  const CreateMeetingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
      builder: (context, state) {
        final l10n = CreateMeetingLocalizations.of(context);
        final theme = GrowthInTheme.of(context);
        final fetchingMeetingTypes =
            state.meetingTypesFetchStatus == MeetingTypesFetchStatus.inProgress;
        final cubit = context.read<CreateMeetingCubit>();
        return Scaffold(
          appBar: const GrowthInAppBar(
            logoVariation: false,
          ),
          body: fetchingMeetingTypes
              ? const CenteredCircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stepper(
                        connectorThickness: 5,
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return const SizedBox();
                        },
                        type: StepperType.horizontal,
                        currentStep: state.currentStep,
                        steps: [
                          Step(
                            isActive: state.currentStep >= 0,
                            title: const SizedBox(),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleTextField(),
                                VerticalGap.medium(),
                                const DescriptionTextField(),
                                VerticalGap.medium(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: cubit.pickFiles,
                                      child: const SvgAsset(
                                          AssetPathConstants.pickFilesPath),
                                    ),
                                    HorizontalGap.large(),
                                    Expanded(
                                      child: Files(
                                        files: state.filesDM,
                                      ),
                                    )
                                  ],
                                ),
                                const TypeDropdown(),
                              ],
                            ),
                            label: state.currentStep == 0
                                ? Text(l10n.stepOneLabel)
                                : null,
                            stepStyle: StepStyle(
                              connectorColor: state.currentStep >= 0
                                  ? theme.secondaryColor
                                  : null,
                              color: state.currentStep >= 0
                                  ? theme.secondaryColor
                                  : null,
                            ),
                          ),
                          Step(
                            isActive: state.currentStep >= 1,
                            title: const SizedBox(),
                            content: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            label: state.currentStep == 1
                                ? Text(l10n.stepTwoLabel)
                                : null,
                            stepStyle: StepStyle(
                              connectorColor: state.currentStep >= 1
                                  ? theme.secondaryColor
                                  : null,
                              color: state.currentStep >= 1
                                  ? theme.secondaryColor
                                  : null,
                            ),
                          ),
                          Step(
                            isActive: state.currentStep == 2,
                            title: const SizedBox(),
                            content: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            label: state.currentStep == 2
                                ? Text(l10n.stepThreeLabel)
                                : null,
                            stepStyle: StepStyle(
                              connectorColor: state.currentStep == 2
                                  ? theme.secondaryColor
                                  : null,
                              color: state.currentStep == 2
                                  ? theme.secondaryColor
                                  : null,
                            ),
                          ),

                          // Step(
                          //   isActive: state.currentStep >= 1,
                          //   title: const SizedBox(),
                          //   content: const Text('sdasad'),
                          //   label: state.currentStep == 1
                          //       ? Text(l10n.stepTwoLabel)
                          //       : null,
                          // ),
                          // Step(
                          //   isActive: state.currentStep == 2,
                          //   title: const SizedBox(),
                          //   content: const Text('sdasad'),
                          //   label: state.currentStep == 2
                          //       ? Text(l10n.stepThreeLabel)
                          //       : null,
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(theme.screenMargin),
                      child: GrowthInElevatedButton(
                        label: l10n.nextStepButtonLabel,
                        onTap:
                            state.currentStep == 1 && state.selectedSlot == null
                                ? null
                                : cubit.onStepContinue,
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
