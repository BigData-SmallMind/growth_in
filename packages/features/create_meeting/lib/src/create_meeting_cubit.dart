import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'create_meeting_state.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit({
    required this.meetingRepository,
  }) : super(
          const CreateMeetingState(),
        );
  final MeetingRepository meetingRepository;


// @override
// Future<void> close() async {
//   return super.close();
// }
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
}
