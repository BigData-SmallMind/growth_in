import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';



class Files extends StatelessWidget {
  const Files({
    super.key,
    required this.files,
    this.onFileTapped,
  });

  final List<FileDM>? files;
  final ValueSetter<FileDM>? onFileTapped;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    return SizedBox(
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) =>  HorizontalGap.medium(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final file = files![index];
          return InkWell(
            onTap: onFileTapped != null ? () => onFileTapped!(file) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text(file.extension, maxLines: 1)),
                ),
                SizedBox(
                  width: 60,
                  child: Center(
                    child: Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: files!.length,
      ),
    );
  }
}
