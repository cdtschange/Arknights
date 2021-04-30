import 'package:arknights/router/app_state.dart';
import 'package:arknights/router/ui_pages.dart';
import 'package:arknights/view/common/view.dart';
import 'package:flutter/material.dart';
import 'package:item_repository/item_repository.dart';
import 'package:provider/provider.dart';
import 'package:stage_repository/stage_repository.dart';

class StageHeaderView extends StatelessWidget {
  final Stage stage;
  final List<Stage> stages;

  const StageHeaderView({Key? key, required this.stage, required this.stages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return HeaderCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    stage.displayName,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Item.apImage,
                    Text(
                      stage.apCost.toString(),
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              stage.isFirst(stages)
                  ? Container()
                  : TextButton(
                      onPressed: () => appState.currentAction = PageAction(
                        state: PageState.replace,
                        page: Pages.StageDetail.stagePageConfig(
                            stageId: stage.previous(stages)!.stageId,
                            name: stage.previous(stages)!.displayName),
                      ),
                      child: Icon(Icons.arrow_back,
                          color: Theme.of(context).primaryColor),
                    ),
              stage.isLast(stages)
                  ? Container()
                  : TextButton(
                      onPressed: () => appState.currentAction = PageAction(
                        state: PageState.replace,
                        page: Pages.StageDetail.stagePageConfig(
                            stageId: stage.nextStage(stages)!.stageId,
                            name: stage.nextStage(stages)!.displayName),
                      ),
                      child: Icon(Icons.arrow_forward,
                          color: Theme.of(context).primaryColor),
                    )
            ],
          )
        ],
      ),
    );
  }
}
