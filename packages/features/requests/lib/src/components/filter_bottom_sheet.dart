import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:requests/src/components/bottom_sheet_buttons.dart';
import 'package:requests/src/l10n/requests_localizations.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.setFilter,
    required this.getFilter,
    this.projects,
    this.meetingTypes,
    required this.onApply,
  });

  final ValueSetter<FilterBy> setFilter;
  final ValueGetter<FilterBy> getFilter;
  final VoidCallback onApply;
  final List<MeetingType>? meetingTypes;
  final List<Project>? projects;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterBy selectedFilter;

  void onFilterChanged(FilterBy filterBy) {
    selectedFilter = filterBy;
    widget.setFilter(filterBy);
    setState(() {});
  }

  void _onApply() {
    widget.onApply();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.getFilter();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = RequestsLocalizations.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: GrowthInTheme.of(context).screenMargin,
            ),
            children: [
              Text(l10n.statusFilterSectionTitle),
              ColumnBuilder(
                itemCount: RequestStatus.values.length,
                itemBuilder: (context, index) {
                  final status = RequestStatus.values[index];
                  onStatusTap() {
                    final updatedFilter = selectedFilter.requestStatus == status
                        ? FilterBy(
                            projects: selectedFilter.projects,
                            searchText: selectedFilter.searchText,
                            requestStatus: null,
                          )
                        : selectedFilter.copyWith(requestStatus: status);
                    onFilterChanged(updatedFilter);
                  }
                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      localizeRequestStatus(
                        status,
                        l10n,
                      ),
                    ),
                    onTap: onStatusTap,
                    selected: selectedFilter.requestStatus == status,
                    leading: Checkbox(
                      shape:
                          const ContinuousRectangleBorder(side: BorderSide(width: 1)),
                      value: selectedFilter.requestStatus == status,
                      onChanged: (_) {},
                    ),
                  );
                },
              ),
              if (widget.projects != null) ...[
                const Divider(),
                VerticalGap.medium(),
                Text(l10n.projectsFilterSectionTitle),
                ColumnBuilder(
                  itemCount: widget.projects!.length,
                  itemBuilder: (context, index) {
                    final project = widget.projects![index];
                    void onProjectTap() {
                      final List<Project> updatedSelectedProjects =
                          selectedFilter.projects?.contains(project) ?? false
                              ? selectedFilter.projects!
                                  .where((p) => p.id != project.id)
                                  .toList()
                              : [...selectedFilter.projects ?? [], project];
                      final updatedFilter = selectedFilter.copyWith(
                        projects: updatedSelectedProjects,
                      );
                      onFilterChanged(updatedFilter);
                    }
                    return ListTile(
                      title: Text(
                        project.name,
                      ),
                      onTap: onProjectTap,
                      selected:
                          selectedFilter.projects?.contains(project) ?? false,
                      leading: Checkbox(
                        shape: const ContinuousRectangleBorder(
                            side: BorderSide(width: 1)),
                        value:
                            selectedFilter.projects?.contains(project) ?? false,
                        onChanged: (_) => onProjectTap,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              BottomSheetButtons(
                onApply: _onApply,
                onCancel: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

String localizeRequestStatus(
  RequestStatus status,
  RequestsLocalizations l10n,
) {
  switch (status) {
    case RequestStatus.aboutToExpire:
      return l10n.aboutToExpireStatusText;
    case RequestStatus.inProgress:
      return l10n.inProgressStatusText;
    case RequestStatus.expired:
      return l10n.expiredStatusText;
    case RequestStatus.notStarted:
      return l10n.notStartedStatusText;
  }
}
