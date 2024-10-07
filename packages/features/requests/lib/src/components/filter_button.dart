import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests/src/components/filter_bottom_sheet.dart';
import 'package:requests/src/requests_cubit.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestsCubit>();
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.filter_alt_outlined),
          onPressed: () => showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (context) => FilterBottomSheet(
              setFilter: (filterBy) => cubit.setFilterBy(filterBy),
              getFilter: cubit.getFilterBy,
              projects: state.projects,
              onApply: cubit.onApplyFilter,
            ),
          ),
        );
      },
    );
  }
}
