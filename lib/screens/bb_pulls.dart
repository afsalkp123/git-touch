import 'package:flutter/material.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/bitbucket.dart';
import 'package:git_touch/scaffolds/list_stateful.dart';
import 'package:git_touch/widgets/app_bar_title.dart';
import 'package:git_touch/widgets/issue_item.dart';
import 'package:provider/provider.dart';

class BbPullsScreen extends StatelessWidget {
  final String owner;
  final String name;
  final String ref;
  BbPullsScreen(this.owner, this.name, this.ref);

  Future<ListPayload<BbPulls, String>> _query(BuildContext context,
      [String nextUrl]) async {
    final auth = Provider.of<AuthModel>(context);
    final res = await auth
        .fetchBbWithPage(nextUrl ?? '/repositories/$owner/$name/pullrequests');
    return ListPayload(
      cursor: res.cursor,
      hasMore: res.hasMore,
      items: <BbPulls>[
        for (var v in res.data) BbPulls.fromJson(v),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context);
    return ListStatefulScaffold<BbPulls, String>(
      title: AppBarTitle('Pull requests'),
      onRefresh: () => _query(context),
      onLoadMore: (page) => _query(context, page),
      itemBuilder: (v) {
        int pullNumber =
            int.parse(v.pullRequestLink.replaceFirst(RegExp(r'.*\/'), ''));
        return IssueItem(
          avatarUrl: v.author.avatarUrl,
          author: v.author.displayName,
          title: v.title,
          number: pullNumber,
          commentCount: 0,
          updatedAt: v.createdOn,
          url: '${auth.activeAccount.domain}/$owner/$name/issues/$pullNumber',
        );
      },
    );
  }
}
