import 'dart:io';

import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class FileUploadQuestion extends StatefulWidget {
  const FileUploadQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<List<File>> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<FileUploadQuestion> createState() => _FileUploadQuestionState();
}

class _FileUploadQuestionState extends State<FileUploadQuestion> {
  List<FileDM> files = [];

  void pickFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      final newFiles =
          result.files.map((platformFile) => File(platformFile.path!)).toList();
      final filesDM = newFiles
          .map(
            (file) => FileDM(
              name: file.path.split('/').last,
              extension: file.path.split('.').last,
              size: file.lengthSync(),
            ),
          )
          .toList();
      files.addAll(filesDM);
      widget.onChanged(newFiles);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(
        left: Spacing.mediumLarge,
        right: Spacing.mediumLarge,
        top: Spacing.mediumLarge,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.error == FormQuestionValidationError.empty
              ? theme.errorColor
              : theme.borderColor,
        ),
        borderRadius: BorderRadius.circular(theme.textFieldBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.text + (widget.question.isRequired ? ' *' : ''),
            style: textTheme.labelMedium,
          ),
          VerticalGap.small(),
          Text(
            widget.question.description,
            style: textTheme.bodySmall?.copyWith(
              color: theme.questionDescriptionColor,
            ),
          ),
          VerticalGap.medium(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: pickFiles,
                child: const SvgAsset(
                  AssetPathConstants.pickFilesPath,
                  height: 60,
                ),
              ),
              HorizontalGap.large(),
              Expanded(
                child: Files(
                  files: [
                    if (widget.question.answer != null)
                      ...widget.question.answer as List<FileDM>,
                    ...files,
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
