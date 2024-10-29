import 'package:component_library/component_library.dart';
import 'package:file/src/file_cubit.dart';
import 'package:file/src/l10n/file_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:user_repository/user_repository.dart';

class FileScreen extends StatelessWidget {
  const FileScreen({
    required this.userRepository,
    required this.folderRepository,
    required this.onCommentsTapped,
    super.key,
  });

  final UserRepository userRepository;
  final FolderRepository folderRepository;
  final VoidCallback onCommentsTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileCubit>(
      create: (_) => FileCubit(
        userRepository: userRepository,
        folderRepository: folderRepository,
        onCommentsTapped: onCommentsTapped,
      ),
      child: const FileView(),
    );
  }
}

class FileView extends StatelessWidget {
  const FileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = FileLocalizations.of(context);
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<FileCubit>();
    return BlocConsumer<FileCubit, FileState>(
      listenWhen: (previous, current) =>
          previous.approvalStatus != current.approvalStatus ||
          previous.rejectionStatus != current.rejectionStatus,
      listener: (context, state) {
        if (state.approvalStatus == ApprovalStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SuccessSnackBar(
              context: context,
              message: l10n.fileApprovalSuccessSnackBarMessage,
            ),
          );
          Navigator.pop(context);
        } else if (state.approvalStatus == ApprovalStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(context: context),
          );
          Navigator.pop(context);
        } else if (state.rejectionStatus == RejectionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(
              context: context,
              message: l10n.fileRejectionSuccessSnackBarMessage,
            ),
          );
          Navigator.pop(context);
        } else if (state.rejectionStatus == RejectionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(
              context: context,
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(state.folder!.project?.name ?? ''),
                ),
                const Spacer(),
                IconButton(
                  onPressed: cubit.onCommentsTapped,
                  icon: const SvgAsset(
                    AssetPathConstants.commentsButtonPath,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(theme.screenMargin),
            child: Column(
              children: [
                FolderDetails(folder: state.folder!),
                VerticalGap.medium(),
                Row(
                  children: [
                    Text(
                      l10n.assetsSectionTitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF797979),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        cubit.downloadFiles(
                            state.file!.assets.map((e) => e.name).toList());
                      },
                      child: Text(
                        l10n.downloadAllTextButtonLabel,
                        style: textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalGap.medium(),
                Expanded(
                  child: GridView.builder(
                      itemCount: state.file!.assets.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2.5),
                      itemBuilder: (context, index) {
                        final asset = state.file!.assets[index];
                        return InkWell(
                          onTap: () {
                            cubit.downloadFiles([asset.name]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: theme.borderColor,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    state.file!.assets[index].name,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SvgAsset(
                                    AssetPathConstants.fileV2Path,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const Spacer(),
                GrowthInElevatedButton(
                  label: l10n.verifyFileButtonLabel,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (context) {
                        return FileVerificationBottomSheet(
                          onTap: () => cubit.approveFile(shouldApprove: true),
                          asset: const SvgAsset(
                            AssetPathConstants.verifyFilePath,
                          ),
                          title: l10n.verifyFileMessageTitle,
                          body: l10n.verifyFileMessageBody,
                          buttonLabel: l10n.verifyFileButtonLabel,
                          buttonColor: theme.secondaryColor,
                        );
                      },
                    );
                  },
                  height: 45,
                  bgColor: theme.secondaryColor,
                ),
                VerticalGap.medium(),
                GrowthInElevatedButton(
                  label: l10n.rejectFileButtonLabel,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      isDismissible: false,
                      builder: (context) {
                        return FileVerificationBottomSheet(
                          onTap: () => cubit.approveFile(shouldApprove: false),
                          asset: const SvgAsset(
                            AssetPathConstants.rejectFilePath,
                          ),
                          title: l10n.rejectFileMessageTitle,
                          body: l10n.rejectFileMessageBody,
                          buttonLabel: l10n.rejectFileButtonLabel,
                          buttonColor: theme.errorColor,
                        );
                      },
                    );
                  },
                  height: 45,
                  bgColor: theme.materialThemeData.colorScheme.surface,
                  labelColor: theme.errorColor,
                  borderColor: theme.errorColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class FileVerificationBottomSheet extends StatelessWidget {
  const FileVerificationBottomSheet({
    super.key,
    required this.onTap,
    required this.asset,
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.buttonColor,
  });

  final VoidCallback onTap;
  final SvgAsset asset;
  final String title;
  final String body;
  final String buttonLabel;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = FileLocalizations.of(context);
    bool submissionInProgress = false;

    return StatefulBuilder(builder: (context, state) {
      return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(theme.screenMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  asset,
                  VerticalGap.medium(),
                  Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                  VerticalGap.medium(),
                  Text(
                    body,
                    style: textTheme.bodyMedium,
                  ),
                  VerticalGap.medium(),
                  submissionInProgress == true
                      ? GrowthInElevatedButton.inProgress(
                          label: buttonLabel,
                          height: 45,
                        )
                      : GrowthInElevatedButton(
                          label: buttonLabel,
                          onTap: () {
                            submissionInProgress = true;
                            state(() {});
                            onTap();
                          },
                          height: 45,
                          bgColor: buttonColor,
                        ),
                  VerticalGap.medium(),
                  GrowthInElevatedButton(
                    label: l10n.cancelButtonLabel,
                    onTap: submissionInProgress == true
                        ? null
                        : () => Navigator.of(context).pop(),
                    height: 45,
                    bgColor: theme.materialThemeData.colorScheme.surface,
                    labelColor: buttonColor,
                    borderColor: buttonColor,
                  )
                ],
              ),
            );
          });
    });
  }
}
