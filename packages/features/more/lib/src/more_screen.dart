import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more/src/more_cubit.dart';
import 'package:user_repository/user_repository.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MoreCubit>(
      create: (_) => MoreCubit(
        userRepository: widget.userRepository,
      ),
      child: const MoreView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MoreView extends StatelessWidget {
  const MoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<MoreCubit, MoreState>(
      builder: (context, state) {
        final selectedCompany =
            state.user?.companies.firstWhere((company) => company.isSelected);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: state.user == null
              ? CenteredCircularProgressIndicator()
              : ListView(
                children: [
                  VerticalGap.large(),
                  CompanyTile(
                    company: selectedCompany!.copyWith(isSelected: false),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                  VerticalGap.large(),
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                ],
              ),
        );
      },
    );
  }
}
