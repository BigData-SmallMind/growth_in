class FileDM {
  final String name;
  final String extension;
  final int size;
  final String? dlUrl;

  FileType get type => categorizeFileType(extension);

  FileDM({
    required this.name,
    required this.extension,
    required this.size,
    this.dlUrl,
  });
}

enum FileType {
  document,
  image,
  audio,
  video,
  compressed,
  code,
  discImage,
  unknown,
}

FileType categorizeFileType(String extension) {
  // Get the file extension

  // Determine the file category based on the extension using switch
  switch (extension.toLowerCase()) {
    case 'txt':
    case 'csv':
    case 'doc':
    case 'docx':
    case 'odt':
    case 'pdf':
    case 'ppt':
    case 'pptx':
      return FileType.document;

    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'gif':
    case 'bmp':
    case 'svg':
    case 'webp':
      return FileType.image;

    case 'mp3':
    case 'wav':
    case 'ogg':
    case 'aac':
      return FileType.audio;

    case 'mp4':
    case 'avi':
    case 'mov':
    case 'wmv':
    case 'mkv':
      return FileType.video;

    case 'zip':
    case 'rar':
    case 'tar':
    case 'gz':
      return FileType.compressed;

    case 'html':
    case 'css':
    case 'js':
    case 'json':
    case 'xml':
      return FileType.code;

    case 'iso':
      return FileType.discImage;

    default:
      return FileType.unknown;
  }
}
