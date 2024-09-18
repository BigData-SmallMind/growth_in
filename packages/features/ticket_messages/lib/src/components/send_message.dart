import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_messages/src/l10n/ticket_messages_localizations.dart';
import 'package:ticket_messages/src/ticket_messages_cubit.dart';



class SendMessage extends StatefulWidget {
  const SendMessage({Key? key}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  bool attachVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = TicketMessagesLocalizations.of(context);
    final cubit = context.read<TicketMessagesCubit>();
    return BlocBuilder<TicketMessagesCubit, TicketMessagesState>(
      builder: (context, state) {
        final submissionInProgress =
            state.submissionStatus == TicketMessagesSubmissionStatus.inProgress;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: attachVisible ? 150 : 60,
          padding: EdgeInsets.symmetric(
            horizontal: theme.screenMargin,
            vertical: Spacing.small,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFF4F4F4),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cubit.messageController,
                        enabled: !submissionInProgress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Spacing.medium,
                          ),
                        ),
                        onEditingComplete: cubit.sendMessage,
                        onChanged: cubit.onMessageChanged,
                      ),
                    ),
                    HorizontalGap.medium(),
                    Stack(
                      children: [
                        IconButton(
                          icon: SvgAsset(
                            AssetPathConstants.addPath,
                          ),
                          onPressed: () {
                            attachVisible = !attachVisible;
                            setState(() {});
                          },
                        ),
                        if (state.file != null)
                          PositionedDirectional(
                            start: 0,
                            top: 0,
                            child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.attach_file,
                                  size: 10,
                                  color: Colors.white,
                                )),
                          )
                      ],
                    ),
                    submissionInProgress
                        ? Transform.scale(
                            scale: 0.5,
                            child: CenteredCircularProgressIndicator(),
                          )
                        : IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                state.isMessageEmpty
                                    ? Colors.grey
                                    : Color(0xFF2B9279),
                              ),
                              shape: WidgetStateProperty.all(
                                CircleBorder(),
                              ),
                            ),
                            icon: SvgAsset(AssetPathConstants.sendPath),
                            onPressed:
                                state.isMessageEmpty ? null : cubit.sendMessage,
                          ),
                  ],
                ),
              ),
              if (attachVisible) ...[
                VerticalGap.medium(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.file != null) ...[
                      Column(
                        children: [
                          IconButton(

                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.white,
                              ),
                              shape: WidgetStateProperty.all(
                                CircleBorder(),
                              ),
                            ),
                            icon:
                                Icon(Icons.cancel_outlined, color: Colors.red),
                            onPressed: submissionInProgress ? null :cubit.deletePickedFile,
                          ),
                          Text(
                            l10n.deleteFileIconLabel,
                          ),
                        ],
                      ),
                      HorizontalGap.medium(),
                    ],
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                          icon: SvgAsset(AssetPathConstants.documentTextPath),
                          onPressed: submissionInProgress? null :cubit.pickFile,
                        ),
                        Text(
                          l10n.uploadFileIconLabel,
                        ),
                      ],
                    ),
                    HorizontalGap.medium(),
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                          icon: SvgAsset(AssetPathConstants.imagePath),
                          onPressed: submissionInProgress ? null :cubit.pickImageFromGallery,
                        ),
                        Text(
                          l10n.uploadImageFromGalleryIconLabel,
                        )
                      ],
                    ),
                    HorizontalGap.medium(),
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                          icon: SvgAsset(AssetPathConstants.cameraPath),
                          onPressed: submissionInProgress? null :cubit.capturePhoto,
                        ),
                        Text(
                          l10n.captureImageIconLabel,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
