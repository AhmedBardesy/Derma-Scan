import 'package:flutter/material.dart';
import 'package:test_cam_1/reminder/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_cam_1/reminder/new_entry.dart';
import 'package:test_cam_1/reminder/new_entry_bloc.dart';
import 'package:test_cam_1/reminder/reminder_screen.dart';

class bridgee extends StatefulWidget {
  const bridgee({super.key});

  @override
  State<bridgee> createState() => _bridgeeState();
}

class _bridgeeState extends State<bridgee> {
  @override
  Widget build(BuildContext context) => const SafeArea(
        child: Scaffold(
          body: reminder_screen(),
        ),
      );
}
