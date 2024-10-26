import 'dart:io';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:component_library/component_library.dart';
import 'package:dio/dio.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';

class ImageAndTextQuestion extends StatefulWidget {
  const ImageAndTextQuestion({
    super.key,
    required this.imageDownloadUrl,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final String imageDownloadUrl;
  final ValueChanged<List<Map<String, dynamic>>?> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<ImageAndTextQuestion> createState() => _ImageAndTextQuestionState();
}

class _ImageAndTextQuestionState extends State<ImageAndTextQuestion> {
  final ImagePicker _imagePicker = ImagePicker();

  List<ImageAndTextAnswer> updatedAnswer = const [];

  bool checkIfFileIsImage(String file) {
    // check if the file is an image by checkign the estension
    // if the extension is in the list of image extensions return true
    // else return false
    final fileString = file.toLowerCase().split('.').last;
    final imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'svg',
      'webp',
      'tiff',
    ];
    return imageExtensions.contains(fileString);
  }

  Future<File?> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,

    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      return file;
    }
    return null;
  }

  Future<File?> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      return file;
    }
    return null;
  }

  void deleteAnswer(int index) {
    updatedAnswer.removeAt(index);
    widget.onChanged(updatedAnswer.map((e) => e.toJson()).toList());
    setState(() {});
  }

  void showGalleryOrCameraDialog() {
    final l10n = ComponentLibraryLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        ImageAndTextAnswer? imageAndTextAnswer;
        final nameController = TextEditingController();
        final descriptionController = TextEditingController();

        return StatefulBuilder(builder: (context, state) {
          return AlertDialog(
            title: Text(l10n.imageAndTextDialogTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final file = await pickImageFromGallery();
                          final image = file?.readAsBytesSync();
                          final multipart = MultipartFile.fromFileSync(
                            file!.path,
                            filename: file.path.split('/').last,
                          );
                          imageAndTextAnswer = ImageAndTextAnswer(
                            name: nameController.text,
                            description: descriptionController.text,
                            imageBytes: image,
                            file: multipart,
                          );
                          state(() {});
                        },
                        icon: const Icon(Icons.photo_library),
                      ),
                      IconButton(
                        onPressed: () async {
                          final file = await capturePhoto();
                          final image = file?.readAsBytesSync();
                          final multipart = MultipartFile.fromFileSync(
                            file!.path,
                            filename: file.path.split('/').last,
                          );
                          imageAndTextAnswer = ImageAndTextAnswer(
                            name: nameController.text,
                            description: descriptionController.text,
                            imageBytes: image,
                            file: multipart,
                          );
                          state(() {});
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                      if (imageAndTextAnswer?.imageBytes != null) ...[
                        ImageViewer(
                          imageBytes: imageAndTextAnswer!.imageBytes!,
                        ),
                      ],
                    ],
                  ),
                  VerticalGap.mediumLarge(),
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      imageAndTextAnswer = imageAndTextAnswer?.copyWith(
                        name: value,
                      );
                      state(() {});
                    },
                    decoration: InputDecoration(
                      labelText: l10n.nameTextFieldLabel,
                    ),
                  ),
                  VerticalGap.mediumLarge(),
                  TextField(
                    controller: descriptionController,
                    onChanged: (value) {
                      imageAndTextAnswer = imageAndTextAnswer?.copyWith(
                        description: value,
                      );
                      state(() {});
                    },
                    decoration: InputDecoration(
                      labelText: l10n.descriptionTextFieldLabel,
                    ),
                  ),
                  VerticalGap.mediumLarge(),
                  GrowthInElevatedButton(
                    label: l10n.addImageTextAnswerButtonLabel,
                    onTap: imageAndTextAnswer?.file != null &&
                            imageAndTextAnswer?.name.isNotEmpty == true &&
                            imageAndTextAnswer?.description.isNotEmpty == true
                        ? () {
                            updatedAnswer.add(imageAndTextAnswer!);
                            widget.onChanged(
                              updatedAnswer.map((e) => e.toJson()).toList(),
                            );
                            Navigator.of(context).pop();
                          }
                        : null,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  void initState() {
    updatedAnswer = (widget.question.answer as List?)
            ?.map(
              (e) => ImageAndTextAnswer(
                imageSlug: e['product_image'],
                description: e['product_description'],
                name: e['product_name'],
              ),
            )
            .toList() ??
        [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: showGalleryOrCameraDialog,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: showGalleryOrCameraDialog,
                            icon:
                                const Icon(Icons.add_photo_alternate_outlined)),
                        HorizontalGap.large(),
                        Text(
                          l10n.addImageAndTextButtonLabel,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  HorizontalGap.large(),
                  ...updatedAnswer.mapIndexed(
                    (index, answer) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (answer.imageSlug != null &&
                                  checkIfFileIsImage(answer.imageSlug!)) ...[
                                ImageViewer(
                                  url:
                                      '${widget.imageDownloadUrl}/${answer.imageSlug}',
                                ),
                                HorizontalGap.mediumLarge(),
                              ],
                              if (answer.imageBytes != null) ...[
                                ImageViewer(
                                  imageBytes: answer.imageBytes!,
                                ),
                                HorizontalGap.mediumLarge(),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      answer.name,
                                    ),
                                    Text(
                                      answer.description,
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: const Color(0xffa3a3a3)),
                                    ),
                                  ],
                                ),
                              ),
                              HorizontalGap.mediumLarge(),
                              IconButton(
                                onPressed: () {
                                  deleteAnswer(index);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      theme.borderColor),
                                ),
                              ),
                            ],
                          ),
                          VerticalGap.mediumLarge(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        if (widget.error != null) ...[
          VerticalGap.smallMedium(),
          Padding(
            padding: const EdgeInsets.only(left: Spacing.mediumLarge),
            child: Text(
              l10n.requiredFieldErrorMessage,
              style: textTheme.bodySmall?.copyWith(color: theme.errorColor),
            ),
          ),
        ]
      ],
    );
  }
}

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    this.imageBytes,
    this.url,
  });

  final Uint8List? imageBytes;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                // insetPadding: EdgeInsets.zero,
                content: InteractiveViewer(
                  clipBehavior: Clip.antiAlias,
                  boundaryMargin: EdgeInsets.zero,
                  child: imageBytes != null
                      ? Image.memory(
                          imageBytes!,
                          fit: BoxFit.cover,
                          width: 50,
                        )
                      : url != null
                          ? Image.network(
                              url!,
                              fit: BoxFit.cover,
                              width: 50,
                            )
                          : const SizedBox(),
                ),
              );
            });
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: imageBytes != null
            ? Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
              )
            : url != null
                ? Image.network(
                    url!,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
      ),
    );
  }
}
