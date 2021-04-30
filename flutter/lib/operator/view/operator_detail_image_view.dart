import 'package:arknights/model/image_resource.dart';
import 'package:arknights/operator/operator.dart';
import 'package:arknights/view/common/view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:operator_repository/operator_repository.dart';

import 'view.dart';

class OperatorDetailImageView extends StatelessWidget {
  final OperatorData operatorData;
  final Operator oper;
  final OperatorImage? operatorImage;
  final List<Skill> skills;

  const OperatorDetailImageView(
      {Key? key,
      required this.operatorData,
      required this.oper,
      this.operatorImage,
      required this.skills})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      backgroundImageView(),
      _badgeView(),
      _operImageView(),
      _operImageLeftButton(context),
      _operImageRightButton(context),
      _operLeftBottomView(),
      _operRightBottomView(context),
    ]);
  }

  Widget backgroundImageView() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Image(
          image: AssetImage(ImageResource.iconOperationImageBg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _badgeView() {
    return Positioned(
      top: 5,
      left: 5,
      child: Container(
        child: oper.teamImage,
        width: 120,
      ),
    );
  }

  Widget _operImageView() {
    return AspectRatio(
      aspectRatio: 1,
      child: operatorImage?.imageUrls.isNotEmpty == true
          ? ExtendedImage.network(
              operatorImage!.imageUrls[operatorData.skin],
              alignment: Alignment.center,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }

  Widget _operImageLeftButton(BuildContext context) {
    return operatorImage?.imageUrls.isNotEmpty == true && operatorData.skin > 0
        ? Positioned(
            left: 5,
            width: 50,
            height: 130,
            child: IconButton(
              padding: EdgeInsets.only(bottom: 80),
              color: Colors.black38,
              alignment: Alignment.centerLeft,
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(100),
                ),
                child: Icon(Icons.arrow_back_ios_outlined),
              ),
              onPressed: () {
                final skin = operatorData.skin > 0 ? operatorData.skin - 1 : 0;
                BlocProvider.of<OperatorDataBloc>(context).add(
                    OperatorDataUpdateEvent(
                        data: operatorData.copyWith(skin: skin)));
              },
            ),
          )
        : Container();
  }

  Widget _operImageRightButton(BuildContext context) {
    return operatorImage?.imageUrls.isNotEmpty == true &&
            operatorData.skin < operatorImage!.imageUrls.length - 1
        ? Positioned(
            right: 5,
            width: 50,
            height: 130,
            child: IconButton(
              padding: EdgeInsets.only(bottom: 80),
              color: Colors.black38,
              alignment: Alignment.centerLeft,
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(100),
                ),
                child: Icon(Icons.arrow_forward_ios_outlined),
              ),
              onPressed: () {
                final skin =
                    operatorData.skin < operatorImage!.imageUrls.length - 1
                        ? operatorData.skin + 1
                        : operatorImage!.imageUrls.length - 1;
                BlocProvider.of<OperatorDataBloc>(context).add(
                    OperatorDataUpdateEvent(
                        data: operatorData.copyWith(skin: skin)));
              },
            ),
          )
        : Container();
  }

  Widget _operLeftBottomView() {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rarityView(),
          _appellationView(),
          _nameView(),
          Row(
            children: [
              _professionImageView(),
              SizedBox(width: 2),
              Container(
                height: 60,
                child: Column(
                  children: [
                    _positionNameView(),
                    SizedBox(height: 2),
                    Expanded(
                      child: _tagsView(),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _rarityView() {
    return Container(
      child: oper.rarityWhiteImage,
      height: 30,
    );
  }

  Widget _appellationView() {
    return Text(
      oper.appellation,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Text(
      oper.name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontFamily: "SourceHanSerifCN",
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }

  Widget _professionImageView() {
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          image: DecorationImage(
            image: oper.professionAssetImage,
          ),
        ),
      ),
    );
  }

  Widget _positionNameView() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(178),
        border: Border.all(color: Colors.white.withAlpha(178), width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        oper.positionName,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _tagsView() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(178),
        border: Border.all(color: Colors.white.withAlpha(178), width: 1),
      ),
      alignment: Alignment.center,
      child: oper.tagList.isEmpty
          ? Container()
          : Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              children: oper.tagList
                  .map((e) => Text(e,
                      style: TextStyle(color: Colors.white, fontSize: 12)))
                  .toList(),
            ),
    );
  }

  Widget _operRightBottomView(BuildContext context) {
    return Positioned(
      right: 15,
      bottom: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _eliteView(context),
          _levelView(context),
          SizedBox(height: 10),
          _rankView(context),
          _skillView(context),
        ],
      ),
    );
  }

  Widget _eliteView(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<OperatorPopupBloc>(context)
          .add(OperatorElitePopupEvent(operatorData: operatorData)),
      child: Container(
        child: operatorData.eliteImage,
        width: 60,
      ),
    );
  }

  Widget _levelView(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<OperatorPopupBloc>(context)
          .add(OperatorLevelPopupEvent(operatorData: operatorData)),
      child: Container(
        width: 60,
        height: 60,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              width: 2,
              color: Colors.yellow,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 4,
                child: Text(
                  "LV",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )),
            Positioned(
              bottom: 6,
              child: Text(
                operatorData.level.toString(),
                style: GoogleFonts.rubik(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rankView(BuildContext context) {
    return InkWell(
      onTap: () => BlocProvider.of<OperatorPopupBloc>(context)
          .add(OperatorRankPopupEvent(operatorData: operatorData)),
      child: Row(
        children: [
          Text(
            "RANK",
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Text(
            operatorData.rankLevel.toString(),
            style: GoogleFonts.rubik(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget _skillView(BuildContext context) {
    final operSkills =
        oper.skills.map((e) => skills.firstWhere((s) => s.id == e)).toList();
    return InkWell(
      onTap: () => BlocProvider.of<OperatorPopupBloc>(context).add(
          OperatorSkillPopupEvent(
              operatorData: operatorData, oper: oper, skills: operSkills)),
      child: OperatorSkillView(
        operatorData: operatorData,
        oper: oper,
        skills: skills,
        width: 30,
      ),
    );
  }
}
