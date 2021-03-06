import 'package:flutter/material.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/widgets/link.dart';
import 'package:provider/provider.dart';

class UserName extends StatelessWidget {
  final String login;

  UserName(this.login);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
    return Link(
      url: '/github/$login',
      child: Container(
        // padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(
          login,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.palette.primary,
          ),
        ),
      ),
    );
  }
}
