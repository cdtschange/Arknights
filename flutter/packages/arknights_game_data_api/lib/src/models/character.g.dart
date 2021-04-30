// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return Character(
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    canUseGeneralPotentialItem:
        json['canUseGeneralPotentialItem'] as bool? ?? false,
    potentialItemId: json['potentialItemId'] as String? ?? '',
    nationId: json['nationId'] as String? ?? '',
    groupId: json['groupId'] as String? ?? '',
    teamId: json['teamId'] as String? ?? '',
    displayNumber: json['displayNumber'] as String? ?? '',
    tokenKey: json['tokenKey'] as String? ?? '',
    appellation: json['appellation'] as String? ?? '',
    position: json['position'] as String? ?? '',
    tagList:
        (json['tagList'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    itemUsage: json['itemUsage'] as String? ?? '',
    itemDesc: json['itemDesc'] as String? ?? '',
    itemObtainApproach: json['itemObtainApproach'] as String? ?? '',
    isNotObtainable: json['isNotObtainable'] as bool? ?? false,
    isSpChar: json['isSpChar'] as bool? ?? false,
    maxPotentialLevel: json['maxPotentialLevel'] as int? ?? 0,
    rarity: json['rarity'] as int? ?? 0,
    profession: json['profession'] as String? ?? '',
    phases: (json['phases'] as List<dynamic>?)
            ?.map((e) => CharacterPhase.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    skills: (json['skills'] as List<dynamic>?)
            ?.map((e) => CharacterSkill.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    allSkillLvlup: (json['allSkillLvlup'] as List<dynamic>?)
            ?.map((e) =>
                CharacterSkillLevelupCost.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'canUseGeneralPotentialItem': instance.canUseGeneralPotentialItem,
      'potentialItemId': instance.potentialItemId,
      'nationId': instance.nationId,
      'groupId': instance.groupId,
      'teamId': instance.teamId,
      'displayNumber': instance.displayNumber,
      'tokenKey': instance.tokenKey,
      'appellation': instance.appellation,
      'position': instance.position,
      'tagList': instance.tagList,
      'itemUsage': instance.itemUsage,
      'itemDesc': instance.itemDesc,
      'itemObtainApproach': instance.itemObtainApproach,
      'isNotObtainable': instance.isNotObtainable,
      'isSpChar': instance.isSpChar,
      'maxPotentialLevel': instance.maxPotentialLevel,
      'rarity': instance.rarity,
      'profession': instance.profession,
      'phases': instance.phases,
      'skills': instance.skills,
      'allSkillLvlup': instance.allSkillLvlup,
    };
