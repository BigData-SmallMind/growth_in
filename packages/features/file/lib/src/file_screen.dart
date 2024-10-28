import 'package:file/src/file_cubit.dart';
import 'package:file/src/components/file_button.dart';
import 'package:file/src/components/components.dart';
import 'package:file/src/components/password.dart';
import 'package:file/src/l10n/file_localizations.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({
    required this.userRepository,
    required this.onBackTapped,
    required this.onFileSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onFileSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileCubit>(
      create: (_) => FileCubit(
        userRepository: userRepository,
      ),
      child: FileView(
        onBackTapped: onBackTapped,
        onFileSuccess: onFileSuccess,
      ),
    );
  }
}

class FileView extends StatelessWidget {
  const FileView({
    super.key,
    required this.onBackTapped,
    required this.onFileSuccess,
  });

  final VoidCallback onBackTapped;
  final VoidCallback onFileSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = FileLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<FileCubit, FileState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.changeEmailSuccessMessage,
              marginalSpace: EdgeInsets.only(
                left: theme.screenMargin,
                right: theme.screenMargin,
              ),
            ),
          );
          onFileSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
                context: context,
                message: l10n.generalErrorSnackBarMessage,
                marginalSpace: EdgeInsets.only(
                  left: theme.screenMargin,
                  right: theme.screenMargin,
                )),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: GrowthInAppBar(
              logoVariation: false,
              title: Text(l10n.changeEmailScreenTitle),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: theme.screenMargin,
              ),
              children: [
                VerticalGap.xLarge(),
                Text(
                  l10n.changeEmailScreenTitle,
                  style: textTheme.headlineSmall,
                ),
                VerticalGap.medium(),
                Text(
                  l10n.changeEmailScreenSubtitle,
                  style: textTheme.bodyMedium,
                ),
                VerticalGap.medium(),
                const NewEmail(),
                VerticalGap.medium(),
                const NewEmailConfirmation(),
                VerticalGap.medium(),
                const PasswordWidget(),
                VerticalGap.xLarge(),
                const FileButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
