import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:submit_ticket/src/components/components.dart';
import 'package:submit_ticket/src/l10n/submit_ticket_localizations.dart';
import 'package:submit_ticket/src/submit_ticket_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SubmitTicketBottomSheet extends StatelessWidget {
  const SubmitTicketBottomSheet({
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubmitTicketCubit>(
      create: (_) => SubmitTicketCubit(
        userRepository: userRepository,
      ),
      child: GestureDetector(
        onTap: context.releaseFocus,
        child: const SubmitTicketView(),
      ),
    );
  }
}

class SubmitTicketView extends StatelessWidget {
  const SubmitTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = SubmitTicketLocalizations.of(context);
    return BlocConsumer<SubmitTicketCubit, SubmitTicketState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          // if (true) {
          Navigator.pop(context);
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              marginalSpace: EdgeInsets.only(
                bottom: Spacing.huge,
                left: theme.screenMargin,
                right: theme.screenMargin,
              ),
              message: l10n.ticketSubmissionSuccessSnackBarMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final typeError = state.type.isNotValid ? state.type.error : null;
        final textTheme = Theme.of(context).textTheme;
        final l10n = SubmitTicketLocalizations.of(context);
        final cubit = context.read<SubmitTicketCubit>();
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          builder: (context, scrollController) => ListView(
            padding: const EdgeInsets.all(Spacing.medium),
            controller: scrollController,
            children: [
              if (state.ticketsTypes.isNotEmpty) ...[
                const TicketTypeSelector(),
                VerticalGap.medium(),
              ],
              if (typeError == DynamicValidationError.empty) ...[
                Text(
                  l10n.requiredFieldErrorMessage,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
                VerticalGap.medium(),
              ],
              const TitleTextField(),
              VerticalGap.medium(),
              const DescriptionTextField(),
              VerticalGap.medium(),
              isSubmissionInProgress
                  ? GrowthInElevatedButton.inProgress(
                      label: l10n.submissionInProgressButtonLabel,
                      height: 40,
                    )
                  : GrowthInElevatedButton(
                      label: l10n.submitButtonLabel,
                      onTap: cubit.onSubmit,
                      height: 40,
                    )
            ],
          ),
        );
      },
    );
  }
}

class TicketTypeSelector extends StatelessWidget {
  const TicketTypeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubmitTicketCubit, SubmitTicketState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return Wrap(
          spacing: Spacing.medium,
          children: state.ticketsTypes
              .map(
                (ticketType) => TicketTypeChoiceChip(
                  ticketType: ticketType,
                  isSubmissionInProgress: isSubmissionInProgress,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class TicketTypeChoiceChip extends StatelessWidget {
  const TicketTypeChoiceChip({
    super.key,
    required this.ticketType,
    required this.isSubmissionInProgress,
  });

  final TicketType ticketType;
  final bool isSubmissionInProgress;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SubmitTicketCubit, SubmitTicketState,
        Dynamic<TicketType?>>(
      selector: (state) {
        final selectedProblemType = state.type;
        return selectedProblemType;
      },
      builder: (context, selectedType) {
        final isSelected = selectedType.value?.id == ticketType.id;
        final ticketTypeError =
            selectedType.isNotValid ? selectedType.error : null;

        final theme = GrowthInTheme.of(context);
        return ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            side: BorderSide(
              color: isSelected
                  ? Colors.transparent
                  : ticketTypeError != null
                      ? Colors.red
                      : theme.borderColor,
            ),
          ),
          checkmarkColor: Colors.white,
          label: Text(
            ticketType.name,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          selected: isSelected,
          onSelected: isSubmissionInProgress
              ? null
              : (isSelected) {
                  final cubit = context.read<SubmitTicketCubit>();
                  cubit.onTypeChanged(
                    ticketType,
                  );
                },
        );
      },
    );
  }
}
