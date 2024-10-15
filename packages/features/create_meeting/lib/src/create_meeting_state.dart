part of 'create_meeting_cubit.dart';

class CreateMeetingState extends Equatable {
  const CreateMeetingState({
    this.currentStep = 0,
  });

  final int currentStep;

  CreateMeetingState copyWith({
    int? currentStep,
  }) {
    return CreateMeetingState(
      currentStep: currentStep ?? this.currentStep,

    );
  }

  @override
  List<Object?> get props => [
        currentStep,

      ];
}


