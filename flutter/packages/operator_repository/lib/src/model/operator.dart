import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Operator extends Equatable {
  const Operator({
    required this.name,
    required this.description,
    required this.nationId,
    required this.groupId,
    required this.teamId,
    required this.displayNumber,
    required this.appellation,
    required this.position,
    required this.tagList,
    required this.itemUsage,
    required this.itemDesc,
    required this.maxPotentialLevel,
    required this.rarity,
    required this.isSpChar,
    required this.profession,
    required this.skills,
  });

  final String name;
  final String description;
  final String nationId;
  final String groupId;
  final String teamId;
  final String displayNumber;
  final String appellation;
  final String position;
  final List<String> tagList;
  final String itemUsage;
  final String itemDesc;
  final int maxPotentialLevel;
  final int rarity;
  final bool isSpChar;
  final String profession;
  final List<String> skills;

  @override
  List<Object?> get props => [
        name,
        description,
        nationId,
        groupId,
        teamId,
        displayNumber,
        appellation,
        position,
        tagList,
        itemUsage,
        itemDesc,
        maxPotentialLevel,
        rarity,
        isSpChar,
        skills
      ];

  static final Map<String, int> groupNames = {
    "六星": 5,
    "五星": 4,
    "四星": 3,
    "三星": 2,
    "二星": 1,
    "一星": 0
  };

  String get professionName {
    switch (profession) {
      case "MEDIC":
        return "医疗";
      case "TANK":
        return "重装";
      case "WARRIOR":
        return "近卫";
      case "SNIPER":
        return "狙击";
      case "CASTER":
        return "术师";
      case "PIONEER":
        return "先锋";
      case "SUPPORT":
        return "辅助";
      case "SPECIAL":
        return "特种";
      default:
        return "";
    }
  }

  String get positionName {
    switch (position) {
      case "RANGED":
        return "远程位";
      case "MELEE":
        return "近战位";
      default:
        return "";
    }
  }

  bool tagCondition(String tag) {
    switch (tag) {
      case "新手":
        return rarity == 1;
      case "资深干员":
        return rarity == 4;
      case "高级资深干员":
        return rarity == 5;
      case "远程位":
      case "近战位":
        return positionName == tag;
      case "先锋":
      case "狙击":
      case "医疗":
      case "术师":
      case "近卫":
      case "重装":
      case "辅助":
      case "特种":
        return professionName == tag;
      default:
        return tagList.contains(tag);
    }
  }

  static Map<String, List<String>> tagGroup() {
    return {
      "资质": ["新手", "资深干员", "高级资深干员"],
      "位置": ["远程位", "近战位"],
      "职业": ["先锋", "狙击", "医疗", "术师", "近卫", "重装", "辅助", "特种"],
      "标签": [
        "治疗",
        "支援",
        "输出",
        "群攻",
        "减速",
        "生存",
        "防护",
        "削弱",
        "位移",
        "爆发",
        "控场",
        "召唤",
        "快速复活",
        "费用回复",
        "支援机械"
      ]
    };
  }

  static List<String> get gotchaNames => [
        "Lancet-2",
        "Castle-3",
        "THRM-EX",
        "夜刀",
        "黑角",
        "巡林者",
        "杜林",
        "12F",
        "安德切尔",
        "芬",
        "香草",
        "翎羽",
        "玫兰莎",
        "米格鲁",
        "克洛丝",
        "炎熔",
        "芙蓉",
        "安塞尔",
        "史都华德",
        "梓兰",
        "空爆",
        "月见夜",
        "泡普卡",
        "斑点",
        "艾丝黛尔",
        "清流",
        "夜烟",
        "远山",
        "杰西卡",
        "流星",
        "白雪",
        "清道夫",
        "红豆",
        "杜宾",
        "缠丸",
        "霜叶",
        "慕斯",
        "砾",
        "暗索",
        "末药",
        "调香师",
        "角峰",
        "蛇屠箱",
        "古米",
        "地灵",
        "阿消",
        "猎蜂",
        "格雷伊",
        "苏苏洛",
        "桃金娘",
        "红云",
        "梅",
        "因陀罗",
        "火神",
        "白面鸮",
        "凛冬",
        "德克萨斯",
        "幽灵鲨",
        "蓝毒",
        "白金",
        "陨星",
        "梅尔",
        "赫默",
        "华法琳",
        "临光",
        "红",
        "雷蛇",
        "可颂",
        "普罗旺斯",
        "守林人",
        "崖心",
        "初雪",
        "真理",
        "狮蝎",
        "食铁兽",
        "夜魔",
        "诗怀雅",
        "格劳克斯",
        "星极",
        "送葬人",
        "槐琥",
        "能天使",
        "推进之王",
        "伊芙利特",
        "闪灵",
        "夜莺",
        "星熊",
        "塞雷娅",
        "银灰",
        "斯卡蒂",
        "陈",
        "黑",
        "赫拉格",
        "麦哲伦",
        "莫斯提马",
      ];

  static Map<String, List<Operator>> selectedTagGroup(
      Map<String, List<String>> selectedTags, List<Operator> operators) {
    List<String> tags = [];
    selectedTags.values.forEach((e) => tags.addAll(e));
    List<List<String>> allGroups = _getAllSubsets(tags);
    Map<String, List<Operator>> result = {};
    final gotchaOperators =
        operators.where((e) => gotchaNames.contains(e.name)).toList();
    allGroups.forEach((e) {
      if (e.isEmpty || e.length > 3) return;
      final key = e.join(" ");
      List<Operator> value = gotchaOperators
          .where((o) => e.where((t) => o.tagCondition(t)).length == e.length)
          .toList();
      if (value.isNotEmpty) {
        result[key] = value;
      }
    });
    return result;
  }

  static int groupScore(List<Operator> group) {
    return group.map((e) {
      if (e.rarity > 3)
        return e.rarity * 10;
      else if (e.rarity == 0) {
        return 5;
      } else if (e.rarity == 3) {
        return 5;
      } else if (e.rarity == 2) {
        return -200;
      } else if (e.rarity == 1) {
        return -300;
      } else {
        return 0;
      }
    }).reduce((a, b) => a + b);
  }

  static List<List<T>> _getAllSubsets<T>(List<T> l) =>
      l.fold<List<List<T>>>([[]], (subLists, element) {
        return subLists
            .map((subList) => [
                  subList,
                  subList + [element]
                ])
            .expand((element) => element)
            .toList();
      });

  String get teamName {
    String tName = "";
    if (teamId.isNotEmpty) {
      tName = teamId;
    } else if (groupId.isNotEmpty && groupId != "elite") {
      tName = groupId;
    } else if (nationId.isNotEmpty) {
      tName = nationId;
    }
    return tName;
  }

  Image get image => Image(
      image: AssetImage("assets/images/head/头像_$name.png",
          package: "operator_repository"),
      fit: BoxFit.cover);

  Image get professionImage => Image(image: professionAssetImage);

  AssetImage get professionAssetImage => AssetImage(
      "assets/images/profession/icon_profession_${profession.toLowerCase()}_2.png",
      package: "operator_repository");

  Image get rarityYellowImage => Image(
      image: AssetImage("assets/images/rarity/icon_rarity_yellow_$rarity.png",
          package: "operator_repository"));

  Image get rarityWhiteImage => Image(
      image: AssetImage("assets/images/rarity/icon_rarity_white_$rarity.png",
          package: "operator_repository"));

  Widget get teamImage => ExtendedImage.asset(
        "assets/images/team/icon_team_$teamName.png",
        package: "operator_repository",
        color: teamName == "rhodes" ? null : Colors.grey.withAlpha(120),
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.failed ||
              state.extendedImageLoadState == LoadState.loading) {
            return Container();
          }
        },
      );

  @override
  String toString() {
    return name;
  }
}
