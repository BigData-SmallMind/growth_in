import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({
    super.key,
    required this.urls,
    this.child,
  });

  final List<String> urls;
  final Widget? child;

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  /// [_port] is used to communicate with the isolates.
  final ReceivePort _port = ReceivePort();

  /// [downloadTaskId] variable is used to store the id of the download task created when the [FlutterDownloader.enqueue] method is called.
  String? downloadTaskId;

  /// [downloadTaskStatus] is used to store the task status.
  int downloadTaskStatus = 0;

  /// [downloadTaskProgress] store the progress of the download task. ranging between 1 to 100.
  int downloadTaskProgress = 0;

  /// [isDownloading] is set to true if the file is being downloaded.
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    initDownloadController();
  }

  @override
  void dispose() {
    disposeDownloadController();
    if (isDownloading) {
      FlutterDownloader.cancel(taskId: downloadTaskId ?? '');
    }
    super.dispose();
  }

  /// [initDownloadController] method will initialize the downloader controller and perform certain operations like registering the port, initializing the register callback etc.
  initDownloadController() {
    log('DownloadsController - initDownloadController called');
    _bindBackgroundIsolate();
  }

  /// [disposeDownloadController] is used to unbind the isolates and dispose the controller
  disposeDownloadController() {
    _unbindBackgroundIsolate();
  }

  /// [_bindBackgroundIsolate] is used to register the [SendPort] with the name [downloader_send_port].
  /// If the registration is successful then it will return true else it will return false.
  _bindBackgroundIsolate() async {
    log('DownloadsController - _bindBackgroundIsolate called');
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );

    log('_bindBackgroundIsolate - isSuccess = $isSuccess');

    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    } else {
      _port.listen((message) {
        setState(
          () {
            downloadTaskId = message[0];
            downloadTaskStatus = message[1];
            downloadTaskProgress = message[2];
          },
        );

        if (message[1] == 2) {
          isDownloading = true;
        } else {
          isDownloading = false;
        }
      });
      await FlutterDownloader.registerCallback(registerCallback);
    }
  }

  /// [_unbindBackgroundIsolate] is used to remove the registered [SendPort] [downloader_send_port]'s mapping.
  void _unbindBackgroundIsolate() {
    log('DownloadsController - _unbindBackgroundIsolate called');
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  /// [registerCallback] is used to update the download progress
  @pragma('vm:entry-point')
  static registerCallback(String id, int status, int progress) {
    log("DownloadsController - registerCallback - task id = $id, status = $status, progress = $progress");

    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  /// [downloadFile] method is used to download the enqueue the file to be downloaded using the [url].
  Future<void> downloadFile({required String url}) async {
    log('DownloadsController - downloadFile called');
    log('DownloadsController - downloadFile - url = $url');
    setState(() {
      isDownloading = true;
    });

    /// [downloadDirPath] var stores the path of device's download directory path.
    late String downloadDirPath;
    if (Platform.isIOS) {
      downloadDirPath = (await getApplicationDocumentsDirectory()).path;
    } else {
      downloadDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    downloadTaskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      // optional: header send with url (auth token etc)
      savedDir: downloadDirPath,
      saveInPublicStorage: true,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on the notification to open the downloaded file (for Android)
    );
  }

  /// [pauseDownload] pauses the current download task
  Future pauseDownload() async {
    await FlutterDownloader.pause(taskId: downloadTaskId ?? '');
  }

  /// [resumeDownload] resumes the paused download task
  Future resumeDownload() async {
    await FlutterDownloader.resume(taskId: downloadTaskId ?? '');
  }

  /// [cancelDownload] cancels the current download task
  Future cancelDownload() async {
    await FlutterDownloader.cancel(taskId: downloadTaskId ?? '');
    setState(() {
      isDownloading = false;
    });
  }

  /// [getDownloadStatusString] returns the status of the download task in string format to show on the screen.
  String getDownloadStatusString() {
    late String downloadStatus;

    switch (downloadTaskStatus) {
      case 0:
        downloadStatus = 'Undefined';
        break;
      case 1:
        downloadStatus = 'Enqueued';
        break;
      case 2:
        downloadStatus = 'Downloading';
        break;
      case 3:
        downloadStatus = 'Failed';
        break;
      case 4:
        downloadStatus = 'Canceled';
        break;
      case 5:
        downloadStatus = 'Paused';
        break;
      default:
        downloadStatus = "Error";
    }

    return downloadStatus;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        for (String url in widget.urls) {
          downloadFile(url: url);
        }
      },
      child: isDownloading
          ? Stack(
              children: [
                CircularProgressIndicator(
                  value: downloadTaskProgress.toDouble() / 100,
                ),
                Center(
                  child: Text(
                    '$downloadTaskProgress%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            )
          : widget.child ?? const SvgAsset(AssetPathConstants.downloadPath),
    );
  }
}
