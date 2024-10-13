import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/bloc/theme_bloc/theme_bloc.dart';
import 'package:petapp/bloc/theme_bloc/theme_events.dart';
import 'package:petapp/static_data/data.dart';

import '../../bloc/theme_bloc/theme_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(),
            ProfileAvatar(),
            ProfileName(),
            ThemeToggleSwitch(),
            ProfileOptions(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Profile",
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 40,
    );
  }
}

class ProfileName extends StatelessWidget {
  const ProfileName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Mark");
  }
}

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SwitchListTile(
          title: const Text('Toggle Theme'),
          value: state.themeMode == ThemeMode.dark,
          onChanged: (bool value) {
            context.read<ThemeBloc>().add(ToggleThemeEvent(value));
          },
        );
      },
    );
  }
}

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), 
        itemBuilder: (context, index) {
          return ProfileOptionTile(
            icon: listOfIcons[index],
            label: listOfIconLabels[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: listOfIconLabels.length,
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final Icon icon;
  final String label;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}
