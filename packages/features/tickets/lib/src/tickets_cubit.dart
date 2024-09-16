import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit({
    required this.userRepository,
  }) : super(const TicketsState()) {
    getTickets();
  }

  final UserRepository userRepository;

  // get tickets

  Future getTickets() async {
    final loadingState =
        state.copyWith(fetchingStatus: TicketsFetchingStatus.inProgress);
    emit(loadingState);
    try {
      final tickets = await userRepository.getTickets();
      final successState = state.copyWith(
        fetchingStatus: TicketsFetchingStatus.success,
        tickets: tickets,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: TicketsFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
