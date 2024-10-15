import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:create_meeting/src/l10n/create_meeting_localizations.dart';
import 'package:create_meeting/src/create_meeting_cubit.dart';
import 'package:meeting_repository/meeting_repository.dart';

class CreateMeetingScreen extends StatelessWidget {
  const CreateMeetingScreen({
    required this.meetingRepository,
    super.key,
  });

  final MeetingRepository meetingRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMeetingCubit>(
      create: (_) => CreateMeetingCubit(meetingRepository: meetingRepository),
      child: const CreateMeetingView(),
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
        final colorScheme =
            GrowthInTheme.of(context).materialThemeData.colorScheme;
        final theme = GrowthInTheme.of(context);
        // final textTheme = Theme.of(context).textTheme;

        return Scaffold(
            appBar: AppBar(),
            body: Stepper(
              connectorThickness: 5,
              onStepContinue: () {},
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return GrowthInElevatedButton(
                  label: 'l10n.nextStepButtonLabel',
                  onTap: details.onStepContinue,
                );
              },
              type: StepperType.horizontal,
              currentStep: state.currentStep,
              steps: [
                Step(
                  isActive: state.currentStep >= 0,
                  title: const SizedBox(),
                  content: Column(
                    children: [
                      const TextField(),
                      VerticalGap.large(),
                    ],
                  ),
                  label: state.currentStep == 0
                      ? const Text('l10n.stepOneLabel')
                      : null,
                ),
                Step(
                  isActive: state.currentStep >= 1,
                  title: const SizedBox(),
                  content: const Text('sdasad'),
                  label: state.currentStep == 1
                      ? const Text('l10n.stepTwoLabel')
                      : null,
                ),
                Step(
                  isActive: state.currentStep == 2,
                  title: const SizedBox(),
                  content: const Text('sdasad'),
                  label: state.currentStep == 2
                      ? const Text('l10n.stepThreeLabel')
                      : null,
                ),
              ],
            ));
      },
    );
  }
}
