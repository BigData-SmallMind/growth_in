import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_settings/src/l10n/profile_settings_localizations.dart';
import 'package:profile_settings/src/profile_settings_cubit.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({
    super.key,
    required this.onProfileInfoTapped,
    required this.onChangePasswordTapped,
    required this.onChangeEmailTapped,
  });

  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangeEmailTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileSettingsCubit>(
      create: (_) => ProfileSettingsCubit(
        onProfileInfoTapped: onProfileInfoTapped,
        onChangePasswordTapped: onChangePasswordTapped,
        onChangeEmailTapped: onChangeEmailTapped,
      ),
      child: const ProfileSettingsView(),
    );
  }
}

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final cubit = context.read<ProfileSettingsCubit>();
        final l10n = ProfileSettingsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: ListView(
            children: [
              ListTile(
                title: Text(l10n.infoTileTitle, style: textTheme.titleMedium),
                onTap: cubit.onProfileInfoTapped,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: theme.screenMargin),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  l10n.changePasswordTileTitle,
                  style: textTheme.titleMedium,
                ),
                onTap: cubit.onChangePasswordTapped,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: theme.screenMargin),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  l10n.changeEmailTileTitle,
                  style: textTheme.titleMedium,
                ),
                onTap: cubit.onChangeEmailTapped,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: theme.screenMargin),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  l10n.notificationsTileTitle,
                  style: textTheme.titleMedium,
                ),
                onTap: () {},
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: theme.screenMargin),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
