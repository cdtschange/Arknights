import 'package:arknights/operator/operator_bloc/operator_bloc.dart';
import 'package:arknights/operator/operator_filter_bloc/operator_filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';

class OperatorFilterDrawer extends StatelessWidget {
  OperatorFilterDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: new AppBar(
          title: Text("筛选"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Map<String, List<String>> data = Map.from(Operator.tagGroup());
              data.forEach((key, value) => data[key]?.clear());
              BlocProvider.of<OperatorFilterBloc>(context)
                  .add(OperatorFilterChangedEvent(tags: data));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: _listView(context),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    final groups = Operator.tagGroup().keys.toList();

    return BlocBuilder<OperatorFilterBloc, OperatorFilterState>(
      builder: (context, state) {
        if (state is OperatorFilterLoadSuccess) {
          List<Widget> result = [];
          for (var group in groups) {
            result.add(_groupHeader(context, group));
            result.add(_groupContent(context, group, state.tags));
            result.add(SizedBox(height: 5));
          }
          return ListView(padding: EdgeInsets.all(10), children: result);
        }
        return Container();
      },
    );
  }

  Widget _groupHeader(BuildContext context, String title) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Container(
              color: Theme.of(context).secondaryHeaderColor,
              height: 14,
              width: 5,
            ),
            SizedBox(width: 5),
            Text(title, style: TextStyle(fontSize: 12))
          ],
        ),
        Divider()
      ],
    );
  }

  Widget _groupContent(BuildContext context, String group,
      Map<String, List<String>> selectedTags) {
    final tags = Operator.tagGroup()[group] ?? [];
    List<Widget> list = tags
        .map(
          (e) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(50, 30),
              padding: EdgeInsets.all(5),
              primary: selectedTags[group]?.contains(e) == true
                  ? Theme.of(context).primaryColorDark
                  : Colors.white,
              onPrimary: selectedTags[group]?.contains(e) == true
                  ? Colors.white
                  : Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              Map<String, List<String>> data = Map.from(selectedTags);
              if (!data.containsKey(group)) {
                data[group] = [];
              }
              if (data[group]!.contains(e)) {
                data[group]!.remove(e);
              } else {
                data[group]!.add(e);
              }
              BlocProvider.of<OperatorBloc>(context)
                  .add(OperatorGroupFoldResetEvent());
              BlocProvider.of<OperatorFilterBloc>(context)
                  .add(OperatorFilterChangedEvent(tags: data));
            },
            child: Text(e, style: TextStyle(fontSize: 12)),
          ),
        )
        .toList();
    return Wrap(
      spacing: 5,
      children: list,
    );
  }
}
