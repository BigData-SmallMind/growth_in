import 'package:delete_meeting/src/l10n/delete_meeting_localizations.dart';
import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:delete_meeting/src/delete_meeting_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteMeetingBottomSheet extends StatelessWidget {
  const DeleteMeetingBottomSheet({
    required this.meetingRepository,
    required this.meeting,
    required this.onCancellationSuccess,
    super.key,
  });

  final MeetingRepository meetingRepository;
  final Meeting meeting;
  final VoidCallback onCancellationSuccess;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider<DeleteMeetingCubit>(
      create: (_) => DeleteMeetingCubit(
        meetingRepository: meetingRepository,
        meeting: meeting,
        locale: locale,
        onCancellationSuccess: onCancellationSuccess,
      ),
      child: const DeleteMeetingView(),
    );
  }
}

class DeleteMeetingView extends StatelessWidget {
  const DeleteMeetingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final colorScheme = GrowthInTheme.of(context).materialThemeData.colorScheme;
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = DeleteMeetingLocalizations.of(context);
    return BlocConsumer<DeleteMeetingCubit, DeleteMeetingState>(
      listener: (context, state) {
        final cubit = context.read<DeleteMeetingCubit>();
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.meetingDeletedSuccessfully,
            ),
          );
          cubit.onCancellationSuccess();
        }
      },
      builder: (context, state) {
        final cubit = context.read<DeleteMeetingCubit>();
        final cancellationReasonError = state.cancellationReason.isNotValid
            ? state.cancellationReason.error
            : null;
        final otherTextFieldError = state.otherReasonText.isNotValid
            ? state.otherReasonText.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return Container(
          height: 500,
          padding: EdgeInsets.only(
            left: theme.screenMargin,
            right: theme.screenMargin,
            top: Spacing.small,
            bottom: Spacing.small,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: MeetingCancellationReason.values.length,
                  itemBuilder: (context, index) {
                    final reason = MeetingCancellationReason.values[index];
                    final isSelected = state.cancellationReason.value == reason;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(color: colorScheme.primary)
                                : cancellationReasonError ==
                                        DynamicValidationError.empty
                                    ? Border.all(color: theme.errorColor)
                                    : null,
                          ),
                          child: RadioListTile<MeetingCancellationReason>(
                            title: Text(
                              isArabic ? reason.nameAr : reason.nameEn,
                            ),
                            value: reason,
                            groupValue: state.cancellationReason.value,
                            onChanged: isSubmissionInProgress
                                ? null
                                : cubit.onCancellationReasonChanged,
                          ),
                        ),
                        if (reason == MeetingCancellationReason.other &&
                            isSelected) ...[
                          VerticalGap.mediumLarge(),
                          TextField(
                            enabled: !isSubmissionInProgress,
                            onChanged:
                                cubit.onOtherCancellationTextFieldChanged,
                            decoration: InputDecoration(
                              hintText: l10n.otherReasonTextFieldHint,
                              errorText: otherTextFieldError ==
                                      DynamicValidationError.empty
                                  ? l10n.requiredFieldErrorMessage
                                  : null,
                            ),
                            maxLines: 5,
                          ),
                          VerticalGap.mediumLarge(),
                        ],
                        if (cancellationReasonError ==
                                DynamicValidationError.empty &&
                            index ==
                                MeetingCancellationReason.values.length -
                                    1) ...[
                          VerticalGap.medium(),
                          Text(
                            l10n.requiredTextMessage,
                            style: textTheme.bodyMedium?.copyWith(
                              color: theme.errorColor,
                            ),
                          )
                        ],
                      ],
                    );
                  },
                ),
              ),
              isSubmissionInProgress
                  ? GrowthInElevatedButton.inProgress(
                      label: l10n.confirmMeetingDeletionButtonLabel,
                    )
                  : GrowthInElevatedButton(
                      onTap: cubit.onSubmit,
                      label: l10n.confirmMeetingDeletionButtonLabel,
                      bgColor: colorScheme.surface,
                      labelColor: theme.errorColor,
                      borderColor: theme.errorColor,
                    ),
            ],
          ),
        );
      },
    );
  }
}
