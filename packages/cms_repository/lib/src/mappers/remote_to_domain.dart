import 'dart:ui';

import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';

extension FolderRMtoDM on FolderRM {
  Folder toDomainModel() {
    return Folder(
      id: id,
      name: name,
      dueDate: DateTime.parse(dueDate.replaceAll('/', '-')),
      status: status,
      forms: forms.map((e) => e.toDomainModel()).toList(),
      filesCount: filesCount,
      commentsCount: commentsCount,
      milestone: milestone.toDomainModel(),
      project: project.toDomainModel(),
    );
  }
}

extension ProjectRMtoDM on ProjectRM {
  Project toDomainModel() {
    return Project(
      id: id,
      name: name,
      description: description,
    );
  }
}

extension FormRMtoDM on FormRM {
  FormDM toDomainModel() {
    return FormDM(
      id: id,
      name: name,
    );
  }
}

extension MileStoneRMtoDM on MileStoneRM {
  MileStone toDomainModel() {
    final Color? colorDM;
    if (color != null) {
      colorDM = Color(int.parse(color!, radix: 16));
    } else {
      colorDM = null;
    }

    return MileStone(
      title: title,
      order: order,
      color: colorDM,
    );
  }
}

extension FoldersRMtoDM on FoldersRM {
  Folders toDomainModel() {
    return Folders(
      active: active.map((e) => e.toDomainModel()).toList(),
      inactive: inactive.map((e) => e.toDomainModel()).toList(),
    );
  }
}

extension FileV2RMtoDM on FileV2RM {
  FileV2DM toDomainModel() {
    final typeIconDM = typeIcon == 'file'
        ? FileV2Type.file
        : typeIcon == 'folder'
            ? FileV2Type.folder
            : typeIcon == 'link'
                ? FileV2Type.link
                : throw Exception('Invalid typeIcon');
    return FileV2DM(
      id: id,
      name: name,
      fileSize: fileSize,
      typeIcon: typeIconDM,
      linkName: linkName,
      link: link,
      status: status,
      assets: asserts.map((e) => e.toDomainModel()).toList(),
    );
  }
}

extension AssetRMtoDM on AssetRM {
  AssetDM toDomainModel() {
    return AssetDM(
      name: name,
      size: size,
    );
  }
}
