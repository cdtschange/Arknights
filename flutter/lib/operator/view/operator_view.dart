import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:operator_repository/operator_repository.dart';

import 'view.dart';

class OperatorView extends StatelessWidget {
  final Operator oper;
  final OperatorData operatorData;
  final OperatorImage? operatorImage;
  final List<Skill> skills;
  final double width;
  final double height;
  final VoidCallback onTap;

  const OperatorView(
      {Key? key,
      required this.operatorData,
      required this.operatorImage,
      required this.oper,
      required this.skills,
      required this.width,
      required this.height,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            _nameHeadView(),
            Stack(
              children: [
                Container(
                    color: Colors.transparent,
                    width: width - 10,
                    height: height - 30),
                _imageHeadView(),
                OperatorRarityView(oper: oper),
                Positioned(
                  bottom: 2,
                  left: 3,
                  right: 3,
                  child: Container(
                    width: width,
                    height: 20,
                    color: Color(0xFF333333),
                  ),
                ),
                OperatorBottomBackgroudView(
                    oper: oper, width: width, height: height - width - 50),
                Positioned(
                  bottom: 8,
                  left: 2,
                  child: Container(
                    width: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OperatorEliteView(
                            operatorData: operatorData,
                            oper: oper,
                            width: width * 0.25),
                        OperatorLevelView(
                            operatorData: operatorData,
                            oper: oper,
                            width: width * 0.25)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  bottom: 10,
                  child: OperatorSkillView(
                      operatorData: operatorData,
                      oper: oper,
                      skills: skills,
                      width: width * 0.12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameHeadView() {
    return Container(
      height: 16,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                oper.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: "SourceHanSerifCN"),
              ),
            ),
          ),
          Positioned(
            left: 2,
            child: Container(
              child: oper.professionImage,
              height: 12,
              width: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _imageHeadView() {
    final headImage = (operatorImage?.headUrls.length ?? 0) > operatorData.skin
        ? operatorImage?.headUrls[operatorData.skin] ?? ""
        : "";
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 3, right: 3, bottom: 3),
        height: height - 30,
        child: operatorData.have
            ? ExtendedImage.network(
                headImage,
                fit: BoxFit.fitWidth,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return Icon(Icons.account_circle);
                  }
                },
              )
            : ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
                child: ExtendedImage.network(
                  headImage,
                  fit: BoxFit.fitWidth,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Icon(Icons.account_circle);
                    }
                  },
                ),
              ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
      ),
    ]);
  }
}
