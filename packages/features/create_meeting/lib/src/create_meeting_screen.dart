import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:intl/intl.dart' as intl;
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
    return BlocConsumer<CreateMeetingCubit, CreateMeetingState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final l10n = CreateMeetingLocalizations.of(context);
        final theme = GrowthInTheme.of(context);
        final fetchingMeetingTypes =
            state.meetingTypesFetchStatus == MeetingTypesFetchStatus.inProgress;
        final cubit = context.read<CreateMeetingCubit>();
        final isLoadingSlots = state.availableSlotsFetchStatus ==
            AvailableSlotsFetchStatus.loading;
        final textTheme = Theme.of(context).textTheme;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
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
                        onStepTapped: cubit.onStepTapped,
                        margin: EdgeInsets.zero,
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
                            content: MeetingSlotPicker(
                              expandCalendar: false,
                              isLoadingSlots: isLoadingSlots,
                              getAvailableSlots: cubit.getAvailableSlots,
                              availableSlots: state.availableSlots,
                              selectedMeetingSlot: state.selectedSlot,
                              selectMeetingSlot: cubit.selectMeetingSlot,
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
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (state.title.value?.isNotEmpty == true)
                                  Text(
                                    state.title.value!,
                                    style: textTheme.titleMedium,
                                  ),
                                if (state.description?.isNotEmpty == true) ...[
                                  VerticalGap.medium(),
                                  Text(
                                    state.description!,
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                                if (state.files.isNotEmpty) ...[
                                  VerticalGap.medium(),
                                  Files(
                                    files: state.filesDM,
                                  ),
                                ],
                                VerticalGap.medium(),
                                const Divider(),
                                VerticalGap.medium(),
                                if (state.currentStep == 2) ...[
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          l10n.typeTextFieldLabel,
                                          style: textTheme.titleSmall,
                                        ),
                                      ),
                                      Text(
                                        state.selectedType.value!.name,
                                        style: textTheme.titleSmall,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  VerticalGap.medium(),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          l10n.selectedSlotLabel,
                                          style: textTheme.titleSmall,
                                        ),
                                      ),
                                      Text(
                                        state.selectedSlot!.start
                                            .formatDateTimeTo12Hour()!,
                                        style: textTheme.titleSmall,
                                        maxLines: 1,
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ],
                                  ),
                                  VerticalGap.medium(),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          l10n.selectedDayLabel,
                                          style: textTheme.titleSmall,
                                        ),
                                      ),
                                      Text(
                                        intl.DateFormat('EEEE, yyyy-MM-dd')
                                            .format(state.selectedDay!),
                                        style: textTheme.titleSmall,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ]
                              ],
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(theme.screenMargin),
                      child: isSubmissionInProgress
                          ? GrowthInElevatedButton.inProgress(
                              label: l10n.lastStepButtonLabel,
                            )
                          : GrowthInElevatedButton(
                              label: state.currentStep == 2
                                  ? l10n.lastStepButtonLabel
                                  : l10n.nextStepButtonLabel,
                              onTap: (state.currentStep == 1 &&
                                          state.selectedSlot == null) ||
                                      (state.availableSlotsFetchStatus ==
                                          AvailableSlotsFetchStatus.loading)
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
