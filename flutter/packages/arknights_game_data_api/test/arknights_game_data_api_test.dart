import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:arknights_game_data_api/arknights_game_data_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('ArknightsGameDataApiClient', () {
    late http.Client httpClient;
    late ArknightsGameDataApiClient arknightsGameDataApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      arknightsGameDataApiClient =
          ArknightsGameDataApiClient(httpClient: httpClient);
    });

    group('itemTable', () {
      test('makes correct http request and get items', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"items":{"5001":{"itemId":"5001","name":"声望","description":"做得很好，就这样继续变强吧。只要坚持不懈，所有的心血都不会白费的。","rarity":4,"iconId":"EXP_PLAYER","overrideBkg":null,"stackIconId":null,"sortId":-10000,"usage":"战斗结束后获得的经验。足以见证博士的成长。","obtainApproach":"战斗获取","classifyType":"NONE","itemType":"EXP_PLAYER","stageDropList":[],"buildingProductList":[]},"SOCIAL_PT":{"itemId":"SOCIAL_PT","name":"信用","description":"信用维系着各个群体间的关系，也是社会稳定的象征，有时候甚至比金钱还有用哦，请好好珍惜。","rarity":1,"iconId":"SOCIAL_PT","overrideBkg":null,"stackIconId":null,"sortId":-10000,"usage":"友谊的见证，用于在商店中兑换物资。","obtainApproach":"好友助战、支援单位、宿舍氛围、线索交流","classifyType":"NONE","itemType":"SOCIAL_PT","stageDropList":[],"buildingProductList":[]}}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final items = await arknightsGameDataApiClient.itemTable();
        verify(
          () => httpClient.get(
            Uri.https('raw.githubusercontent.com',
                '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/item_table.json'),
          ),
        ).called(1);
        expect(items.length == 2, true);
      });

      test('throws ItemsRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.itemTable(),
          throwsA(isA<ItemsRequestFailure>()),
        );
      });

      test('throws ItemsRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.itemTable(),
          throwsA(isA<ItemsRequestFailure>()),
        );
      });

      test('throws ItemsRequestFailure on invalid json response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.itemTable(),
          throwsA(isA<ItemsRequestFailure>()),
        );
      });
    });

    group('stageTable', () {
      test('makes correct http request and get stages', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"stages":{"main_00-01":{"stageType":"MAIN","difficulty":"NORMAL","performanceStageFlag":"NORMAL_STAGE","unlockCondition":[],"stageId":"main_00-01","levelId":"Obt/Main/level_main_00-01","zoneId":"main_0","code":"0-1","name":"坍塌","description":"三点方向出现了敌人的先锋部队，请部署近战干员进行拦截。","hardStagedId":"main_00-01#f#","dangerLevel":"LV.1","dangerPoint":-1.0,"loadingPicId":"loading1","canPractice":true,"canBattleReplay":true,"apCost":6,"apFailReturn":5,"etItemId":null,"etCost":-1,"etFailReturn":-1,"etButtonStyle":null,"apProtectTimes":1,"diamondOnceDrop":1,"practiceTicketCost":1,"dailyStageDifficulty":-1,"expGain":60,"goldGain":60,"loseExpGain":0,"loseGoldGain":0,"passFavor":5,"completeFavor":6,"slProgress":1,"displayMainItem":"","hilightMark":false,"bossMark":false,"isPredefined":false,"isHardPredefined":false,"isStoryOnly":false,"appearanceStyle":0,"stageDropInfo":{"firstPassRewards":null,"firstCompleteRewards":null,"passRewards":null,"completeRewards":null,"displayRewards":[{"type":"TKT_RECRUIT","id":"7001","dropType":1},{"type":"CARD_EXP","id":"2001","dropType":2},{"type":"DIAMOND","id":"4002","dropType":8}],"displayDetailRewards":[{"occPercent":0,"type":"TKT_RECRUIT","id":"7001","dropType":1},{"occPercent":0,"type":"CARD_EXP","id":"2001","dropType":2},{"occPercent":4,"type":"MATERIAL","id":"30011","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"30021","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"30031","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"30041","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"30051","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"30061","dropType":4},{"occPercent":4,"type":"MATERIAL","id":"3003","dropType":4},{"occPercent":0,"type":"CARD_EXP","id":"2001","dropType":4},{"occPercent":0,"type":"DIAMOND","id":"4002","dropType":8}]},"startButtonOverrideId":null,"isStagePatch":false,"mainStageId":"main_00-01"},"main_00-01#f#":{"stageType":"MAIN","difficulty":"FOUR_STAR","performanceStageFlag":"NORMAL_STAGE","unlockCondition":[{"stageId":"main_02-08","completeState":2},{"stageId":"main_00-01","completeState":3}],"stageId":"main_00-01#f#","levelId":"Obt/Main/level_main_00-01","zoneId":"main_0","code":"0-1","name":"坍塌","description":"<@lv.fs>附加条件：</>\\n部署费用不自然回复","hardStagedId":null,"dangerLevel":"-","dangerPoint":-1.0,"loadingPicId":"loading1","canPractice":true,"canBattleReplay":false,"apCost":6,"apFailReturn":3,"etItemId":null,"etCost":-1,"etFailReturn":-1,"etButtonStyle":null,"apProtectTimes":0,"diamondOnceDrop":1,"practiceTicketCost":3,"dailyStageDifficulty":-1,"expGain":60,"goldGain":60,"loseExpGain":0,"loseGoldGain":0,"passFavor":3,"completeFavor":6,"slProgress":0,"displayMainItem":"","hilightMark":false,"bossMark":false,"isPredefined":false,"isHardPredefined":false,"isStoryOnly":false,"appearanceStyle":0,"stageDropInfo":{"firstPassRewards":null,"firstCompleteRewards":null,"passRewards":null,"completeRewards":null,"displayRewards":[{"type":"DIAMOND","id":"4002","dropType":8}],"displayDetailRewards":[{"occPercent":0,"type":"DIAMOND","id":"4002","dropType":8}]},"startButtonOverrideId":null,"isStagePatch":false,"mainStageId":"main_00-01#f#"},"tr_01":{"stageType":"MAIN","difficulty":"NORMAL","performanceStageFlag":"NORMAL_STAGE","unlockCondition":[{"stageId":"main_00-01","completeState":2}],"stageId":"tr_01","levelId":"Obt/Training/level_training_1","zoneId":"main_0","code":"TR-1","name":"战地医疗 ","description":"学习医疗干员的使用方法。","hardStagedId":null,"dangerLevel":"-","dangerPoint":-1.0,"loadingPicId":"loadingS","canPractice":false,"canBattleReplay":false,"apCost":0,"apFailReturn":0,"etItemId":null,"etCost":-1,"etFailReturn":-1,"etButtonStyle":null,"apProtectTimes":0,"diamondOnceDrop":1,"practiceTicketCost":-1,"dailyStageDifficulty":-1,"expGain":0,"goldGain":0,"loseExpGain":0,"loseGoldGain":0,"passFavor":0,"completeFavor":0,"slProgress":2,"displayMainItem":"","hilightMark":false,"bossMark":false,"isPredefined":true,"isHardPredefined":false,"isStoryOnly":false,"appearanceStyle":3,"stageDropInfo":{"firstPassRewards":null,"firstCompleteRewards":null,"passRewards":null,"completeRewards":null,"displayRewards":[{"type":"CHAR","id":"char_120_hibisc","dropType":1},{"type":"DIAMOND","id":"4002","dropType":8}],"displayDetailRewards":[{"occPercent":0,"type":"CHAR","id":"char_120_hibisc","dropType":1},{"occPercent":0,"type":"DIAMOND","id":"4002","dropType":8}]},"startButtonOverrideId":null,"isStagePatch":false,"mainStageId":"tr_01"}}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final stages = await arknightsGameDataApiClient.stageTable();
        verify(
          () => httpClient.get(
            Uri.https('raw.githubusercontent.com',
                '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/stage_table.json'),
          ),
        ).called(1);
        expect(stages.length == 3, true);
      });

      test('throws StagesRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.stageTable(),
          throwsA(isA<StagesRequestFailure>()),
        );
      });

      test('throws StagesRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.stageTable(),
          throwsA(isA<StagesRequestFailure>()),
        );
      });

      test('throws StagesRequestFailure on invalid json response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.stageTable(),
          throwsA(isA<StagesRequestFailure>()),
        );
      });
    });

    group('zoneTable', () {
      test('makes correct http request and get zones', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"zones":{"main_0":{"zoneID":"main_0","zoneIndex":0,"type":"MAINLINE","zoneNameFirst":"序章","zoneNameSecond":"黑暗时代·上","zoneNameTitleCurrent":"00","zoneNameTitleUnCurrent":"00","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE00","lockedText":"","canPreview":false},"main_1":{"zoneID":"main_1","zoneIndex":1,"type":"MAINLINE","zoneNameFirst":"第一章","zoneNameSecond":"黑暗时代·下","zoneNameTitleCurrent":"01","zoneNameTitleUnCurrent":"01","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE01","lockedText":"完成上一章以解锁","canPreview":true},"main_2":{"zoneID":"main_2","zoneIndex":2,"type":"MAINLINE","zoneNameFirst":"第二章","zoneNameSecond":"异卵同生","zoneNameTitleCurrent":"02","zoneNameTitleUnCurrent":"02","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE02","lockedText":"完成上一章以解锁","canPreview":true},"main_3":{"zoneID":"main_3","zoneIndex":3,"type":"MAINLINE","zoneNameFirst":"第三章","zoneNameSecond":"二次呼吸","zoneNameTitleCurrent":"03","zoneNameTitleUnCurrent":"03","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE03","lockedText":"完成上一章以解锁","canPreview":true},"main_4":{"zoneID":"main_4","zoneIndex":4,"type":"MAINLINE","zoneNameFirst":"第四章","zoneNameSecond":"急性衰竭","zoneNameTitleCurrent":"04","zoneNameTitleUnCurrent":"04","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE04","lockedText":"完成上一章以解锁","canPreview":true},"main_5":{"zoneID":"main_5","zoneIndex":5,"type":"MAINLINE","zoneNameFirst":"第五章","zoneNameSecond":"靶向药物","zoneNameTitleCurrent":"05","zoneNameTitleUnCurrent":"05","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE05","lockedText":"完成上一章以解锁","canPreview":true},"main_6":{"zoneID":"main_6","zoneIndex":6,"type":"MAINLINE","zoneNameFirst":"第六章","zoneNameSecond":"局部坏死","zoneNameTitleCurrent":"06","zoneNameTitleUnCurrent":"06","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE06","lockedText":"完成上一章以解锁","canPreview":true},"main_7":{"zoneID":"main_7","zoneIndex":7,"type":"MAINLINE","zoneNameFirst":"第七章","zoneNameSecond":"苦难摇篮","zoneNameTitleCurrent":"07","zoneNameTitleUnCurrent":"07","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE07","lockedText":"完成上一章以解锁","canPreview":true},"main_8":{"zoneID":"main_8","zoneIndex":8,"type":"MAINLINE","zoneNameFirst":"第八章","zoneNameSecond":"怒号光明","zoneNameTitleCurrent":"08","zoneNameTitleUnCurrent":"08","zoneNameTitleEx":"EPISODE","zoneNameThird":"EPISODE08","lockedText":"完成上一章以解锁","canPreview":true},"weekly_1":{"zoneID":"weekly_1","zoneIndex":1,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"固若金汤","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_2":{"zoneID":"weekly_2","zoneIndex":2,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"摧枯拉朽","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_3":{"zoneID":"weekly_3","zoneIndex":3,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"势不可挡","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_4":{"zoneID":"weekly_4","zoneIndex":4,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"身先士卒","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_5":{"zoneID":"weekly_5","zoneIndex":2,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"粉碎防御","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_6":{"zoneID":"weekly_6","zoneIndex":3,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"空中威胁","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_7":{"zoneID":"weekly_7","zoneIndex":1,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"战术演习","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_8":{"zoneID":"weekly_8","zoneIndex":4,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"资源保障","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false},"weekly_9":{"zoneID":"weekly_9","zoneIndex":5,"type":"WEEKLY","zoneNameFirst":null,"zoneNameSecond":"货物运送","zoneNameTitleCurrent":null,"zoneNameTitleUnCurrent":null,"zoneNameTitleEx":null,"zoneNameThird":null,"lockedText":"当前不可进入","canPreview":false}}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final zones = await arknightsGameDataApiClient.zoneTable();
        verify(
          () => httpClient.get(
            Uri.https('raw.githubusercontent.com',
                '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/zone_table.json'),
          ),
        ).called(1);
        expect(zones.length > 0, true);
      });

      test('throws ZonesRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.zoneTable(),
          throwsA(isA<ZonesRequestFailure>()),
        );
      });

      test('throws ZonesRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.zoneTable(),
          throwsA(isA<ZonesRequestFailure>()),
        );
      });

      test('throws ZonesRequestFailure on invalid json response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.zoneTable(),
          throwsA(isA<ZonesRequestFailure>()),
        );
      });
    });

    group('characterTable', () {
      test('makes correct http request and get characters', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"char_285_medic2":{"name":"Lancet-2","description":"恢复友方单位生命，且不受<@ba.kw>部署数量</>限制，但再部署时间极长","canUseGeneralPotentialItem":false,"potentialItemId":"p_char_285_medic2","nationId":"rhodes","groupId":null,"teamId":null,"displayNumber":"RCX2","tokenKey":null,"appellation":"Lancet-2","position":"RANGED","tagList":["治疗"],"itemUsage":"罗德岛医疗机器人Lancet-2，被工程师可露希尔派遣来执行战地医疗任务。","itemDesc":"她知道自己是一台机器人。","itemObtainApproach":"招募寻访","isNotObtainable":false,"isSpChar":false,"maxPotentialLevel":5,"rarity":0,"profession":"MEDIC","trait":null,"phases":[{"characterPrefabKey":"char_285_medic2","rangeId":"3-1","maxLevel":30,"attributesKeyFrames":[{"level":1,"data":{"maxHp":261,"atk":42,"def":16,"magicResistance":0.0,"cost":3,"blockCnt":1,"moveSpeed":1.0,"attackSpeed":100.0,"baseAttackTime":2.85,"respawnTime":200,"hpRecoveryPerSec":0.0,"spRecoveryPerSec":1.0,"maxDeployCount":1,"maxDeckStackCnt":0,"tauntLevel":0,"massLevel":0,"baseForceLevel":0,"stunImmune":false,"silenceImmune":false,"sleepImmune":false}},{"level":30,"data":{"maxHp":435,"atk":70,"def":27,"magicResistance":0.0,"cost":3,"blockCnt":1,"moveSpeed":1.0,"attackSpeed":100.0,"baseAttackTime":2.85,"respawnTime":200,"hpRecoveryPerSec":0.0,"spRecoveryPerSec":1.0,"maxDeployCount":1,"maxDeckStackCnt":0,"tauntLevel":0,"massLevel":0,"baseForceLevel":0,"stunImmune":false,"silenceImmune":false,"sleepImmune":false}}],"evolveCost":null}],"skills":[],"talents":[{"candidates":[{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":0,"prefabKey":"1","name":"救援喷雾·I","description":"部署后立即恢复全场友方单位200点生命","rangeId":null,"blackboard":[{"key":"value","value":200.0}]},{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":1,"prefabKey":"1","name":"救援喷雾·II","description":"部署后立即恢复全场友方单位260点生命","rangeId":null,"blackboard":[{"key":"value","value":260.0}]},{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":2,"prefabKey":"1","name":"救援喷雾·III","description":"部署后立即恢复全场友方单位320点生命","rangeId":null,"blackboard":[{"key":"value","value":320.0}]},{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":3,"prefabKey":"1","name":"救援喷雾·IV","description":"部署后立即恢复全场友方单位380点生命","rangeId":null,"blackboard":[{"key":"value","value":380.0}]},{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":4,"prefabKey":"1","name":"救援喷雾·V","description":"部署后立即恢复全场友方单位440点生命","rangeId":null,"blackboard":[{"key":"value","value":440.0}]},{"unlockCondition":{"phase":0,"level":1},"requiredPotentialRank":5,"prefabKey":"1","name":"救援喷雾·VI","description":"部署后立即恢复全场友方单位500点生命","rangeId":null,"blackboard":[{"key":"value","value":500.0}]}]}],"potentialRanks":[{"type":1,"description":"天赋效果加强","buff":null,"equivalentCost":null},{"type":1,"description":"天赋效果加强","buff":null,"equivalentCost":null},{"type":1,"description":"天赋效果加强","buff":null,"equivalentCost":null},{"type":1,"description":"天赋效果加强","buff":null,"equivalentCost":null},{"type":1,"description":"天赋效果加强","buff":null,"equivalentCost":null}],"favorKeyFrames":[{"level":0,"data":{"maxHp":0,"atk":0,"def":0,"magicResistance":0.0,"cost":0,"blockCnt":0,"moveSpeed":0.0,"attackSpeed":0.0,"baseAttackTime":0.0,"respawnTime":0,"hpRecoveryPerSec":0.0,"spRecoveryPerSec":0.0,"maxDeployCount":0,"maxDeckStackCnt":0,"tauntLevel":0,"massLevel":0,"baseForceLevel":0,"stunImmune":false,"silenceImmune":false,"sleepImmune":false}},{"level":50,"data":{"maxHp":100,"atk":40,"def":0,"magicResistance":0.0,"cost":0,"blockCnt":0,"moveSpeed":0.0,"attackSpeed":0.0,"baseAttackTime":0.0,"respawnTime":0,"hpRecoveryPerSec":0.0,"spRecoveryPerSec":0.0,"maxDeployCount":0,"maxDeckStackCnt":0,"tauntLevel":0,"massLevel":0,"baseForceLevel":0,"stunImmune":false,"silenceImmune":false,"sleepImmune":false}}],"allSkillLvlup":[]}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final characters = await arknightsGameDataApiClient.characterTable();
        verify(
          () => httpClient.get(
            Uri.https('raw.githubusercontent.com',
                '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/character_table.json'),
          ),
        ).called(1);
        expect(characters.length > 0, true);
      });

      test('throws CharactersRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.characterTable(),
          throwsA(isA<CharactersRequestFailure>()),
        );
      });

      test('throws CharactersRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.characterTable(),
          throwsA(isA<CharactersRequestFailure>()),
        );
      });

      test('throws CharactersRequestFailure on invalid json response',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.characterTable(),
          throwsA(isA<CharactersRequestFailure>()),
        );
      });
    });

    group('skillTable', () {
      test('makes correct http request and get skills', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
            '{"skcom_charge_cost[1]":{"skillId":"skcom_charge_cost[1]","iconId":null,"hidden":false,"levels":[{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":30,"initSp":0,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":29,"initSp":0,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":28,"initSp":0,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":27,"initSp":3,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":26,"initSp":3,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":25,"initSp":3,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]},{"name":"冲锋号令·α型","rangeId":null,"description":"立即获得<@ba.vup>{cost}</>点部署费用","skillType":2,"spData":{"spType":1,"levelUpCost":null,"maxChargeTime":1,"spCost":25,"initSp":6,"increment":1.0},"prefabId":"skcom_charge_cost","duration":0.0,"blackboard":[{"key":"cost","value":6.0}]}]}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final skills = await arknightsGameDataApiClient.skillTable();
        verify(
          () => httpClient.get(
            Uri.https('raw.githubusercontent.com',
                '/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/skill_table.json'),
          ),
        ).called(1);
        expect(skills.length > 0, true);
      });

      test('throws SkillsRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.skillTable(),
          throwsA(isA<SkillsRequestFailure>()),
        );
      });

      test('throws SkillsRequestFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.skillTable(),
          throwsA(isA<SkillsRequestFailure>()),
        );
      });

      test('throws SkillsRequestFailure on invalid json response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": {}}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await arknightsGameDataApiClient.skillTable(),
          throwsA(isA<SkillsRequestFailure>()),
        );
      });
    });
  });
}
