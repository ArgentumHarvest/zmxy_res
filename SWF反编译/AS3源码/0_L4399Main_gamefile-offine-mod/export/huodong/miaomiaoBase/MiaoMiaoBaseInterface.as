package export.huodong.miaomiaoBase
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class MiaoMiaoBaseInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      protected var urlLoader:URLLoader;
      
      protected var gc:Config;
      
      protected var gameId:uint = 1;
      
      public function MiaoMiaoBaseInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      protected function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn.addEventListener("click",gClick);
      }
      
      protected function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      protected function gClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/jifen/yx-zmxy3");
      }
      
      protected function lqClick(e:MouseEvent) : void
      {
         var allGiftIDs:Array = [79,121,127,153,178,195,243,263,307,566,2590,2846,3394,4030,3798,4972,4976,5648,5872,5894,5896,5898,5900,6832,6720,7122,7124,7126,7130,7254,7532,7680,8918,8922,8924,8926,8928,9492,9612,9990,9992,11162,11160,11328,11150,11152,11156,11158,11670,12474,12822,12654,12656,12658,12660,13070,13254,12882,12880,13758,14320,14322,14324,14326,14566,14958,14960,13572,15050,15268,15696,15710,15712,15718,15720,16282,16804,17484,17486,17488,17490,17606,18062,19142,19144,19148,19150,18216,20102,20318,20320,20322,20324,20462,20614,20846,20970,20868,20870,20872,20874,20684,21060,21230,21454,21456,21458,21460,21446,21894,22004,22218,22220,22222,22224,22110,21954,21956,23338,23340,23342,23344,23484,23200,23202,23914,23968,23972,23974,23976,24214,24682,24970,25102,25104,25106,25108,25160,25070,24832,24836,25910,26310,26266,26268,26270,26272,26946,27762,27562,27564,27566,27568,28424,29112,28030,29126,29136,29138,29140,29296,29298,29300,29302,29304,29306,29560,29998,30678,30658,30660,30662,30664,30918,31164,31684,31542,31544,31546,31548,31876,31892,31910,31912,31914,31916,31970,32012,31976,31978,31980,31982,32054,31972,32046,32126,32048,32128,32050,32130,32052,32132,32134,32172,32290,32334,32324,32326,32328,32330,32360,32384,32388,32390,32407,32402,32403,32404,32405,32406,32427,32432,32433,32434,32435,32436,32437,32471,32472,32473,32474,32475,32476,32478,32506,32518,32519,32520,32521,32522,32523,32533,32611,32612,32613,32614,32615,32605,32635,32641,32648,32649,32650,32651,32652,32678,32684,32685,32686,32687,32688,32689,32690,32683,32698,32755,32756,32757,32758,32759,32762,32753,32790,32805,32806,32807,32808,32809,32811,32823,32910,32864,32865,32866,32867,32868,32909,32924,32928,32936,32937,32938,32939,32940,32945,32959,32960,32961,32995,33012,33013,33014,33015,33016,33017,32980,33068,33082,33083,33084,33085,33086,33069,33132,33104,33114,33115,33116,33117,33118,33168,33169,33170,33171,33172,33250,33224,33225,33226,33227,33228,33302,33303,33304,33305,33306,33299,33300,33336,33337,33338,33339,33340,33380,33381,33382,33383,33384,33367,33436,33437,33438,33439,33440,33473,33523,33524,33525,33526,33527,33560,33606,33607,33608,33609,33610,33646,33647,33648,33649,33650,33626,33765,33766,33767,33768,33769,33816,33817,33818,33819,33820,33871,33872,33873,33896,33897,33898,33899,33900,33909,33910,33911,33912,33973,33974,33975,33976,37171,35679,37597,37172,35680,37598,37173,35681,37599,37174,35682,37600,37175,35683,37601,34238,34239,34240,34241,34331,34332,34333,34334,34363,34364,34365,34366,34367,34438,34439,34440,34441,34442,34443,34444,34445,34446,34511,34512,34514,34515,34516,34567,34568,34569,34570,34571,34612,34613,34614,34615,34616,34747,34763,37528,34748,37529,34749,37530,34750,37531,34751,37532,34901,34902,34903,34904,34905,34956,34957,34958,34959,34960,35020,35021,35022,35023,35024,37680,37681,37682,37683,37684,37685,37686,37687,37688,35251,35854,35252,35855,35253,35856,35254,35857,35255,35858,37757,37758,37759,37760,37761,37762,37763,37764,37765,37766,35395,35396,35397,35398,35399,35444,35445,35446,35447,35448,35526,35527,35528,35529,35530,37161,37162,37163,37164,37165,35624,35625,35626,35627,35628,35608,35609,35610,35727,35728,35729,35730,35786,35787,35788,35789,35790,35832,35833,35834,35835,35836,35928,35929,35930,35931,35932,35976,35977,35978,35979,35980,37767,37768,37769,37770,37771,37066,37067,37068,37069,37070,37071,37072,37073,37074,37075,36137,36138,36139,36140,36141,37166,37588,37167,37589,37168,37590,37169,37591,37170,37592,36241,36242,36243,36244,36245,36285,36286,36287,36288,36289,36329,36330,36331,36332,36333,37690,36950,37691,36951,37692,36952,37693,36953,37694,36954,36456,36457,36458,36459,36460,36507,36508,36509,36510,36511,36536,36537,36538,36539,36540,36575,37489,36576,37490,36577,37491,36578,37492,36579,37493,36596,36597,36684,36685,36686,36687,36688,36714,36715,36716,36717,36718,36767,36768,36772,36755,36756,36757,36758,36759,36810,36811,36812,36813,36814,36835,36836,36837,36838,36834,36872,36873,36874,36875,36876,36912,36913,36914,36915,36916,37000,37001,37002,37003,37004,36994,36995,36996,36997,36998,37112,37113,37208,37273,37602,37274,37603,37275,37604,37276,37605,37277,37606,37278,37279,37280,37281,37282,37283,37284,37285,37286,37287,37373,37374,37375,37376,37377,37453,37454,37455,37456,37457,37458,37459,37460,37461,37462,37463,37487,37488,37494,37495,37496,37497,37498,37533,37534,37535,37536,37537,37538,37594,37724,37725,37726,37727];
         var i:int = 0;
         i = 0;
         while(i < 10)
         {
            var randomIndex:int = Math.floor(Math.random() * allGiftIDs.length);
            var randomResult:uint = uint(allGiftIDs[randomIndex]);
            trace("[随机礼物触发] _result =",randomResult);
            this.getPresent(randomResult);
            i++;
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      protected function getPresent(_result:uint) : void
      {
         trace("---_result---",_result);
         switch(_result)
         {
            case 79:
               this.getShenMiPresent();
               break;
            case 121:
               this.getWeiXin2();
               break;
            case 127:
               this.getChuanSongPresent();
               break;
            case 153:
               this.getJiPingHuWan();
               break;
            case 178:
               this.getValentinesPresent();
               break;
            case 195:
               this.getDoubleFestival();
               break;
            case 243:
               this.getChongZhiPresent();
               break;
            case 263:
               this.getDoubleEgePresent();
               break;
            case 307:
               this.getPCNewYear();
               break;
            case 566:
               this.getClientPhonePresent();
               break;
            case 2590:
               this.getNianShouPresent();
               break;
            case 2846:
               this.getZhongQiuPresent();
               break;
            case 3394:
               this.nationDay2014Present();
               break;
            case 4030:
               this.halloweenDay();
               break;
            case 3798:
               this.tequanPresent();
               break;
            case 4972:
               this.starPetPresent();
               break;
            case 4976:
               this.yhjlPresent();
               break;
            case 5648:
               this.tuyaPresent();
               break;
            case 5872:
               this.doubleEgePresent();
               break;
            case 5894:
               this.oneThreeDay();
               break;
            case 5896:
               this.oneSevenDay();
               break;
            case 5898:
               this.oneFourteenDay();
               break;
            case 5900:
               this.oneTwentyDay();
               break;
            case 6832:
               this.tuYa96Present();
               break;
            case 6720:
               this.yuanbaoPresent();
               break;
            case 7122:
               this.twoThreeDay();
               break;
            case 7124:
               this.twoSevenDay();
               break;
            case 7126:
               this.twoFifteenDay();
               break;
            case 7130:
               this.twoTwentyFiveDay();
               break;
            case 7254:
               this.bbbNormalPresent();
               break;
            case 7532:
               this.bbbSpecialPresent();
               break;
            case 7680:
               this.cunJiePresent2015();
               break;
            case 8918:
               this.tuYa99Present();
               break;
            case 8922:
               this.threeOneDay();
               break;
            case 8924:
               this.threeSeventDay();
               break;
            case 8926:
               this.threeFifteenDay();
               break;
            case 8928:
               this.threeTwentyFiveDay();
               break;
            case 9492:
               this.tuYa100Present();
               break;
            case 9612:
               this.zhuanPanPresent();
               break;
            case 9990:
               this.tuYa101Present();
               break;
            case 9992:
               this.tuYa102Present();
               break;
            case 11162:
               this.wuyiHappyPresent();
               break;
            case 11160:
               this.wuyiFunPresent();
               break;
            case 11328:
               this.tuYa103Present();
               break;
            case 11150:
               this.mayOneDay();
               break;
            case 11152:
               this.maySeventDay();
               break;
            case 11156:
               this.mayFifteenDay();
               break;
            case 11158:
               this.mayTwentyFiveDay();
               break;
            case 11670:
               this.tuYa104Present();
               break;
            case 12474:
               this.tuYa105Present();
               break;
            case 12822:
               this.childrenDay2015();
               break;
            case 12654:
               this.juneOneDay();
               break;
            case 12656:
               this.juneSevenDay();
               break;
            case 12658:
               this.juneFifteenDay();
               break;
            case 12660:
               this.juneTwentyFiveDay();
               break;
            case 13070:
               this.qinglongjianPresent();
               break;
            case 13254:
               this.tuYa106Present();
               break;
            case 12882:
               this.yikatongBigPresent();
               break;
            case 12880:
               this.yikatongSmallPresent();
               break;
            case 13758:
               this.tuYa107Present();
               break;
            case 14320:
               this.julyOneDay();
               break;
            case 14322:
               this.julySevenDay();
               break;
            case 14324:
               this.julyFifteenDay();
               break;
            case 14326:
               this.julyTwentyFiveDay();
               break;
            case 14566:
               this.tuYa108Present();
               break;
            case 14958:
               this.tuYaSaiZiShu();
               break;
            case 14960:
               this.tuYaSaiChouNiu();
               break;
            case 13572:
               this.bangWoTongXin();
               break;
            case 15050:
               this.tuYa109Present();
               break;
            case 15268:
               this.summerHoliday2015();
               break;
            case 15696:
               this.yuetuPresent();
               break;
            case 15710:
               this.augustOneDay();
               break;
            case 15712:
               this.augustSevenDay();
               break;
            case 15718:
               this.augustFifteenDay();
               break;
            case 15720:
               this.augustTwentyFiveDay();
               break;
            case 16282:
               this.tuYa110Present();
               break;
            case 16804:
               this.tuYa111Present();
               break;
            case 17484:
               this.septemberOneDay();
               break;
            case 17486:
               this.septemberSevenDay();
               break;
            case 17488:
               this.septemberFifteenDay();
               break;
            case 17490:
               this.septemberTwentyFiveDay();
               break;
            case 17606:
               this.tuYa112Present();
               break;
            case 18062:
               this.tuYa113Present();
               break;
            case 19142:
               this.octoberOneDay();
               break;
            case 19144:
               this.octoberSeventDay();
               break;
            case 19148:
               this.octoberFifteenDay();
               break;
            case 19150:
               this.octoberTwentyFiveDay();
               break;
            case 18216:
               this.haohuaPresent();
               break;
            case 20102:
               this.tuYa115Present();
               break;
            case 20318:
               this.novemberOneDay();
               break;
            case 20320:
               this.novemberSevenDay();
               break;
            case 20322:
               this.novemberFifteenDay();
               break;
            case 20324:
               this.novemberTwentyFiveDay();
               break;
            case 20462:
               this.tuYa116Present();
               break;
            case 20614:
               this.tuYa117Present();
               break;
            case 20846:
               this.tuYa118Present();
               break;
            case 20970:
               this.tuYa119Present();
               break;
            case 20868:
               this.decemberOneDay();
               break;
            case 20870:
               this.decemberSevenDay();
               break;
            case 20872:
               this.decemberFifteenDay();
               break;
            case 20874:
               this.decemberTwentyFiveDay();
               break;
            case 20684:
               this.millionPresent();
               break;
            case 21060:
               this.pkPersent();
               break;
            case 21230:
               this.tuYa120Present();
               break;
            case 21454:
               this.one_yueqiandao(1);
               break;
            case 21456:
               this.one_yueqiandao(2);
               break;
            case 21458:
               this.one_yueqiandao(3);
               break;
            case 21460:
               this.one_yueqiandao(4);
               break;
            case 21446:
               this.tuYa121Present();
               break;
            case 21894:
               this.tuYa122Present();
               break;
            case 22004:
               this.gameBoxNewYearPresent();
               break;
            case 22218:
               this.two_yueqiandao(1);
               break;
            case 22220:
               this.two_yueqiandao(2);
               break;
            case 22222:
               this.two_yueqiandao(3);
               break;
            case 22224:
               this.two_yueqiandao(4);
               break;
            case 22110:
               this.monkeyYearPresent();
               break;
            case 21954:
               this.tuYa123Present();
               break;
            case 21956:
               this.tuYa124Present();
               break;
            case 23338:
               this.three_yueqiandao(1);
               break;
            case 23340:
               this.three_yueqiandao(2);
               break;
            case 23342:
               this.three_yueqiandao(3);
               break;
            case 23344:
               this.three_yueqiandao(4);
               break;
            case 23484:
               this.tuYa125Present();
               break;
            case 23200:
               this.bbb2NormalPresent();
               break;
            case 23202:
               this.bbb2SpecialPresent();
               break;
            case 23914:
               this.tuYa126Present();
               break;
            case 23968:
               this.four_yueqiandao(1);
               break;
            case 23972:
               this.four_yueqiandao(2);
               break;
            case 23974:
               this.four_yueqiandao(3);
               break;
            case 23976:
               this.four_yueqiandao(4);
               break;
            case 24214:
               this.tuYa127Present();
               break;
            case 24682:
               this.tuYa128Present();
               break;
            case 24970:
               this.tuYa129Present();
               break;
            case 25102:
               this.five_yueqiandao(1);
               break;
            case 25104:
               this.five_yueqiandao(2);
               break;
            case 25106:
               this.five_yueqiandao(3);
               break;
            case 25108:
               this.five_yueqiandao(4);
               break;
            case 25160:
               this.laborsDay2016();
               break;
            case 25070:
               this.xiaoHuDuiPresent1();
               break;
            case 24832:
               this.xiaoHuDuiPresent2();
               break;
            case 24836:
               this.xiaoHuDuiPresent3();
               break;
            case 25910:
               this.tuya130();
               break;
            case 26310:
               this.tuya131();
               break;
            case 26266:
               this.six_yueqiandao(1);
               break;
            case 26268:
               this.six_yueqiandao(2);
               break;
            case 26270:
               this.six_yueqiandao(3);
               break;
            case 26272:
               this.six_yueqiandao(4);
               break;
            case 26946:
               this.tuya132();
               break;
            case 27762:
               this.tuya133();
               break;
            case 27562:
               this.seven_yueqiandao(1);
               break;
            case 27564:
               this.seven_yueqiandao(2);
               break;
            case 27566:
               this.seven_yueqiandao(3);
               break;
            case 27568:
               this.seven_yueqiandao(4);
               break;
            case 28424:
               this.tuya134();
               break;
            case 29112:
               this.tuya135();
               break;
            case 28030:
               this.duoBaoPresent();
               break;
            case 29126:
               this.eight_yueqiandao(1);
               break;
            case 29136:
               this.eight_yueqiandao(2);
               break;
            case 29138:
               this.eight_yueqiandao(3);
               break;
            case 29140:
               this.eight_yueqiandao(4);
               break;
            case 29296:
               this.cangjinggePresent1();
               break;
            case 29298:
               this.cangjinggePresent2();
               break;
            case 29300:
               this.cangjinggePresent3();
               break;
            case 29302:
               this.cangjinggePresent4();
               break;
            case 29304:
               this.cangjinggePresent5();
               break;
            case 29306:
               this.cangjinggePresent6();
               break;
            case 29560:
               this.tuya136();
               break;
            case 29998:
               this.tuya136BiShai();
               break;
            case 30678:
               this.shouyoutong2016();
               break;
            case 30658:
               this.qiandao9yue2016_1();
               break;
            case 30660:
               this.qiandao9yue2016_5();
               break;
            case 30662:
               this.qiandao9yue2016_14();
               break;
            case 30664:
               this.qiandao9yue2016_25();
               break;
            case 30918:
               this.tuya138();
               break;
            case 31164:
               this.tuya139();
               break;
            case 31684:
               this.tuya140();
               break;
            case 31542:
               this.qiandao10yue2016_1();
               break;
            case 31544:
               this.qiandao10yue2016_5();
               break;
            case 31546:
               this.qiandao10yue2016_14();
               break;
            case 31548:
               this.qiandao10yue2016_25();
               break;
            case 31876:
               this.tuya141();
               break;
            case 31892:
               this.tuya142();
               break;
            case 31910:
               this.qiandao11yue2016_1();
               break;
            case 31912:
               this.qiandao11yue2016_5();
               break;
            case 31914:
               this.qiandao11yue2016_14();
               break;
            case 31916:
               this.qiandao11yue2016_25();
               break;
            case 31970:
               this.tuya143();
               break;
            case 32012:
               this.tuya144();
               break;
            case 31976:
               this.qiandao12yue2016_1();
               break;
            case 31978:
               this.qiandao12yue2016_5();
               break;
            case 31980:
               this.qiandao12yue2016_14();
               break;
            case 31982:
               this.qiandao12yue2016_25();
               break;
            case 32054:
               this.tuya145();
               break;
            case 31972:
               this.doubleEgePresent2017();
               break;
            case 32046:
            case 32126:
               this.qiandao1yue2017_1();
               break;
            case 32048:
            case 32128:
               this.qiandao1yue2017_5();
               break;
            case 32050:
            case 32130:
               this.qiandao1yue2017_14();
               break;
            case 32052:
            case 32132:
               this.qiandao1yue2017_25();
               break;
            case 32134:
               this.tuya146();
               break;
            case 32172:
               this.tuya147();
               break;
            case 32290:
               this.cangjinggePresent();
               break;
            case 32334:
               this.tuya148();
               break;
            case 32324:
               this.qiandao3yue2017_1();
               break;
            case 32326:
               this.qiandao3yue2017_5();
               break;
            case 32328:
               this.qiandao3yue2017_14();
               break;
            case 32330:
               this.qiandao3yue2017_25();
               break;
            case 32360:
               this.tuya149();
               break;
            case 32384:
               this.tuya150();
               break;
            case 32388:
               this.weiChatCbtPresent();
               break;
            case 32390:
               this.bibaboTogetherPresent();
               break;
            case 32407:
               this.tuya151();
               break;
            case 32402:
               this.qiandao4yue2017_1();
               break;
            case 32403:
               this.qiandao4yue2017_5();
               break;
            case 32404:
               this.qiandao4yue2017_14();
               break;
            case 32405:
               this.qiandao4yue2017_25();
               break;
            case 32406:
               this.qiandao4yue2017_30();
               break;
            case 32427:
               this.tuya152();
               break;
            case 32432:
               this.tuya153();
               break;
            case 32433:
               this.qiandao5yue2017_1();
               break;
            case 32434:
               this.qiandao5yue2017_5();
               break;
            case 32435:
               this.qiandao5yue2017_14();
               break;
            case 32436:
               this.qiandao5yue2017_25();
               break;
            case 32437:
               this.qiandao5yue2017_30();
               break;
            case 32471:
               this.tuya154();
               break;
            case 32472:
               this.qiandao6yue2017_1();
               break;
            case 32473:
               this.qiandao6yue2017_5();
               break;
            case 32474:
               this.qiandao6yue2017_14();
               break;
            case 32475:
               this.qiandao6yue2017_25();
               break;
            case 32476:
               this.qiandao6yue2017_30();
               break;
            case 32478:
               this.shenlongPresent();
               break;
            case 32506:
               this.tuya155();
               break;
            case 32518:
               this.aoTeManPresent();
               break;
            case 32519:
               this.qiandao7yue2017_1();
               break;
            case 32520:
               this.qiandao7yue2017_5();
               break;
            case 32521:
               this.qiandao7yue2017_14();
               break;
            case 32522:
               this.qiandao7yue2017_25();
               break;
            case 32523:
               this.qiandao7yue2017_30();
               break;
            case 32533:
               this.yxhdzzPresent();
               break;
            case 32611:
               this.one_eightqiandao(1);
               break;
            case 32612:
               this.one_eightqiandao(2);
               break;
            case 32613:
               this.one_eightqiandao(3);
               break;
            case 32614:
               this.one_eightqiandao(4);
               break;
            case 32615:
               this.one_eightqiandao(5);
               break;
            case 32605:
               this.catchSpritePresent();
               break;
            case 32635:
               this.tuya158();
               break;
            case 32641:
               this.weixinNeiHan();
               break;
            case 32648:
               this.nightMonthqiandao(1);
               break;
            case 32649:
               this.nightMonthqiandao(2);
               break;
            case 32650:
               this.nightMonthqiandao(3);
               break;
            case 32651:
               this.nightMonthqiandao(4);
               break;
            case 32652:
               this.nightMonthqiandao(5);
               break;
            case 32678:
               this.bbbtxPresent();
               break;
            case 32684:
               this.huahaoyueyuanPresent();
               break;
            case 32685:
               this.chongxiaoPresent();
               break;
            case 32686:
               this.tenMonthqiandao(1);
               break;
            case 32687:
               this.tenMonthqiandao(2);
               break;
            case 32688:
               this.tenMonthqiandao(3);
               break;
            case 32689:
               this.tenMonthqiandao(4);
               break;
            case 32690:
               this.tenMonthqiandao(5);
               break;
            case 32683:
               this.shumabaolongPresent();
               break;
            case 32698:
               this.tuya160();
               break;
            case 32755:
               this.eleventMonthqiandao(1);
               break;
            case 32756:
               this.eleventMonthqiandao(2);
               break;
            case 32757:
               this.eleventMonthqiandao(3);
               break;
            case 32758:
               this.eleventMonthqiandao(4);
               break;
            case 32759:
               this.eleventMonthqiandao(5);
               break;
            case 32762:
               this.tuya161();
               break;
            case 32753:
               this.wangshengjiePresent();
               break;
            case 32790:
               this.double11Present();
               break;
            case 32805:
               this.twelveMonthqiandao(1);
               break;
            case 32806:
               this.twelveMonthqiandao(2);
               break;
            case 32807:
               this.twelveMonthqiandao(3);
               break;
            case 32808:
               this.twelveMonthqiandao(4);
               break;
            case 32809:
               this.twelveMonthqiandao(5);
               break;
            case 32811:
               this.tuya162();
               break;
            case 32823:
               this.diaoyuPresent();
               break;
            case 32910:
               this.tuya164();
               break;
            case 32864:
               this.one_18qiandao(1);
               break;
            case 32865:
               this.one_18qiandao(2);
               break;
            case 32866:
               this.one_18qiandao(3);
               break;
            case 32867:
               this.one_18qiandao(4);
               break;
            case 32868:
               this.one_18qiandao(5);
               break;
            case 32909:
               this.doulaamengPrensent();
               break;
            case 32924:
               this.youNeiHanHJPresent();
               break;
            case 32928:
               this.weiXinLiaomeiPresent();
               break;
            case 32936:
               this.two_18qiandao(1);
               break;
            case 32937:
               this.two_18qiandao(2);
               break;
            case 32938:
               this.two_18qiandao(3);
               break;
            case 32939:
               this.two_18qiandao(4);
               break;
            case 32940:
               this.two_18qiandao(5);
               break;
            case 32945:
               this.tuya166();
               break;
            case 32959:
               this.zmDwjPresent1();
               break;
            case 32960:
               this.zmDwjPresent2();
               break;
            case 32961:
               this.zmDwjPresent3();
               break;
            case 32995:
               this.weiXinChongZhiPresent();
               break;
            case 33012:
               this.haiMianBaoBaoPresent();
               break;
            case 33013:
               this.three_18qiandao(1);
               break;
            case 33014:
               this.three_18qiandao(2);
               break;
            case 33015:
               this.three_18qiandao(3);
               break;
            case 33016:
               this.three_18qiandao(4);
               break;
            case 33017:
               this.three_18qiandao(5);
               break;
            case 32980:
               this.tuya167();
               break;
            case 33068:
               this.dregonBigPresent();
               break;
            case 33082:
               this.four_18qiandao(1);
               break;
            case 33083:
               this.four_18qiandao(2);
               break;
            case 33084:
               this.four_18qiandao(3);
               break;
            case 33085:
               this.four_18qiandao(4);
               break;
            case 33086:
               this.four_18qiandao(5);
               break;
            case 33069:
               this.tuya168();
               break;
            case 33132:
               this.tuya169();
               break;
            case 33104:
               this.weiXinBigPresent();
               break;
            case 33114:
               this.five_18qiandao(1);
               break;
            case 33115:
               this.five_18qiandao(2);
               break;
            case 33116:
               this.five_18qiandao(3);
               break;
            case 33117:
               this.five_18qiandao(4);
               break;
            case 33118:
               this.five_18qiandao(5);
               break;
            case 33168:
               this.six_18qiandao(1);
               break;
            case 33169:
               this.six_18qiandao(2);
               break;
            case 33170:
               this.six_18qiandao(3);
               break;
            case 33171:
               this.six_18qiandao(4);
               break;
            case 33172:
               this.six_18qiandao(5);
               break;
            case 33250:
               this.tuya171();
               break;
            case 33224:
               this.seven_18qiandao(1);
               break;
            case 33225:
               this.seven_18qiandao(2);
               break;
            case 33226:
               this.seven_18qiandao(3);
               break;
            case 33227:
               this.seven_18qiandao(4);
               break;
            case 33228:
               this.seven_18qiandao(5);
               break;
            case 33302:
               this.eight_18qiandao(1);
               break;
            case 33303:
               this.eight_18qiandao(2);
               break;
            case 33304:
               this.eight_18qiandao(3);
               break;
            case 33305:
               this.eight_18qiandao(4);
               break;
            case 33306:
               this.eight_18qiandao(5);
               break;
            case 33299:
               this.weixinchongzhi();
               break;
            case 33300:
               this.xiarijiActivity();
               break;
            case 33336:
               this.night_18qiandao(1);
               break;
            case 33337:
               this.night_18qiandao(2);
               break;
            case 33338:
               this.night_18qiandao(3);
               break;
            case 33339:
               this.night_18qiandao(4);
               break;
            case 33340:
               this.night_18qiandao(5);
               break;
            case 33380:
               this.ten_18qiandao(1);
               break;
            case 33381:
               this.ten_18qiandao(2);
               break;
            case 33382:
               this.ten_18qiandao(3);
               break;
            case 33383:
               this.ten_18qiandao(4);
               break;
            case 33384:
               this.ten_18qiandao(5);
               break;
            case 33367:
               this.weixinPresent20180927();
               break;
            case 33436:
               this.ele_18qiandao(1);
               break;
            case 33437:
               this.ele_18qiandao(2);
               break;
            case 33438:
               this.ele_18qiandao(3);
               break;
            case 33439:
               this.ele_18qiandao(4);
               break;
            case 33440:
               this.ele_18qiandao(5);
               break;
            case 33473:
               this.thanksGivenDay2018();
               break;
            case 33523:
               this.tew_18qiandao(1);
               break;
            case 33524:
               this.tew_18qiandao(2);
               break;
            case 33525:
               this.tew_18qiandao(3);
               break;
            case 33526:
               this.tew_18qiandao(4);
               break;
            case 33527:
               this.tew_18qiandao(5);
               break;
            case 33560:
               this.kuainian2019();
               break;
            case 33606:
               this.one_19qiandao(1);
               break;
            case 33607:
               this.one_19qiandao(2);
               break;
            case 33608:
               this.one_19qiandao(3);
               break;
            case 33609:
               this.one_19qiandao(4);
               break;
            case 33610:
               this.one_19qiandao(5);
               break;
            case 33646:
               this.two_19qiandao(1);
               break;
            case 33647:
               this.two_19qiandao(2);
               break;
            case 33648:
               this.two_19qiandao(3);
               break;
            case 33649:
               this.two_19qiandao(4);
               break;
            case 33650:
               this.two_19qiandao(5);
               break;
            case 33626:
               this.zhuoquPresent();
               break;
            case 33765:
               this.three_19qiandao(1);
               break;
            case 33766:
               this.three_19qiandao(2);
               break;
            case 33767:
               this.three_19qiandao(3);
               break;
            case 33768:
               this.three_19qiandao(4);
               break;
            case 33769:
               this.three_19qiandao(5);
               break;
            case 33816:
               this.four_19qiandao(1);
               break;
            case 33817:
               this.four_19qiandao(2);
               break;
            case 33818:
               this.four_19qiandao(3);
               break;
            case 33819:
               this.four_19qiandao(4);
               break;
            case 33820:
               this.four_19qiandao(5);
               break;
            case 33871:
               this.one_19Zq(1);
               break;
            case 33872:
               this.one_19Zq(2);
               break;
            case 33873:
               this.one_19Zq(3);
               break;
            case 33896:
               this.five_19qiandao(1);
               break;
            case 33897:
               this.five_19qiandao(2);
               break;
            case 33898:
               this.five_19qiandao(3);
               break;
            case 33899:
               this.five_19qiandao(4);
               break;
            case 33900:
               this.five_19qiandao(5);
               break;
            case 33909:
               this.five_19Zq(1);
               break;
            case 33910:
               this.five_19Zq(2);
               break;
            case 33911:
               this.five_19Zq(3);
               break;
            case 33912:
               this.five_19Zq(4);
               break;
            case 33973:
               this.six_19Zq(1);
               break;
            case 33974:
               this.six_19Zq(2);
               break;
            case 33975:
               this.six_19Zq(3);
               break;
            case 33976:
               this.six_19Zq(4);
               break;
            case 37171:
            case 35679:
            case 37597:
               this.six_19qiandao(1);
               break;
            case 37172:
            case 35680:
            case 37598:
               this.six_19qiandao(2);
               break;
            case 37173:
            case 35681:
            case 37599:
               this.six_19qiandao(3);
               break;
            case 37174:
            case 35682:
            case 37600:
               this.six_19qiandao(4);
               break;
            case 37175:
            case 35683:
            case 37601:
               this.six_19qiandao(5);
               break;
            case 34238:
               this.night_19Zq(1);
               break;
            case 34239:
               this.night_19Zq(2);
               break;
            case 34240:
               this.night_19Zq(3);
               break;
            case 34241:
               this.night_19Zq(4);
               break;
            case 34331:
               this.ten_19Zq(1);
               break;
            case 34332:
               this.ten_19Zq(2);
               break;
            case 34333:
               this.ten_19Zq(3);
               break;
            case 34334:
               this.ten_19Zq(4);
               break;
            case 34363:
               this.ten_19qiandao(1);
               break;
            case 34364:
               this.ten_19qiandao(2);
               break;
            case 34365:
               this.ten_19qiandao(3);
               break;
            case 34366:
               this.ten_19qiandao(4);
               break;
            case 34367:
               this.ten_19qiandao(5);
               break;
            case 34438:
               this.ele_19qiandao(1);
               break;
            case 34439:
               this.ele_19qiandao(2);
               break;
            case 34440:
               this.ele_19qiandao(3);
               break;
            case 34441:
               this.ele_19qiandao(4);
               break;
            case 34442:
               this.ele_19qiandao(5);
               break;
            case 34443:
               this.ele_19Zq(1);
               break;
            case 34444:
               this.ele_19Zq(2);
               break;
            case 34445:
               this.ele_19Zq(3);
               break;
            case 34446:
               this.ele_19Zq(4);
               break;
            case 34511:
               this.mon_12_sign(1);
               break;
            case 34512:
               this.mon_12_sign(2);
               break;
            case 34514:
               this.mon_12_sign(3);
               break;
            case 34515:
               this.mon_12_sign(4);
               break;
            case 34516:
               this.mon_12_sign(5);
               break;
            case 34567:
               this.one_19qiandao(1);
               break;
            case 34568:
               this.one_19qiandao(2);
               break;
            case 34569:
               this.one_19qiandao(3);
               break;
            case 34570:
               this.one_19qiandao(4);
               break;
            case 34571:
               this.one_19qiandao(5);
               break;
            case 34612:
               this.feb_12_sign(1);
               break;
            case 34613:
               this.feb_12_sign(2);
               break;
            case 34614:
               this.feb_12_sign(3);
               break;
            case 34615:
               this.feb_12_sign(4);
               break;
            case 34616:
               this.feb_12_sign(5);
               break;
            case 34747:
               this.mar_12_sign(1);
               break;
            case 34763:
            case 37528:
               this.mar_12_sign(1);
               break;
            case 34748:
            case 37529:
               this.mar_12_sign(2);
               break;
            case 34749:
            case 37530:
               this.mar_12_sign(3);
               break;
            case 34750:
            case 37531:
               this.mar_12_sign(4);
               break;
            case 34751:
            case 37532:
               this.mar_12_sign(5);
               break;
            case 34901:
               this.may_12_sign(1);
               break;
            case 34902:
               this.may_12_sign(2);
               break;
            case 34903:
               this.may_12_sign(3);
               break;
            case 34904:
               this.may_12_sign(4);
               break;
            case 34905:
               this.may_12_sign(5);
               break;
            case 34956:
               this.six_12_sign(1);
               break;
            case 34957:
               this.six_12_sign(2);
               break;
            case 34958:
               this.six_12_sign(3);
               break;
            case 34959:
               this.six_12_sign(4);
               break;
            case 34960:
               this.six_12_sign(5);
               break;
            case 35020:
               this.seven_12_sign(1);
               break;
            case 35021:
               this.seven_12_sign(2);
               break;
            case 35022:
               this.seven_12_sign(3);
               break;
            case 35023:
               this.seven_12_sign(4);
               break;
            case 35024:
               this.seven_12_sign(5);
               break;
            case 37680:
               this.eight_12_sign(1);
               break;
            case 37681:
               this.eight_12_sign(2);
               break;
            case 37682:
               this.eight_12_sign(3);
               break;
            case 37683:
               this.eight_12_sign(4);
               break;
            case 37684:
               this.eight_12_sign(5);
               break;
            case 37685:
               this.night_12_sign(1);
               break;
            case 37686:
               this.night_12_sign(2);
               break;
            case 37687:
               this.night_12_sign(3);
               break;
            case 37688:
               this.night_12_sign(4);
               break;
            case 37689:
               this.night_12_sign(5);
               break;
            case 35251:
            case 35854:
               this.ten_12_sign(1);
               break;
            case 35252:
            case 35855:
               this.ten_12_sign(2);
               break;
            case 35253:
            case 35856:
               this.ten_12_sign(3);
               break;
            case 35254:
            case 35857:
               this.ten_12_sign(4);
               break;
            case 35255:
            case 35858:
               this.ten_12_sign(5);
               break;
            case 37757:
               this.ele_12_sign(1);
               break;
            case 37758:
               this.ele_12_sign(2);
               break;
            case 37759:
               this.ele_12_sign(3);
               break;
            case 37760:
               this.ele_12_sign(4);
               break;
            case 37761:
               this.ele_12_sign(5);
               break;
            case 37762:
               this.twl_12_sign(1);
               break;
            case 37763:
               this.twl_12_sign(2);
               break;
            case 37764:
               this.twl_12_sign(3);
               break;
            case 37765:
               this.twl_12_sign(4);
               break;
            case 37766:
               this.twl_12_sign(5);
               break;
            case 35395:
               this.one_2021_sign(1);
               break;
            case 35396:
               this.one_2021_sign(2);
               break;
            case 35397:
               this.one_2021_sign(3);
               break;
            case 35398:
               this.one_2021_sign(4);
               break;
            case 35399:
               this.one_2021_sign(5);
               break;
            case 35444:
               this.feb_12_sign(1);
               break;
            case 35445:
               this.feb_12_sign(2);
               break;
            case 35446:
               this.feb_12_sign(3);
               break;
            case 35447:
               this.feb_12_sign(4);
               break;
            case 35448:
               this.feb_12_sign(5);
               break;
            case 35526:
               this.four_19qiandao(1);
               break;
            case 35527:
               this.four_19qiandao(2);
               break;
            case 35528:
               this.four_19qiandao(3);
               break;
            case 35529:
               this.four_19qiandao(4);
               break;
            case 35530:
               this.four_19qiandao(5);
               break;
            case 37161:
               this.april_12_sign(1);
               break;
            case 37162:
               this.april_12_sign(2);
               break;
            case 37163:
               this.april_12_sign(3);
               break;
            case 37164:
               this.april_12_sign(4);
               break;
            case 37165:
               this.april_12_sign(5);
               break;
            case 35624:
               this.may_2021_sign(1);
               break;
            case 35625:
               this.may_2021_sign(2);
               break;
            case 35626:
               this.may_2021_sign(3);
               break;
            case 35627:
               this.may_2021_sign(4);
               break;
            case 35628:
               this.may_2021_sign(5);
               break;
            case 35608:
               this.shizhounianzz(1);
               break;
            case 35609:
               this.shizhounianzz(2);
               break;
            case 35610:
               this.shizhounianzz(3);
               break;
            case 35727:
               this.seven_12_sign(1);
               break;
            case 35728:
               this.seven_12_sign(2);
               break;
            case 35729:
               this.seven_12_sign(4);
               break;
            case 35730:
               this.seven_12_sign(5);
               break;
            case 35786:
               this.eight_12_sign(1);
               break;
            case 35787:
               this.eight_12_sign(2);
               break;
            case 35788:
               this.eight_12_sign(3);
               break;
            case 35789:
               this.eight_12_sign(4);
               break;
            case 35790:
               this.eight_12_sign(5);
               break;
            case 35832:
               this.night_12_sign(1);
               break;
            case 35833:
               this.night_12_sign(2);
               break;
            case 35834:
               this.night_12_sign(3);
               break;
            case 35835:
               this.night_12_sign(4);
               break;
            case 35836:
               this.night_12_sign(5);
               break;
            case 35928:
               this.ele_12_sign(1);
               break;
            case 35929:
               this.ele_12_sign(2);
               break;
            case 35930:
               this.ele_12_sign(3);
               break;
            case 35931:
               this.ele_12_sign(4);
               break;
            case 35932:
               this.ele_12_sign(5);
               break;
            case 35976:
               this.twl_12_sign(1);
               break;
            case 35977:
               this.twl_12_sign(2);
               break;
            case 35978:
               this.twl_12_sign(3);
               break;
            case 35979:
               this.twl_12_sign(4);
               break;
            case 35980:
               this.twl_12_sign(5);
               break;
            case 37767:
               this.one_2022_sign(1);
               break;
            case 37768:
               this.one_2022_sign(2);
               break;
            case 37769:
               this.one_2022_sign(3);
               break;
            case 37770:
               this.one_2022_sign(4);
               break;
            case 37771:
               this.one_2022_sign(5);
               break;
            case 37066:
               this.feb_12_sign(1);
               break;
            case 37067:
               this.feb_12_sign(2);
               break;
            case 37068:
               this.feb_12_sign(3);
               break;
            case 37069:
               this.feb_12_sign(4);
               break;
            case 37070:
               this.feb_12_sign(5);
               break;
            case 37071:
               this.four_19qiandao(1);
               break;
            case 37072:
               this.four_19qiandao(2);
               break;
            case 37073:
               this.four_19qiandao(3);
               break;
            case 37074:
               this.four_19qiandao(4);
               break;
            case 37075:
               this.four_19qiandao(5);
               break;
            case 36137:
               this.four_2022_sign(1);
               break;
            case 36138:
               this.four_2022_sign(2);
               break;
            case 36139:
               this.four_2022_sign(3);
               break;
            case 36140:
               this.four_2022_sign(4);
               break;
            case 36141:
               this.four_2022_sign(5);
               break;
            case 37166:
            case 37588:
               this.five_2022_sign(1);
               break;
            case 37167:
            case 37589:
               this.five_2022_sign(2);
               break;
            case 37168:
            case 37590:
               this.five_2022_sign(3);
               break;
            case 37169:
            case 37591:
               this.five_2022_sign(4);
               break;
            case 37170:
            case 37592:
               this.five_2022_sign(5);
               break;
            case 36241:
               this.six_19qiandao(1);
               break;
            case 36242:
               this.six_19qiandao(2);
               break;
            case 36243:
               this.six_19qiandao(3);
               break;
            case 36244:
               this.six_19qiandao(4);
               break;
            case 36245:
               this.six_19qiandao(5);
               break;
            case 36285:
               this.seven_12_sign(1);
               break;
            case 36286:
               this.seven_12_sign(2);
               break;
            case 36287:
               this.seven_12_sign(3);
               break;
            case 36288:
               this.seven_12_sign(4);
               break;
            case 36289:
               this.seven_12_sign(5);
               break;
            case 36329:
               this.eight_12_sign(1);
               break;
            case 36330:
               this.eight_12_sign(2);
               break;
            case 36331:
               this.eight_12_sign(3);
               break;
            case 36332:
               this.eight_12_sign(4);
               break;
            case 36333:
               this.eight_12_sign(5);
               break;
            case 37690:
            case 36950:
               this.ten_22qiandao(1);
               break;
            case 37691:
            case 36951:
               this.ten_22qiandao(2);
               break;
            case 37692:
            case 36952:
               this.ten_22qiandao(3);
               break;
            case 37693:
            case 36953:
               this.ten_22qiandao(4);
               break;
            case 37694:
            case 36954:
               this.ten_22qiandao(5);
               break;
            case 36456:
               this.ele_12_sign(1);
               break;
            case 36457:
               this.ele_12_sign(2);
               break;
            case 36458:
               this.ele_12_sign(3);
               break;
            case 36459:
               this.ele_12_sign(4);
               break;
            case 36460:
               this.ele_12_sign(5);
               break;
            case 36507:
               this.twl_12_sign(1);
               break;
            case 36508:
               this.twl_12_sign(2);
               break;
            case 36509:
               this.twl_12_sign(3);
               break;
            case 36510:
               this.twl_12_sign(4);
               break;
            case 36511:
               this.twl_12_sign(5);
               break;
            case 36536:
               this.one_2022_sign(1);
               break;
            case 36537:
               this.one_2022_sign(2);
               break;
            case 36538:
               this.one_2022_sign(3);
               break;
            case 36539:
               this.one_2022_sign(4);
               break;
            case 36540:
               this.one_2022_sign(5);
               break;
            case 36575:
            case 37489:
               this.two_23qiandao(1);
               break;
            case 36576:
            case 37490:
               this.two_23qiandao(2);
               break;
            case 36577:
            case 37491:
               this.two_23qiandao(3);
               break;
            case 36578:
            case 37492:
               this.two_23qiandao(4);
               break;
            case 36579:
            case 37493:
               this.two_23qiandao(5);
               break;
            case 36596:
               this.zmgzs1();
               break;
            case 36597:
               this.zmgzs2();
               break;
            case 36684:
               this.four_19qiandao(1);
               break;
            case 36685:
               this.four_19qiandao(2);
               break;
            case 36686:
               this.four_19qiandao(3);
               break;
            case 36687:
               this.four_19qiandao(4);
               break;
            case 36688:
               this.four_19qiandao(5);
               break;
            case 36714:
               this.four_2022_sign(1);
               break;
            case 36715:
               this.four_2022_sign(2);
               break;
            case 36716:
               this.four_2022_sign(3);
               break;
            case 36717:
               this.four_2022_sign(4);
               break;
            case 36718:
               this.four_2022_sign(5);
               break;
            case 36767:
               this.zmgzs1();
               break;
            case 36768:
               this.zmgzs2();
               break;
            case 36772:
               this.yxydjPresent();
               break;
            case 36755:
               this.five_2022_sign(1);
               break;
            case 36756:
               this.five_2022_sign(2);
               break;
            case 36757:
               this.five_2022_sign(3);
               break;
            case 36758:
               this.five_2022_sign(4);
               break;
            case 36759:
               this.five_2022_sign(5);
               break;
            case 36810:
               this.six_19qiandao(1);
               break;
            case 36811:
               this.six_19qiandao(2);
               break;
            case 36812:
               this.six_19qiandao(3);
               break;
            case 36813:
               this.six_19qiandao(4);
               break;
            case 36814:
               this.six_19qiandao(5);
               break;
            case 36835:
               this.seven_12_sign(2);
               break;
            case 36836:
               this.seven_12_sign(3);
               break;
            case 36837:
               this.seven_12_sign(4);
               break;
            case 36838:
               this.seven_12_sign(5);
               break;
            case 36834:
               this.seven_12_sign(1);
               break;
            case 36872:
               this.eight_12_sign(1);
               break;
            case 36873:
               this.eight_12_sign(2);
               break;
            case 36874:
               this.eight_12_sign(3);
               break;
            case 36875:
               this.eight_12_sign(4);
               break;
            case 36876:
               this.eight_12_sign(5);
               break;
            case 36912:
               this.night_12_sign(1);
               break;
            case 36913:
               this.night_12_sign(2);
               break;
            case 36914:
               this.night_12_sign(3);
               break;
            case 36915:
               this.night_12_sign(4);
               break;
            case 36916:
               this.night_12_sign(5);
               break;
            case 37000:
               this.twl_12_sign(1);
               break;
            case 37001:
               this.twl_12_sign(2);
               break;
            case 37002:
               this.twl_12_sign(3);
               break;
            case 37003:
               this.twl_12_sign(4);
               break;
            case 37004:
               this.twl_12_sign(5);
               break;
            case 36994:
               this.ele_12_sign(1);
               break;
            case 36995:
               this.ele_12_sign(2);
               break;
            case 36996:
               this.ele_12_sign(3);
               break;
            case 36997:
               this.ele_12_sign(4);
               break;
            case 36998:
               this.ele_12_sign(5);
               break;
            case 37112:
               this.dragonActivity();
               break;
            case 37113:
               this.dragonActivity2();
               break;
            case 37208:
               this.zaomPresent13();
               break;
            case 37273:
            case 37602:
               this.seven_19qiandao(1);
               break;
            case 37274:
            case 37603:
               this.seven_19qiandao(2);
               break;
            case 37275:
            case 37604:
               this.seven_19qiandao(3);
               break;
            case 37276:
            case 37605:
               this.seven_19qiandao(4);
               break;
            case 37277:
            case 37606:
               this.seven_19qiandao(5);
               break;
            case 37278:
               this.eight_12_sign(1);
               break;
            case 37279:
               this.eight_12_sign(2);
               break;
            case 37280:
               this.eight_12_sign(3);
               break;
            case 37281:
               this.eight_12_sign(4);
               break;
            case 37282:
               this.eight_12_sign(5);
               break;
            case 37283:
               this.night_12_sign(1);
               break;
            case 37284:
               this.night_12_sign(2);
               break;
            case 37285:
               this.night_12_sign(3);
               break;
            case 37286:
               this.night_12_sign(4);
               break;
            case 37287:
               this.night_12_sign(5);
               break;
            case 37373:
               this.ten_22qiandao(1);
               break;
            case 37374:
               this.ten_22qiandao(2);
               break;
            case 37375:
               this.ten_22qiandao(3);
               break;
            case 37376:
               this.ten_22qiandao(4);
               break;
            case 37377:
               this.ten_22qiandao(5);
               break;
            case 37453:
               this.one_2022_sign(1);
               break;
            case 37454:
               this.one_2022_sign(2);
               break;
            case 37455:
               this.one_2022_sign(3);
               break;
            case 37456:
               this.one_2022_sign(4);
               break;
            case 37457:
               this.one_2022_sign(5);
               break;
            case 37458:
               this.ten_18qiandao(1);
               break;
            case 37459:
               this.ten_22qiandao(2);
               break;
            case 37460:
               this.ten_22qiandao(3);
               break;
            case 37461:
               this.ele_12_sign(1);
               break;
            case 37462:
               this.twl_12_sign(2);
               break;
            case 37463:
               this.ele_12_sign(3);
               break;
            case 37487:
               this.ysYearPresent1();
               break;
            case 37488:
               this.ysYearPresent2();
               break;
            case 37494:
               this.newYearRandom2052(1);
               break;
            case 37495:
               this.newYearRandom2052(2);
               break;
            case 37496:
               this.newYearRandom2052(3);
               break;
            case 37497:
               this.newYearRandom2052(4);
               break;
            case 37498:
               this.newYearRandom2052(5);
               break;
            case 37499:
               this.newYearRandom2052(6);
               break;
            case 37533:
               this.presentGift2025(1);
               break;
            case 37534:
               this.presentGift2025(2);
               break;
            case 37535:
               this.presentGift2025(3);
               break;
            case 37536:
               this.presentGift2025(4);
               break;
            case 37537:
               this.presentGift2025(5);
               break;
            case 37538:
               this.presentGift2025(6);
               break;
            case 37594:
               this.zaomPresent14();
               break;
            case 37724:
               this.zmLiandongPresent(1);
               break;
            case 37725:
               this.zmLiandongPresent(2);
               break;
            case 37726:
               this.zmLiandongPresent(3);
               break;
            case 37727:
               this.zmLiandongPresent(4);
         }
      }
      
      private function zmLiandongPresent(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"rls",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"rls",1);
               }
               gc.ts.setTxt("成功领取 熔炼石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getMousePet2());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getMousePet2());
               }
               gc.ts.setTxt("成功领取 子鼠元帅x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player1,"wpst_5",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player2,"wpst_5",1);
               }
               gc.ts.setTxt("成功领取 子鼠精灵 x1、五重神铁x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function presentGift2025(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wptlz",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wptlz",1);
               }
               gc.ts.setTxt("成功领取 土灵珠x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
               }
               gc.ts.setTxt("成功领取 3级强化石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"mfs2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"mfs2",1);
               }
               gc.ts.setTxt("成功领取 2级魔法石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"mpyj",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"mpyj",1);
               }
               gc.ts.setTxt("成功领取 孟婆药剂x1");
               gc.stage.addChild(gc.ts);
               break;
            case 5:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 天庭战神装x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function newYearRandom2052(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
               }
               gc.ts.setTxt("成功领取 风灵珠x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
               }
               gc.ts.setTxt("成功领取 3级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 足球x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
               }
               gc.ts.setTxt("成功领取 2级防御石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
               }
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               gc.stage.addChild(gc.ts);
               break;
            case 5:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 神秘商人装x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      protected function zaomPresent13() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getYHPet());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyyhjl"));
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getYHPet());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyyhjl"));
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
         }
         gc.ts.setTxt("成功领取 寅虎元帅x1、寅虎精灵x1、2级攻击石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function zaomPresent14() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_5",1);
            gc.putQhsInBackPack(gc.player1,"wpst_5",1);
            gc.putQhsInBackPack(gc.player1,"kly4",1);
            gc.putQhsInBackPack(gc.player1,"xns4",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpsh_5",1);
            gc.putQhsInBackPack(gc.player2,"wpst_5",1);
            gc.putQhsInBackPack(gc.player2,"kly4",1);
            gc.putQhsInBackPack(gc.player2,"xns4",1);
         }
         gc.ts.setTxt("成功领取 五重神火x1、五重神铁x1、4级昆仑玉x1、4级仙女石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function dragonActivity() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
         }
         gc.ts.setTxt("成功领取 1级仙女石x1、孟婆药剂x1、大灵魂药水x1、龟丞相的遗言x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function dragonActivity2() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、龙女的眼泪x3、2级生命石x1、4399忠实玩家头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function yxydjPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            equip = gc.allEquip.findByName("_4399ptsjwj");
            gc.player1.zblist.push(equip);
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gc.putQhsInBackPack(gc.player1,"fys2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            equip = gc.allEquip.findByName("_4399ptsjwj");
            gc.player2.zblist.push(equip);
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gc.putQhsInBackPack(gc.player2,"fys2",1);
         }
         gc.ts.setTxt("成功领取 风灵珠x1、慈心妙莲x1、4399手机玩家头衔x1、二级防御石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function zmgzs1() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
         }
         gc.ts.setTxt("成功领取 药王葫芦x1、大灵魂药水x1、一级仙女石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function zmgzs2() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"kly2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"kly2",1);
         }
         gc.ts.setTxt("成功领取 土灵珠x1、孟婆药剂x1、二级昆仑玉x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function two_23qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player1,"nianjhdd",1);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  gc.player1.petsAry.push(this.getNianPet1());
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player2,"nianjhdd",1);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  gc.player2.petsAry.push(this.getNianPet1());
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 年兽进化大丹x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 天庭战神时装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 年兽宠物x1、年兽精灵x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function ten_22qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getNeatPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"wpst_5",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getNeatPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"wpst_5",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 丑牛元帅x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 五重神铁x1、牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function five_2022_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"kly2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"kly2",1);
               }
               gc.ts.setTxt("成功领取 2级昆仑玉x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpflz",1);
               }
               gc.ts.setTxt("成功领取  风灵珠x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getMousePet2());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getMousePet2());
               }
               gc.ts.setTxt("成功领取 子鼠元帅x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpst_5",1);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpst_5",1);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
               }
               gc.ts.setTxt("成功领取 钢石精灵 x1、5重神铁x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function four_2022_sign(type:int) : void
      {
         var gcxdyy:* = null;
         var eq:MyEquipObj = null;
         eq = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
               }
               gc.ts.setTxt("成功领取 2级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
               }
               gc.ts.setTxt("成功领取 4级强化石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  eq = gc.allEquip.findByName("zlwdah");
                  gc.player1.zblist.push(eq);
               }
               if(gc.player2.roleid > 0)
               {
                  eq = gc.allEquip.findByName("zlwdah");
                  gc.player2.zblist.push(eq);
               }
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
               }
               gc.ts.setTxt("成功领取 四重神火 x1、双倍经验丹x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function one_2022_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 乱世英雄头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpygs",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpygs",1);
               }
               gc.ts.setTxt("成功领取 摇光石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getYHPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getYHPet());
               }
               gc.ts.setTxt("成功领取 寅虎宝宝x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyyhjl"));
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyyhjl"));
               }
               gc.ts.setTxt("成功领取 牛魔王时装 x1、寅虎精灵x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function shizhounianzz(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"mpyj",1);
                  gc.putQhsInBackPack(gc.player1,"mfs2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"mpyj",1);
                  gc.putQhsInBackPack(gc.player2,"mfs2",1);
               }
               gc.ts.setTxt("成功领取 孟婆药剂x1、二级魔法石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
               }
               gc.ts.setTxt("成功领取  3级强化石x1、镇魂玉箫x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.petsAry.push(this.getJPQLPet());
                  gc.putQhsInBackPack(gc.player1,"wpst_3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.petsAry.push(this.getJPQLPet());
                  gc.putQhsInBackPack(gc.player2,"wpst_3",1);
               }
               gc.ts.setTxt("成功领取 三重神铁x1、青龙宝宝x1、牛魔王时装x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function may_2021_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"kly2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"kly2",1);
               }
               gc.ts.setTxt("成功领取 2级昆仑玉x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpflz",1);
               }
               gc.ts.setTxt("成功领取  风灵珠x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 地魁花篮x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
               }
               gc.ts.setTxt("成功领取 玄武宝宝x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
               }
               gc.ts.setTxt("成功领取 钢石精灵 x1、转轮王时装x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function one_2021_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 乱世英雄头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpygs",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpygs",1);
               }
               gc.ts.setTxt("成功领取 摇光石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 子鼠精灵x1、转轮王时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getMousePet2());
                  gc.player1.zblist.push(gc.allEquip.findByName("_ssggjtg"));
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getMousePet2());
                  gc.player2.zblist.push(gc.allEquip.findByName("_ssggjtg"));
               }
               gc.ts.setTxt("成功领取 光棍节头衔 x1、子鼠元帅x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function twl_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"rls",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"rls",1);
               }
               gc.ts.setTxt("成功领取 熔炼石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 神秘商人装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  gc.putQhsInBackPack(gc.player1,"wpbdf",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  gc.putQhsInBackPack(gc.player2,"wpbdf",1);
               }
               gc.ts.setTxt("成功领取 丑牛精灵 x1、神恩符x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function ele_12_sign(type:int) : void
      {
         var gcxdyy:* = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
               }
               gc.ts.setTxt("成功领取 4级强化石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getYTPet2());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getYTPet2());
               }
               gc.ts.setTxt("成功领取 极品月兔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
               }
               gc.ts.setTxt("成功领取 四重神火 x1、双倍经验丹x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function ten_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"rls",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"rls",1);
               }
               gc.ts.setTxt("成功领取 熔炼石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpbdf",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpbdf",1);
               }
               gc.ts.setTxt("成功领取 神恩符x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 丑牛精灵 x1、牛魔王时装x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function night_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
               }
               gc.ts.setTxt("成功领取 2级防御石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
               }
               gc.ts.setTxt("成功领取 3级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
                  gc.player1.petsAry.push(this.getJPQLPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
                  gc.player2.petsAry.push(this.getJPQLPet());
               }
               gc.ts.setTxt("成功领取 青龙宝宝 x1、双倍经验丹x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function eight_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
               }
               gc.ts.setTxt("成功领取 2级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
               }
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"tss",1);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"tss",1);
               }
               gc.ts.setTxt("成功领取 神秘商人装x1、天枢石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
               }
               gc.ts.setTxt("成功领取 玄武宝宝 x1、三重神火x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function seven_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpflz",1);
               }
               gc.ts.setTxt("成功领取 风灵珠x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"rls",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"rls",1);
               }
               gc.ts.setTxt("成功领取 熔炼石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"sxzhs",1);
                  gc.player1.petsAry.push(this.getMousePet2());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"sxzhs",1);
                  gc.player2.petsAry.push(this.getMousePet2());
               }
               gc.ts.setTxt("成功领取 沙邪转换石x1、子鼠元帅x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player1,"wpst_5",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player2,"wpst_5",1);
               }
               gc.ts.setTxt("成功领取 子鼠精灵 x1、五重神铁x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function six_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
               }
               gc.ts.setTxt("成功领取 2级防御石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
               }
               gc.ts.setTxt("成功领取 3级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
               }
               gc.ts.setTxt("成功领取 玄武宝宝 x1、双倍经验丹x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function may_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
               }
               gc.ts.setTxt("成功领取 2级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
               }
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"tss",1);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"tss",1);
               }
               gc.ts.setTxt("成功领取 神秘商人装x1、天枢石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
                  gc.player1.petsAry.push(this.getJPQLPet());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
                  gc.player2.petsAry.push(this.getJPQLPet());
               }
               gc.ts.setTxt("成功领取 青龙宝宝 x1、三重神火x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function april_12_sign(type:int) : void
      {
         var gcxdyy:* = null;
         var eq:MyEquipObj = null;
         eq = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
               }
               gc.ts.setTxt("成功领取 2级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
               }
               gc.ts.setTxt("成功领取 4级强化石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  eq = gc.allEquip.findByName("zlwdah");
                  gc.player1.zblist.push(eq);
               }
               if(gc.player2.roleid > 0)
               {
                  eq = gc.allEquip.findByName("zlwdah");
                  gc.player2.zblist.push(eq);
               }
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
               }
               gc.ts.setTxt("成功领取 四重神火x1、双倍经验丹x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function mar_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
               }
               gc.ts.setTxt("成功领取 3级仙女石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 法宝足球x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 转轮王时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpst_4",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpst_4",1);
               }
               gc.ts.setTxt("成功领取 四重神铁x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function feb_12_sign(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
               }
               gc.ts.setTxt("成功领取 2级攻击石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
               }
               gc.ts.setTxt("成功领取 3级强化石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"nianjhdd",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"nianjhdd",1);
               }
               gc.ts.setTxt("成功领取 年兽进化大丹x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 天庭战神时装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.petsAry.push(this.getNianPet1());
                  gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.petsAry.push(this.getNianPet1());
                  gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
               }
               gc.ts.setTxt("成功领取 年兽x1、年兽精灵x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function mon_12_sign(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         switch(type - 1)
         {
            case 0:
               if(gc.player1.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
               }
               if(gc.player2.roleid > 0)
               {
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
               }
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               gc.stage.addChild(gc.ts);
               break;
            case 1:
               if(gc.player1.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player1,"rls",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.putQhsInBackPack(gc.player2,"rls",1);
               }
               gc.ts.setTxt("成功领取 熔炼石x1");
               gc.stage.addChild(gc.ts);
               break;
            case 2:
               if(gc.player1.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
               }
               if(gc.player2.roleid > 0)
               {
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
               }
               gc.ts.setTxt("成功领取 2.4金木宣花红葫芦x1");
               gc.stage.addChild(gc.ts);
               break;
            case 3:
               if(gc.player1.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
               }
               if(gc.player2.roleid > 0)
               {
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
               }
               gc.ts.setTxt("成功领取 神秘商人装x1");
               gc.stage.addChild(gc.ts);
               break;
            case 4:
               if(gc.player1.roleid > 0)
               {
                  gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  gc.putQhsInBackPack(gc.player1,"wpbdf",1);
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
                  gc.putQhsInBackPack(gc.player2,"wpbdf",1);
               }
               gc.ts.setTxt("成功领取 丑牛精灵x1＋神恩符x1");
               gc.stage.addChild(gc.ts);
         }
      }
      
      protected function ele_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级仙女石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 神秘商人装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function ele_19qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 月兔宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 四重神火x1、双倍经验丹x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function ten_19qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 2:
                  gc.player1.zblist.push(this.getZjEquip(false));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player1.petsAry.push(this.getYTPet2());
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 2:
                  gc.player2.zblist.push(this.getZjEquip(false));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player2.petsAry.push(this.getYTPet2());
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级防御石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 紫金铃铛x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 月兔宝宝x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function ten_19Zq(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 2:
                  gc.player1.zblist.push(this.getZjEquip(false));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 2:
                  gc.player2.zblist.push(this.getZjEquip(false));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级防御石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 紫金铃铛x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function night_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player1.petsAry.push(this.getJPQLPet());
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player2.petsAry.push(this.getJPQLPet());
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级防御石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 双倍经验丹x1、青龙宝宝x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function night_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"mpyj",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"mpyj",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 孟婆药剂x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 神行渔鼓x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function eight_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"tss",1);
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
                  gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"tss",1);
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
                  gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级仙女石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 天枢石x1、神秘商人装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 三重神火x1、玄武宝宝x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function eight_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 玄武宝宝x1、3级昆仑玉x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function seven_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
                  gc.putQhsInBackPack(gc.player1,"wpxt",3);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getYTPet());
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
                  gc.putQhsInBackPack(gc.player2,"wpxt",3);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getYTPet());
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级防御石x1、玄铁x3");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 月兔宝宝x1、双倍经验丹x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function seven_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"rls",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"sxzhs",1);
                  gc.player1.petsAry.push(this.getMousePet2());
                  break;
               case 4:
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player1,"wpst_5",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpflz",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"rls",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"sxzhs",1);
                  gc.player2.petsAry.push(this.getMousePet2());
                  break;
               case 4:
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  gc.putQhsInBackPack(gc.player2,"wpst_5",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 风灵珠x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 熔炼石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 沙邪转换石x1、子鼠元帅x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 子鼠精灵x1、五重神铁x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function six_19qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
                  gc.player1.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"lxzhs",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
                  gc.player2.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"lxzhs",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 月兔x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王的怒吼x1、双倍经验丹x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 天庭战神时装x1、流邪转换石x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function six_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns1",1);
                  gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns1",1);
                  gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 1级仙女石x1、龙女的眼泪x3");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 玄武宝宝x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function five_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpqhs1",3);
                  gc.putQhsInBackPack(gc.player1,"dlhys",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getJPQLPet());
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpqhs1",3);
                  gc.putQhsInBackPack(gc.player2,"dlhys",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getJPQLPet());
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 1级强化石x1、大灵魂药水x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 地魁花篮x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 青龙宝宝x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function five_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"sms2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"sms2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 二级生命石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 玄武宝宝x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 转轮王时装x1、钢石精灵x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function one_19Zq(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
                  gc.putQhsInBackPack(gc.player1,"sms1",1);
                  break;
               case 1:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player1.zblist.push(equip);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
                  gc.putQhsInBackPack(gc.player2,"sms1",1);
                  break;
               case 1:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player2.zblist.push(equip);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("hyzzs");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 龙女的眼泪x3、1级生命石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 混元珍珠伞x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function four_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player1,"wpst_4",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_4399ptsjwj");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player2,"wpst_4",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 法宝足球x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 四重神铁x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function three_19qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"gjs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player1,"wpxyf",1);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"lxfs_3",1);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"gjs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player2,"wpxyf",1);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"lxfs_3",1);
                  break;
               case 4:
                  gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 乱世英雄x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级攻击石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 幸运符x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 流邪符石3x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 四重神火x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function zhuoquPresent() : *
      {
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player1.zblist.push(equip);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player2.zblist.push(equip);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、双倍经验丹x1、孟婆药剂x1、乱世英雄头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function two_19qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player1,"nianjhdd",1);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzqsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  break;
               case 4:
                  gc.player1.petsAry.push(this.getNianPet1());
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player2,"nianjhdd",1);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzqsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
                  break;
               case 4:
                  gc.player2.petsAry.push(this.getNianPet1());
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 年兽进化大丹x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 中秋时装x1、年兽精灵x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 年兽宠物x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function one_19qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpygs",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  break;
               case 4:
                  gc.player1.petsAry.push(this.getMousePet2());
                  gc.player1.zblist.push(gc.allEquip.findByName("_ssggjtg"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpygs",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
                  break;
               case 4:
                  gc.player2.petsAry.push(this.getMousePet2());
                  gc.player2.zblist.push(gc.allEquip.findByName("_ssggjtg"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 乱世英雄x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 摇光石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取  转轮王的哀嚎x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1、子鼠精灵x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 光棍节头衔x1、子鼠元帅x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function kuainian2019() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",6);
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",6);
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         gc.ts.setTxt("成功领取 2级生命石x1、龙女的眼泪x6、双倍经验丹x1、地魁花篮x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tew_18qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpqhs4",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
                  gc.player1.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpqhs4",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getYTPet2());
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
                  gc.player2.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4级强化石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 月兔x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王的怒吼x1、双倍经验丹x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 年兽进化丹x1、天庭战神时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function thanksGivenDay2018() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、龙女的眼泪x3、1级生命石x1、火灵珠x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function ele_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.player1.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"wpxyf",1);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"lxzhs",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.player2.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("bxzq");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"wpxyf",1);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"lxzhs",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 4399手机玩家头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 足球x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 幸运符x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 流邪转换石x1、神秘商人装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function weixinPresent20180927() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player1,"sms1",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player2,"sms1",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
         }
         gc.ts.setTxt("成功领取 玄风棕扇x1、龙女的眼泪x3、1级生命石x1、火灵珠x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function ten_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"rls",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player1,"wpbdf",1);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"rls",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("xhhhl");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.putQhsInBackPack(gc.player2,"wpbdf",1);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 熔炼石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 宣花红葫芦x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 神恩符x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 丑牛精灵x1、转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function night_18qiandao(type:int) : void
      {
         var gcxdyy:* = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"rls",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 3:
                  gc.player1.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"rls",1);
                  break;
               case 2:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 3:
                  gc.player2.zblist.push(this.getNMWEquip(true));
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 乱世英雄头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 熔炼石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王的怒吼x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 年兽进化丹x1、牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function weixinchongzhi() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player1,"sms1",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player2,"sms1",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、龙女的眼泪x3、1级生命石x1、4399忠实玩家头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function xiarijiActivity() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"xns2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"xns2",1);
         }
         gc.ts.setTxt("成功领取 2级仙女石x1、孟婆药剂x1、大灵魂药水x1、龟丞相的遗言x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya171() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝x1、药王葫芦x1、土灵珠x1、孟婆药剂x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function eight_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"kly3",1);
                  break;
               case 1:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getNeatPet2());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("qljfb");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzqsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"kly3",1);
                  break;
               case 1:
                  equip = gc.allEquip.findByName("_jsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getNeatPet2());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("qljfb");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzqsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 3级昆仑玉x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 救世英雄头衔x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 丑牛x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 青龙剑x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 丑牛精灵x1、中秋时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function seven_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpygs",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpst_3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getMousePet2());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpygs",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpst_3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getMousePet2());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 摇光石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 三重神铁x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 镇魂玉箫x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 子鼠元帅x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 子鼠精灵x1、牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function six_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
                  break;
               case 1:
                  gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getBhPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("yxsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cybxjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
                  break;
               case 1:
                  gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getBhPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("yxsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cybxjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级仙女石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 4399忠实玩家头衔x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 神行渔鼓x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 白虎宝宝x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 冰雪精灵x1、优秀神秘商人装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function five_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"kly2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpflz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"kly2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpflz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级昆仑玉x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 风灵珠x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 地魁花篮x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 玄武宝宝x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 钢石精灵x1、转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function weiXinBigPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 慈心秒莲x1、大灵魂药水x1、1级仙女石x1、1级强化石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya169() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yjp");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yjp");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、玉净瓶x1、雷灵珠x1、救世星宿头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya168() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399ptsjwj"));
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、慈心秒莲x1、轮转王时装x1、4399手机玩家头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function four_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wphlz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("yjp");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getYHPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyyhjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wphlz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("yjp");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getYHPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyyhjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级仙女石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 火灵珠x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 玉净瓶x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 寅虎宝宝x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 寅虎精灵x1、牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function dregonBigPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 慈心秒莲x1、孟婆药剂x1、3级魔法石x1、1级仙女石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya167() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、镇魂玉箫x1、3级攻击石x1、4399忠实玩家头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function weiXinChongZhiPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
         }
         gc.ts.setTxt("成功领取 大灵魂药水x1、3级魔法石x1、1级仙女石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function haiMianBaoBaoPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 大灵魂药水x1、火灵珠x1、混元珍珠伞x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function three_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"mpyj",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wptlz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player1.petsAry.push(this.getYMPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("yxsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"mpyj",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wptlz",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("zhyx");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gc.player2.petsAry.push(this.getYMPet());
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("yxsmsrsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 孟婆药剂x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 土灵珠x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 镇魂玉箫x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 炎马宝宝x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 炎马精灵x1、优秀神秘商人时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function zmDwjPresent1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
         }
         gc.ts.setTxt("成功领取 大灵魂药水x1、孟婆药剂x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function zmDwjPresent2() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 3级魔法石x1、混元珍珠伞x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function zmDwjPresent3() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、3级强化石x1、3级仙女石x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya166() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmszntx"));
            gc.player1.petsAry.push(this.getBhPet3());
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmszntx"));
            gc.player2.petsAry.push(this.getBhPet3());
         }
         gc.ts.setTxt("成功领取 虎丸宝宝x1、药王葫芦x1、周年头衔x1、牛魔王时装x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function two_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"sbjyd",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"mfs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptzlwsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"sbjyd",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"mfs3",1);
                  break;
               case 2:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("zlwdah");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":true,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptzlwsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 双倍经验丹x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级魔法石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 阴阳斩龙剑x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 牛魔王时装x1、转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function weiXinLiaomeiPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"lhys",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"lhys",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 火灵珠x1、孟婆药剂x1、灵魂药水x1、1级强化石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function youNeiHanHJPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、慈心妙莲x1、大灵魂药水x1、土灵珠x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function doulaamengPrensent() : void
      {
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(eq2);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2018"));
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
         }
         if(gc.player2.roleid > 0)
         {
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(eq2);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2018"));
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
         }
         gc.ts.setTxt("成功领取 转轮王的哀嚎x1、孟婆药剂x1、新年快乐头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function one_18qiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"sms2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"gjs3",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getYHPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("qljfb");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptttzssz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"sms2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"gjs3",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getYHPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("qljfb");
                  gcxdyy.setEupdata(2.4);
                  gcxdyy.setWX({
                     "jin":false,
                     "mu":true,
                     "shui":false,
                     "huo":false,
                     "tu":false
                  });
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptttzssz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级生命石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级攻击石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 寅虎宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 法宝青龙剑x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 牛魔王时装x1、天庭战神时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya164() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2018"));
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2018"));
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、药王葫芦x1、新年快乐头衔x1、转轮王时装x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function diaoyuPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player1.petsAry.push(this.getYMPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player2.petsAry.push(this.getYMPet());
         }
         gc.ts.setTxt("成功领取 炎马宝宝x1、炎马精灵x1、混元珍珠伞x1、3级昆仑玉x1、3级仙女石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function twelveMonthqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"mfs3",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getNianPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("gcxdyy");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"mfs3",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getNianPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("gcxdyy");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级魔法石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 年兽宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 龟丞相的遗言x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 牛魔王时装x1、神秘商人时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya162() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var temp:MyEquipObj = null;
         nmwsz = null;
         temp = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            temp = gc.allEquip.findByName("_4399zswj");
            gc.player1.zblist.push(temp);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            temp = gc.allEquip.findByName("_4399zswj");
            gc.player2.zblist.push(temp);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、药王葫芦x1、忠实玩家头衔x1、优秀神秘商人装x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function double11Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         var gcxdyy2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gcxdyy2 = gc.allEquip.findByName("_4399ptsjwj");
            gc.player1.zblist.push(gcxdyy2);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gcxdyy2 = gc.allEquip.findByName("_4399ptsjwj");
            gc.player2.zblist.push(gcxdyy2);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、阴阳斩龙剑x1、3级强化石x1、4399手机玩家头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function wangshengjiePresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var myEquip:MyEquipObj = null;
         var equip:MyEquipObj = null;
         myEquip = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            equip = gc.allEquip.findByName("_yxwsjkh");
            gc.player1.zblist.push(equip);
            gc.player1.zblist.push(gc.allEquip.findByName("zhhz"));
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            equip = gc.allEquip.findByName("_yxwsjkh");
            gc.player2.zblist.push(equip);
            gc.player2.zblist.push(gc.allEquip.findByName("zhhz"));
         }
         gc.ts.setTxt("成功领取 万圣节狂欢头衔x1、龟丞相的遗言x1、镇魂花坠x1、精良神秘商人装x1",2.5,18);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya161() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、阴阳斩龙剑x1、3级强化石x1、3级魔法石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function eleventMonthqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"mfs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"fys3",1);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("yyb");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"mfs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"fys3",1);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("yyb");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级魔法石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级防御石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 青龙宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 云阳板x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 转轮王时装x1、神秘商人时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya160() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、龟丞相的遗言x1、三重神火x1、三重神铁x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function shumabaolongPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var myEquip:MyEquipObj = null;
         myEquip = null;
         if(gc.player1.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝x1、混元珍珠伞x1、周年头衔x1、神秘商人装x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function huahaoyueyuanPresent() : void
      {
         var myEquip:MyEquipObj = null;
         myEquip = null;
         if(gc.player1.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
            gc.player1.petsAry.push(this.getYTPet2());
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("jlsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
            gc.player2.petsAry.push(this.getYTPet2());
         }
         gc.ts.setTxt("成功领取 月兔宝宝x1、神秘商人时装x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function chongxiaoPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getUFOPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getUFOPet());
         }
         gc.ts.setTxt("成功领取 小飞宝宝x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tenMonthqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"xns3",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"wpygs",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_yxwsjkh");
                  gc.player1.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"xns3",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"wpygs",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_yxwsjkh");
                  gc.player2.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 3级仙女石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 摇光石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 万圣节狂欢头衔x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 神行渔鼓x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 牛魔王时装x1、神秘商人时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function bbbtxPresent() : void
      {
         var myEquip:MyEquipObj = null;
         myEquip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            myEquip = gc.allEquip.findByName("ptsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player1.petsAry.push(this.getYMPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            myEquip = gc.allEquip.findByName("ptsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player2.petsAry.push(this.getYMPet());
         }
         gc.ts.setTxt("成功领取 炎马宝宝x1、炎马精灵x1、普通神秘商人时装x1、大灵魂药水x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function nightMonthqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"mfs3",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player1.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"mfs3",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_lsyxpt");
                  gc.player2.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptsmsrsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级魔法石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 乱世英雄头衔x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 药王葫芦x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 转轮王时装x1、神秘商人时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function weixinNeiHan() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"lhys",1);
            gc.putQhsInBackPack(gc.player1,"jyys",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"lhys",1);
            gc.putQhsInBackPack(gc.player2,"jyys",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、药王葫芦x1、灵魂药水x1、经验药水x1、孟婆药剂x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya158() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getNianPet1());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getNianPet1());
         }
         gc.ts.setTxt("成功领取 年兽宝宝x1、混元珍珠伞x1、双倍经验丹x1、摇光石x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function catchSpritePresent() : void
      {
         var fabao:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         fabao = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            fabao = gc.allEquip.findByName("gcxdyy");
            fabao.setEupdata(2.4);
            gc.player1.zblist.push(fabao);
            gc.player1.plist.push(gc.allEquip.findByName("p_cybxjl"));
            gc.player1.petsAry.push(this.getBhPet());
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            fabao = gc.allEquip.findByName("gcxdyy");
            fabao.setEupdata(2.4);
            gc.player1.zblist.push(fabao);
            gc.player2.plist.push(gc.allEquip.findByName("p_cybxjl"));
            gc.player2.petsAry.push(this.getBhPet());
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1，冰雪精灵x1，龟丞相的遗言x1，牛魔王时装x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function one_eightqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         equip = null;
         nmwsz = null;
         nmwsz2 = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player1,"gjs3",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_sryxyx");
                  gc.player1.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptnmwsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz2);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
                  break;
               case 1:
                  gc.putQhsInBackPack(gc.player2,"gjs3",1);
                  break;
               case 2:
                  equip = gc.allEquip.findByName("_sryxyx");
                  gc.player2.zblist.push(equip);
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 4:
                  nmwsz = gc.allEquip.findByName("ptzlwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
                  nmwsz2 = gc.allEquip.findByName("ptnmwsz");
                  nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz2);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级强化石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 3级攻击石x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 射日英雄头衔x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 阴阳斩龙剑x1");
               break;
            case 4:
               gc.ts.setTxt("成功领取 转轮王时装x1、牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function yxhdzzPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player1.petsAry.push(this.getYMPet());
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player2.petsAry.push(this.getYMPet());
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 转轮王时装x1、炎马宝宝x1、炎马精灵x1、阴阳斩龙剑x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao7yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
         }
         gc.ts.setTxt("成功领取 孟婆药剂x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao7yue2017_5() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
         }
         gc.ts.setTxt("成功领取 3级魔法石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao7yue2017_14() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玄风棕扇x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao7yue2017_25() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao7yue2017_30() : void
      {
         this.cangjinggePresent5();
      }
      
      protected function aoTeManPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJPZQPet());
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJPZQPet());
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_ptjsxstx"));
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1、大灵魂药水X1、镇魂玉箫X1、救世星宿头衔X1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya155() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("bxzq");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet());
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("bxzq");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet());
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、神秘商人时装x1、土灵珠x1、足球x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function shenlongPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1、龙王令X1、龙女的眼泪X10、阴阳斩龙剑X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao6yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly3",1);
         }
         gc.ts.setTxt("成功领取 3级昆仑玉X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao6yue2017_5() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
         }
         gc.ts.setTxt("成功领取 三重神铁·点金X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao6yue2017_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao6yue2017_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 转轮王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao6yue2017_30() : void
      {
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(eq2);
         }
         if(gc.player2.roleid > 0)
         {
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(eq2);
         }
         gc.ts.setTxt("成功领取 转轮王的哀嚎X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya154() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、3级攻击石x1、火灵珠x1、龟丞相的遗言x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao5yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns2",1);
         }
         gc.ts.setTxt("成功领取 2级仙女石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao5yue2017_5() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
         }
         gc.ts.setTxt("成功领取 三重神火·洪荒X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao5yue2017_14() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 龟丞相的遗言X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao5yue2017_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 牛魔王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao5yue2017_30() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNianPet1());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNianPet1());
         }
         gc.ts.setTxt("成功领取 年兽宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya153() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝x1、3级魔法石x1、水灵珠x1、云阳板x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya152() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"sms3",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"sms3",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、3级生命石x1、土灵珠x1、镇魂玉箫x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao4yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly2",1);
         }
         gc.ts.setTxt("成功领取 2级昆仑玉X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao4yue2017_5() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
         }
         gc.ts.setTxt("成功领取 3级强化石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao4yue2017_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao4yue2017_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 天庭战神时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao4yue2017_30() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 青龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya151() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、3级攻击石x1、风灵珠x1、玄风棕扇x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function weiChatCbtPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"fys2",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player1.zblist.push(equip2);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"fys2",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player2.zblist.push(equip2);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝x1、水灵珠x1、2级防御石x1、山河社稷图x1、混元珍珠伞x1",2.5,18);
         gc.stage.addChild(gc.ts);
      }
      
      protected function bibaboTogetherPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、混元珍珠伞x1、大灵魂药水x1、周年头衔x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya150() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player1.petsAry.push(this.getYMPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.player2.petsAry.push(this.getYMPet());
         }
         gc.ts.setTxt("成功领取 炎马宝宝x1、炎马精灵x1、阴阳斩龙剑x1、火灵珠x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya149() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔x1、3级昆仑玉x1、3级仙女石x1、玄武宝宝x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao3yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
         }
         gc.ts.setTxt("成功领取 大灵魂药水X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao3yue2017_5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 慈心妙莲X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao3yue2017_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao3yue2017_25() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 普通转轮王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya148() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"lhys",10);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"lhys",10);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 孟婆药剂x1、灵魂药水x10、朱雀宝宝x1、混元珍珠伞x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            gc.putQhsInBackPack(gc.player1,"nianqld",1);
            gc.putQhsInBackPack(gc.player1,"xnhdl",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2017"));
            gc.player1.petsAry.push(this.getNianPet3());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            gc.putQhsInBackPack(gc.player2,"nianqld",1);
            gc.putQhsInBackPack(gc.player2,"xnhdl",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyptxnkl2017"));
            gc.player2.petsAry.push(this.getNianPet3());
         }
         gc.ts.setTxt("成功领取 年兽宝宝X1、年兽进化丹X1、年兽潜力丹X1、新年红灯笼X1、新年快乐头衔X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya147() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("clj");
            gc.player1.zblist.push(gcxdyy);
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("clj");
            gc.player2.zblist.push(gcxdyy);
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 牛魔王时装X1、青龙宝宝X1、法宝龟丞相的遗言X1 、苍龙戒X1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya146() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"lhys",10);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"lhys",10);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 水灵珠x1、灵魂药水x10、白虎宝宝x1、阴阳斩龙剑x1",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao1yue2017_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
         }
         gc.ts.setTxt("成功领取 2级强化石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao1yue2017_5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 神行渔鼓X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao1yue2017_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 白虎宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function qiandao1yue2017_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 天庭战神时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function doubleEgePresent2017() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpygs",10);
            gc.putQhsInBackPack(gc.player1,"wpxt",999);
            nmwsz = gc.allEquip.findByName("jlsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("yjp");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("clj"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpygs",10);
            gc.putQhsInBackPack(gc.player2,"wpxt",999);
            nmwsz = gc.allEquip.findByName("jlsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gcxdyy = gc.allEquip.findByName("yjp");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("clj"));
         }
         gc.ts.setTxt("成功领取 神秘商人时装x1、苍龙戒x1、玉净瓶x1、摇光石x10、玄铁x999",2.5,20);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya145() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 3级仙女石X1，3级昆仑玉X1，风灵珠X1，镇魂玉箫X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao12yue2016_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
         }
         gc.ts.setTxt("成功领取 2级魔法石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao12yue2016_5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 云阳板X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao12yue2016_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao12yue2016_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 牛魔王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya144() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cylhjl"));
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cylhjl"));
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1，烈火精灵X1，火灵珠X1，熔炼石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya143() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"lhys",10);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"lhys",10);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玄武宝宝X1，长生丹X1，灵魂药水X10，玄风棕扇X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao11yue2016_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao11yue2016_5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao11yue2016_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao11yue2016_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 转轮王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya142() : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip2:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getYMPet());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gcxdyy = gc.allEquip.findByName("qyj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getYMPet());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gcxdyy = gc.allEquip.findByName("qyj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 炎马宝宝X1，炎马精灵X1，青云剑X1，优秀神秘商人时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya141() : void
      {
         var gcxdyy:MyEquipObj = null;
         var equip2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getQLPet());
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player1.zblist.push(equip2);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.plist.push(gc.allEquip.findByName("p_cykljl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getQLPet());
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player2.zblist.push(equip2);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.plist.push(gc.allEquip.findByName("p_cykljl"));
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1，狂雷精灵X1，混元珍珠伞X1，山河社稷图X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao10yue2016_1() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玄风棕扇X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao10yue2016_5() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
         }
         gc.ts.setTxt("成功领取 风灵珠X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao10yue2016_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao10yue2016_25() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 牛魔王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya140() : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"lhys",10);
            gc.player1.petsAry.push(this.getBhPet2());
            gc.player1.plist.push(gc.allEquip.findByName("p_cybxjl"));
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"lhys",10);
            gc.player2.petsAry.push(this.getBhPet2());
            gc.player2.plist.push(gc.allEquip.findByName("p_cybxjl"));
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 白虎宝宝X1，冰雪精灵X1，灵魂药水X10，优秀神秘商人时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya139() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_2",1);
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"wpsh_2",1);
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1，火灵珠X1，二重神火X1，2级生命石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya138() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝X1，水灵珠X1，龙王令X1，龙女的眼泪X10",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao9yue2016_25() : void
      {
         var gcxdyy:* = undefined;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 转轮王时装X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao9yue2016_14() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 玄武宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao9yue2016_5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 龟丞相的遗言X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function qiandao9yue2016_1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns3",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns3",1);
         }
         gc.ts.setTxt("成功领取 三级仙女石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      private function shouyoutong2016() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.player1.petsAry.push(this.getQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.player2.petsAry.push(this.getQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1，双倍经验丹X1，孟婆药剂X1，三级强化石X1，熔炼石X1，三级攻击石X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya136BiShai() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"sms3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"sms3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 白虎宝宝X1，火灵珠X1，3级生命石X1，阴阳斩龙剑X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya136() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"fys3",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"fys3",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝X1，3级防御石X1，神行渔鼓X1，孟婆药剂X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getMousePet2());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getMousePet2());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
         }
         gc.ts.setTxt("成功领取 子鼠元帅X1、子鼠精灵X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent2() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getYHPet());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyyhjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getYHPet());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyyhjl"));
         }
         gc.ts.setTxt("成功领取 寅虎元帅x1、寅虎精灵x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent3() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 青龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent4() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptttzssz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 天庭战神时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent5() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzqsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ptzqsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 中秋时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cangjinggePresent6() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_ssggjtg"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_ssggjtg"));
         }
         gc.ts.setTxt("成功领取 光棍节脱光头衔x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function eight_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"dlhys",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"dlhys",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptttzssz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 大灵魂药水x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 药王葫芦x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 青龙宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 天庭战神时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function duoBaoPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player1.plist.push(gc.allEquip.findByName("p_cylhjl"));
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player2.plist.push(gc.allEquip.findByName("p_cylhjl"));
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1，孟婆药剂X1，牛魔王时装X1，4399忠实玩家头衔X1，烈火精灵X1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya135() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1，3级魔法石X1，龟丞相的遗言X1，4399忠实玩家头衔X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya134() : void
      {
         var gcxdyy:* = null;
         var smsrsz:MyEquipObj = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"fys3",1);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"fys3",1);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 3级防御石X1，大灵魂药水X1，神秘商人时装X1，白虎宝宝X1",2.5,23);
         gc.stage.addChild(gc.ts);
      }
      
      protected function seven_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"fys2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("hehua");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(nmwsz);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"fys2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("hehua");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
                  break;
               case 3:
                  nmwsz = gc.allEquip.findByName("ptnmwsz");
                  nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(nmwsz);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级防御石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 慈心妙莲x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 朱雀宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya133() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("xhhl");
            gcxdyy.setEupdata(2);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("xhhl");
            gcxdyy.setEupdata(2);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 火灵珠X1，3级攻击石X1，孟婆药剂X1，宣花葫芦X1",2.5,26);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya132() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 水灵珠X1，3级魔法石X1，龙王令X1，龟丞相的遗言X1",2.5,26);
         gc.stage.addChild(gc.ts);
      }
      
      protected function six_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
                  break;
               case 1:
                  gc.player1.plist.push(gc.allEquip.findByName("p_cysx"));
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
                  break;
               case 1:
                  gc.player2.plist.push(gc.allEquip.findByName("p_cysx"));
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 4399忠实玩家头衔x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 噬血x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 青龙宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya131() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 3级强化石X1，水灵珠X1，镇魂玉箫X1，玄武宝宝X1",2.5,26);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuya130() : void
      {
         var smsrsz:MyEquipObj = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs3",1);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs3",1);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 神秘商人时装X1，白虎宝宝X1，三级魔法石X1，雷灵珠X1",2.5,26);
         gc.stage.addChild(gc.ts);
      }
      
      protected function xiaoHuDuiPresent1() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplvdyl",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplvdyl",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
         }
         gc.ts.setTxt("成功领取 龙女的眼泪x1、1级仙女石x1",2.5,26);
         gc.stage.addChild(gc.ts);
      }
      
      protected function xiaoHuDuiPresent2() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player1,"wpzz",1);
            gc.putQhsInBackPack(gc.player1,"wpxt",1);
            gc.putQhsInBackPack(gc.player1,"wpsmd1",1);
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player2,"wpzz",1);
            gc.putQhsInBackPack(gc.player2,"wpxt",1);
            gc.putQhsInBackPack(gc.player2,"wpsmd1",1);
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
         }
         gc.ts.setTxt("成功领取 1级强化石x1、珍珠x1、玄铁x1、一品生命丹x1、长生丹x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function xiaoHuDuiPresent3() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy = gc.allEquip.findByName("ptnmwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔x1、牛魔王时装x1、摇光石x1、3级攻击石x1、火灵珠x1、青龙宝宝x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      protected function laborsDay2016() : void
      {
         var equip:MyEquipObj = null;
         var equip2:MyEquipObj = null;
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player1.zblist.push(equip);
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player1.zblist.push(equip2);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player2.zblist.push(equip);
            equip2 = gc.allEquip.findByName("shsjt");
            gc.player2.zblist.push(equip2);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         gc.ts.setTxt("成功领取 乱世英雄头衔x1、药王葫芦x1、双倍经验丹x1、山河社稷图x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function five_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"gjs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getNewJPZQPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"gjs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("dkhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getNewJPZQPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 2级攻击石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 地魁花篮x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 朱雀宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa129Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"yhs",1);
            gc.putQhsInBackPack(gc.player1,"tss",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"yhs",1);
            gc.putQhsInBackPack(gc.player2,"tss",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玉衡石x1、天枢石x1、熔炼石x1、阴阳斩龙剑x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa128Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms3",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms3",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 3级生命石x1、摇光石x1、3级仙女石x1、龟丞相的遗言x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa127Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         var smsrsz:MyEquipObj = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、风灵珠x1、优秀神秘商人装x1、忠实玩家头衔x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function four_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"mfs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("yyb");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"mfs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("yyb");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getJpGuiBuPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 二级魔法石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 云阳板x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 玄武宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa126Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 火灵珠x1、三级强化石x1、白虎宝宝x1、混元珍珠伞x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function bbb2NormalPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"lhys",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",1);
            gc.putQhsInBackPack(gc.player1,"kly1",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"lhys",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",1);
            gc.putQhsInBackPack(gc.player2,"kly1",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
         }
         gc.ts.setTxt("成功领取 灵魂药水x1、双倍经验丹x1、龙女的眼泪x1、一级昆仑玉x1、一级仙女石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function ysYearPresent1() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 孟婆药剂x1、大灵魂药水x1、龟丞相的遗言x1、一级仙女石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function ysYearPresent2() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 龙女的眼泪x3、2级级生命石x1、镇魂玉箫x1、4399忠实玩家头衔x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function bbb2SpecialPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy);
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(eq2);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gcxdyy = gc.allEquip.findByName("ptzlwsz");
            gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy);
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(eq2);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 3级强化石x1、水灵珠x1、转轮王时装x1、转轮王的哀嚎x1、龟布x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa125Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy = gc.allEquip.findByName("bxzq");
            gcxdyy.setEupdata(1.5);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gcxdyy = gc.allEquip.findByName("bxzq");
            gcxdyy.setEupdata(1.5);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 足球x1、4399忠实玩家头衔x1、孟婆药剂x1、风灵珠x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function three_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getNewJPZQPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("yyzlj");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getNewJPZQPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 二级强化石x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 阴阳斩龙剑x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 朱雀宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa124Present() : void
      {
         var smsrsz:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"tss",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cykljl"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"tss",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cykljl"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 狂雷精灵x1、雷灵珠x1、天枢石x1、青龙宝宝x1、神秘商人装x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa123Present() : void
      {
         var smsrsz:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cylhjl"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.player1.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cylhjl"));
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.player2.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         gc.ts.setTxt("成功领取 火灵珠x1、烈火精灵x1、熔炼石x1、神秘商人装x1、朱雀宝宝x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function monkeyYearPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         var temp:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         var temp2:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            temp = gc.allEquip.findByName("_4399zswj");
            gc.player1.zblist.push(temp);
            gc.player1.petsAry.push(this.getMonkey());
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("jlsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            temp2 = gc.allEquip.findByName("_4399zswj");
            gc.player2.zblist.push(temp2);
            gc.player2.petsAry.push(this.getMonkey());
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            nmwsz2 = gc.allEquip.findByName("jlsmsrsz");
            nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz2);
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔x1、火丸x1、神秘商人时装x1、云阳板x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function two_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"mpyj",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"mpyj",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("sxyg");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getJPQLPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptnmwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 孟婆药剂x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 神行渔鼓x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 青龙宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 牛魔王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function gameBoxNewYearPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.player1.petsAry.push(this.getBhPet3());
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.player2.petsAry.push(this.getBhPet3());
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 混元珍珠伞x1、虎丸x1、摇光石x1、孟婆药剂x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa122Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"lssp_1",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"lssp_1",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、3级昆仑玉x1、土灵珠x1、流石碎片x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa121Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玄风棕扇x1、3级仙女石x1、龙王令x1、2级攻击石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function one_yueqiandao(type:int) : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player1,"wpcsd",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player1.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player1.petsAry.push(this.getNewJpGuiBuPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player1.szlist.push(gcxdyy);
            }
         }
         if(gc.player2.roleid > 0)
         {
            switch(type - 1)
            {
               case 0:
                  gc.putQhsInBackPack(gc.player2,"wpcsd",1);
                  break;
               case 1:
                  gcxdyy = gc.allEquip.findByName("ywhl");
                  gcxdyy.setEupdata(2.4);
                  gc.player2.zblist.push(gcxdyy);
                  break;
               case 2:
                  gc.player2.petsAry.push(this.getNewJpGuiBuPet());
                  break;
               case 3:
                  gcxdyy = gc.allEquip.findByName("ptzlwsz");
                  gcxdyy.setFashionTime(gc.dataObjectInstance.curDate);
                  gc.player2.szlist.push(gcxdyy);
            }
         }
         switch(type - 1)
         {
            case 0:
               gc.ts.setTxt("成功领取 长生丹x1");
               break;
            case 1:
               gc.ts.setTxt("成功领取 药王葫芦x1");
               break;
            case 2:
               gc.ts.setTxt("成功领取 玄武宝宝x1");
               break;
            case 3:
               gc.ts.setTxt("成功领取 转轮王时装x1");
         }
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa120Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 雷灵珠x1、3级攻击石x1、慈心妙莲x1、熔炼石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function pkPersent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_4",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_4",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
         }
         gc.ts.setTxt("成功领取 四重神铁x1、3级强化石x1、3级昆仑玉x1、水灵珠x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function millionPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"tlzsp",1);
            gc.putQhsInBackPack(gc.player1,"kly1",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gcxdyy = gc.allEquip.findByName("_4399ptsjwj");
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"tlzsp",1);
            gc.putQhsInBackPack(gc.player2,"kly1",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gcxdyy = gc.allEquip.findByName("_4399ptsjwj");
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 4399手机玩家头衔x1、土灵珠碎片x1、一级昆仑玉x1、一级仙女石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function decemberOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
         }
         gc.ts.setTxt("成功领取 2级攻击石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function decemberSevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 云阳板x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function decemberFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function decemberTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 牛魔王时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa118Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
            nmwsz = gc.allEquip.findByName("ptsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑x1、摇光石x1、神秘商人时装x1、三重神火x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa119Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 三重神铁x1、镇魂玉箫x1、三级昆仑玉x1、孟婆药剂x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa117Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gc.putQhsInBackPack(gc.player1,"kly2",1);
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.petsAry.push(this.getBhPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gc.putQhsInBackPack(gc.player2,"kly2",1);
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.petsAry.push(this.getBhPet2());
         }
         gc.ts.setTxt("成功领取 风灵珠x1、2级昆仑玉x1、地魁花篮x1、虎丸宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa116Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 水灵珠x1、2级强化石x1、熔炼石x1、药王葫芦x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function novemberOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"fys2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"fys2",1);
         }
         gc.ts.setTxt("成功领取 2级防御石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function novemberSevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function novemberFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function novemberTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 转轮王时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa115Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
         }
         gc.ts.setTxt("成功领取 2级攻击石x1、双倍经验丹x1、火灵珠x1、孟婆药剂x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function haohuaPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wphhd",1);
            gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
            gc.player1.petsAry.push(this.getNianPet1());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wphhd",1);
            gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
            gc.player2.petsAry.push(this.getNianPet1());
         }
         gc.ts.setTxt("成功领取 年兽宝宝x1、年兽进化丹x1、年兽精灵x1、长生丹x1、还魂丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms2",1);
         }
         gc.ts.setTxt("成功领取 2级生命石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberSeventDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 慈心妙莲x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 龟布宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 牛魔王时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa113Present() : void
      {
         var gcxdyy:* = null;
         var smsrsz:MyEquipObj = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
         }
         gc.ts.setTxt("成功领取 土灵珠x1、2级魔法石x1、熔炼石x1、优秀神秘商人装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa112Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.putQhsInBackPack(gc.player1,"tss",1);
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.putQhsInBackPack(gc.player2,"tss",1);
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 玄风棕扇x1、2级生命石x1、天枢石x1、风灵珠x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function septemberOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
         }
         gc.ts.setTxt("成功领取 2级魔法石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function septemberSevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 地魁花篮x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function septemberFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPZQPet(1200,1200,1300,600));
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function septemberTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("jlsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("jlsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 精良神秘商人时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa111Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"fys2",1);
            gc.putQhsInBackPack(gc.player1,"yhs",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"fys2",1);
            gc.putQhsInBackPack(gc.player2,"yhs",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("zhyx");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1、2级防御石x1、玉衡石x1、孟婆药剂x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa110Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player1,"tss",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
            gc.putQhsInBackPack(gc.player2,"tss",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑x1、龙女的眼泪x10、天枢石x1、龙王令x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function augustOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
         }
         gc.ts.setTxt("成功领取 2级攻击石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function augustSevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 药王葫芦x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function augustFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function augustTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 转轮王时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function yuetuPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wphhd",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cykx"));
            gc.player1.petsAry.push(this.getYTPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wphhd",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cykx"));
            gc.player2.petsAry.push(this.getYTPet2());
         }
         gc.ts.setTxt("成功领取 月兔宝宝X1、长生丹X1、还魂丹X1、抗性X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function summerHoliday2015() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            gc.putQhsInBackPack(gc.player1,"nianqld",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cyhh"));
            gc.player1.petsAry.push(this.getNianPet2());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            gc.putQhsInBackPack(gc.player2,"nianqld",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cyhh"));
            gc.player2.petsAry.push(this.getNianPet2());
         }
         gc.ts.setTxt("成功领取 年兽宝宝X1、年兽进化丹X1、年兽潜力丹X1、辉煌X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa109Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gcxdyy = gc.allEquip.findByName("hehua");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 二级攻击石x1、三级强化石x1、熔炼石x1、慈心妙莲x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function bangWoTongXin() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.player1.petsAry.push(this.getJPZQPet(1100,1100,1100,500));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.putQhsInBackPack(gc.player2,"rls",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.player2.petsAry.push(this.getJPZQPet(1100,1100,1100,500));
         }
         gc.ts.setTxt("成功领取 朱雀宝宝X1、二级生命石X1、熔炼石X1、火灵珠X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYaSaiZiShu() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getMousePet2());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyzsjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getMousePet2());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyzsjl"));
         }
         gc.ts.setTxt("成功领取 子鼠元帅X1、子鼠精灵X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYaSaiChouNiu() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNeatPet2());
            gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNeatPet2());
            gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 丑牛元帅X1、丑牛精灵X1、牛魔王时装X1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa108Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
            gc.putQhsInBackPack(gc.player1,"xns2",1);
            gc.putQhsInBackPack(gc.player1,"fys3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
            gc.putQhsInBackPack(gc.player2,"xns2",1);
            gc.putQhsInBackPack(gc.player2,"fys3",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 二级魔法石x1、二级仙女石x1、三级防御石x1、阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function julyOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
         }
         gc.ts.setTxt("成功领取 2级魔法石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function julySevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 云阳板x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function julyFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 龟布宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function julyTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 牛魔王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa107Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_4",1);
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
            gc.putQhsInBackPack(gc.player2,"wpsh_4",1);
            gcxdyy = gc.allEquip.findByName("sxyg");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 孟婆药剂x1、二级攻击石x1、四重神火x1、神行渔鼓x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function yikatongBigPresent() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"nianjhd",1);
            gc.putQhsInBackPack(gc.player1,"nianjhdd",1);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.player1.petsAry.push(this.getNianPet1());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"nianjhd",1);
            gc.putQhsInBackPack(gc.player2,"nianjhdd",1);
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gc.player2.petsAry.push(this.getNianPet1());
         }
         gc.ts.setTxt("成功领取 年兽宝宝x1、年兽进化丹x1、年兽进化大丹x1、转轮王时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function yikatongSmallPresent() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 白虎宝宝x1、牛魔王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa106Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 三级昆仑玉x1   三重神铁x1   龙王令x1  阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function qinglongjianPresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("qljfb");
            gcxdyy.setEupdata(2.4);
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 青龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function juneOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
         }
         gc.ts.setTxt("成功领取 长生丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function juneSevenDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 龟丞相的遗言x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function juneFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function juneTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 牛魔王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function childrenDay2015() : void
      {
         var gcxdyy:* = null;
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms1",3);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("hsqq"));
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms1",3);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("hsqq"));
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 红色气球x1、火灵珠x1、神秘商人时装x1、一级生命石x3");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa105Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player1,"fys2",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wpsh_3",1);
            gc.putQhsInBackPack(gc.player2,"fys2",1);
            gcxdyy = gc.allEquip.findByName("bjs");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 长生丹x1、三重神火x1、二级防御石x1、玄风棕扇x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa104Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"mfs2",1);
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"mfs2",1);
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
         }
         gc.ts.setTxt("成功领取 雷灵珠x1、二级魔法石x1、三级仙女石x1、摇光石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function mayOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
         }
         gc.ts.setTxt("成功领取 二级强化石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function maySeventDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getEquip(true,"zhyx"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getEquip(true,"zhyx"));
         }
         gc.ts.setTxt("成功领取 镇魂玉箫x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function mayFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function mayTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 普通转轮王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa103Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gc.putQhsInBackPack(gc.player1,"sms2",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gc.putQhsInBackPack(gc.player2,"sms2",1);
         }
         gc.ts.setTxt("成功领取 三级昆仑玉x1、 双倍经验丹x1、土灵珠x1、 二级生命石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function wuyiHappyPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
         }
         gc.ts.setTxt("成功领取 龙王令x1、孟婆药剂x1、一级仙女石x1、一级强化石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function wuyiFunPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"fys2",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.player1.zblist.push(this.getEquip(true));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"fys2",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.player2.zblist.push(this.getEquip(true));
         }
         gc.ts.setTxt("成功领取 雷灵珠x1、二级防御石x1、三级强化石x1、 阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa102Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
            gc.putQhsInBackPack(gc.player1,"fys3",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",10);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
            gc.putQhsInBackPack(gc.player2,"fys3",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",10);
         }
         gc.ts.setTxt("成功领取 风灵珠x1、三重神铁x1、三级防御石x1、一级强化石x10");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa101Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
         }
         gc.ts.setTxt("成功领取 水灵珠x1、三级昆仑玉x1、三级攻击石x1、龙女的眼泪x10");
         gc.stage.addChild(gc.ts);
      }
      
      protected function aprilOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         gc.ts.setTxt("成功领取 双倍经验丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function aprilSeventDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("ywhl");
            gcxdyy.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 药王葫芦x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function aprilFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function aprilTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 牛魔王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function zhuanPanPresent() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",3);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",10);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("yxsmsrsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",3);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",10);
         }
         gc.ts.setTxt("成功领取 神秘商人装x1、龙王令x1、摇光石x3、龙女的眼泪x10");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa100Present() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns3",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns3",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wpflz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 三级仙女石x1、双倍经验丹x1、风灵珠x1、混元珍珠伞x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function threeOneDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpbsz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpbsz",1);
         }
         gc.ts.setTxt("成功领取 避水珠x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function threeSeventDay() : void
      {
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            equip = gc.allEquip.findByName("_sryxyx");
            gc.player1.zblist.push(equip);
         }
         if(gc.player2.roleid > 0)
         {
            equip = gc.allEquip.findByName("_sryxyx");
            gc.player2.zblist.push(equip);
         }
         gc.ts.setTxt("成功领取 射日英雄头衔x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function threeFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getNewJPZQPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("phoenix1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1200);
         pif.setmpQuality(1200);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 250));
         pif.setMp(120 + Math.round(RandomControllor.getIns().getRandom() * 80));
         pif.setAtk(16 + Math.round(RandomControllor.getIns().getRandom() * 16));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function threeTwentyFiveDay() : void
      {
         var nmwsz:MyEquipObj = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 普通转轮王装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa99Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.player1.zblist.push(this.getEquip(true));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.player2.zblist.push(this.getEquip(true));
         }
         gc.ts.setTxt("成功领取 长生丹x1、摇光石x1、双倍经验丹x1、阴阳斩龙剑x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function cunJiePresent2015() : void
      {
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player1.zblist.push(equip);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player2,"wpst_1",1);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player2.zblist.push(equip);
         }
         gc.ts.setTxt("成功领取 雷灵珠x1、乱世英雄头衔x1、一重神火x1、一重神铁x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function bbbNormalPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player1,"jyys",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs1",1);
            gc.putQhsInBackPack(gc.player2,"jyys",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         gc.ts.setTxt("成功领取 1级强化石x1、经验药水x1、双倍经验丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function bbbSpecialPresent() : void
      {
         var myequip:MyEquipObj = null;
         myequip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player1,"wpst_4",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            myequip = gc.allEquip.findByName("ptttzssz");
            myequip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myequip);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player2,"wpst_4",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            myequip = gc.allEquip.findByName("ptttzssz");
            myequip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myequip);
         }
         gc.ts.setTxt("成功领取 1级强化石x9、四重神铁x1、孟婆药剂x1、天庭战神装x1、长生丹x1",24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function twoThreeDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
         }
         gc.ts.setTxt("成功领取 龙王令x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function twoSevenDay() : void
      {
         this.twelveSevenDay();
      }
      
      protected function twoFifteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_2",1);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_2",1);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 龟布宝宝x1、二重神铁x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function twoTwentyFiveDay() : void
      {
         var eq:MyEquipObj = null;
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_3",1);
            eq = gc.allEquip.findByName("zlwdah");
            eq.setEupdata(2.4);
            eq.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(eq);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_3",1);
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(eq2);
         }
         gc.ts.setTxt("成功领取 转轮王的哀嚎x1、三重神铁x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function yuanbaoPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getEquip(true));
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getEquip(true));
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑x1、火灵珠x1、 孟婆药剂x1、摇光石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuYa96Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 钢石精灵x1、长生丹x1、 水灵珠x1、龟布宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function oneThreeDay() : void
      {
         this.octoberThreeDay();
      }
      
      protected function oneSevenDay() : void
      {
         this.elevenSevenDay();
      }
      
      protected function oneFourteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 极品白虎宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function oneTwentyDay() : void
      {
         var smsrsz1:MyEquipObj = null;
         var smsrsz2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            smsrsz1 = gc.allEquip.findByName("jlsmsrsz");
            smsrsz1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz1);
         }
         if(gc.player2.roleid > 0)
         {
            smsrsz2 = gc.allEquip.findByName("jlsmsrsz");
            smsrsz2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz2);
         }
         gc.ts.setTxt("成功领取 精良神秘商人装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function doubleEgePresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
         }
         gc.ts.setTxt("成功领取 火灵珠x1、长生丹x1、龙王令x1、摇光石x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function tuyaPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getYMPet());
            gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getYMPet());
            gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
         }
         gc.ts.setTxt("成功领取 炎马宠物x1、炎马精灵x1、孟婆药剂x1、双倍经验丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getYMPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("roomhorse1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1000);
         pif.setmpQuality(1200);
         pif.setatkQuality(1200);
         pif.setdefQuality(600);
         pif.setHp(700);
         pif.setMp(800);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function yhjlPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.plist.push(gc.allEquip.findByName("p_cyyhjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.plist.push(gc.allEquip.findByName("p_cyyhjl"));
         }
         gc.ts.setTxt("成功领取 寅虎精灵x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function starPetPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getYHPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getYHPet());
         }
         gc.ts.setTxt("成功领取 寅虎宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getYHPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("terribletiger1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1600);
         pif.setmpQuality(200);
         pif.setatkQuality(1800);
         pif.setdefQuality(300);
         pif.setHp(1000);
         pif.setMp(200);
         pif.setAtk(70);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function twelveThreeDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getZjEquip(true));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getZjEquip(true));
         }
         gc.ts.setTxt("成功领取 紫金铃铛x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getZjEquip(_wx:Boolean = true) : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName("zjld");
         equip.setEupdata(2);
         if(_wx)
         {
            equip.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
         }
         return equip;
      }
      
      protected function twelveSevenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
         }
         gc.ts.setTxt("成功领取 造梦英雄x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function twelveFourteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getJPZQPet(_hp:uint = 1200, mp:uint = 1300, atk:uint = 1300, def:uint = 600) : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("phoenix1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(_hp);
         pif.setmpQuality(mp);
         pif.setatkQuality(atk);
         pif.setdefQuality(def);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 250));
         pif.setMp(120 + Math.round(RandomControllor.getIns().getRandom() * 80));
         pif.setAtk(16 + Math.round(RandomControllor.getIns().getRandom() * 16));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function twelveTwentyDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getNMWEquip(true));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getNMWEquip(true));
         }
         gc.ts.setTxt("成功领取 牛魔王的怒吼x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getNMWEquip(_wx:Boolean = true) : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName("nmwdnh");
         equip.setEupdata(2.4);
         if(_wx)
         {
            equip.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
         }
         return equip;
      }
      
      protected function tequanPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"lhys",1);
            gc.putQhsInBackPack(gc.player1,"wptm",9);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"lhys",1);
            gc.putQhsInBackPack(gc.player2,"wptm",9);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
         }
         gc.ts.setTxt("成功领取 灵魂药水x1、檀木x9、双倍经验丹x1、龙王令x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function halloweenDay() : void
      {
         var equip:MyEquipObj = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpygs",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player1.zblist.push(equip);
            gc.player1.petsAry.push(this.getBhPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpygs",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player2.zblist.push(equip);
            gc.player2.petsAry.push(this.getBhPet());
         }
         gc.ts.setTxt("成功领取 摇光石x1、乱世英雄头衔x1、双倍经验丹x1、极品白虎宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getBhPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(1000);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getBhPet2() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(1100);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getBhPet3() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(1000);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getMonkey() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("monkey1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1000);
         pif.setmpQuality(1000);
         pif.setatkQuality(1000);
         pif.setdefQuality(600);
         pif.setHp(200);
         pif.setMp(150);
         pif.setAtk(20);
         pif.setDef(6);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function octoberThreeDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("xhhl");
            gcxdyy.setEupdata(1.2);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("xhhl");
            gcxdyy.setEupdata(1.2);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 宣花葫芦x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberSevenDay() : void
      {
         var myEquip:MyEquipObj = null;
         myEquip = null;
         if(gc.player1.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("yxsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("yxsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
         }
         gc.ts.setTxt("成功领取 优秀神秘商人时装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function octoberFourteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function elevenThreeDay() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 混元珍珠伞x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function elevenSevenDay() : void
      {
         var temp:MyEquipObj = null;
         var myEquip:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            temp = gc.allEquip.findByName("_4399zswj");
            gc.player1.zblist.push(temp);
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("yxsmsrsz");
            gc.player2.zblist.push(temp);
         }
         gc.ts.setTxt("成功领取 4399忠实玩家x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function elevenFourteenDay() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJpGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJpGuiBuPet());
         }
         gc.ts.setTxt("成功领取 龟布宝宝x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function elevenTwentyDay() : void
      {
         var eq:MyEquipObj = null;
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            eq = gc.allEquip.findByName("zlwdah");
            eq.setEupdata(2.4);
            eq.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(eq);
         }
         if(gc.player2.roleid > 0)
         {
            eq2 = gc.allEquip.findByName("zlwdah");
            eq2.setEupdata(2.4);
            eq2.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(eq2);
         }
         gc.ts.setTxt("成功领取 转轮王的哀嚎x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function nationDay2014Present() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getQuedang());
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cylhjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getQuedang());
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cylhjl"));
         }
         gc.ts.setTxt("成功领取 烈火精灵x1、火灵珠x1、双倍经验丹x1、雀蛋x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getQuedang() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("phoenix1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1200);
         pif.setmpQuality(1300);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(450);
         pif.setMp(200);
         pif.setAtk(32);
         pif.setDef(6);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function getZhongQiuPresent() : void
      {
         var smsrsz:MyEquipObj = null;
         var smsrsz2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"gjs3",1);
            gc.putQhsInBackPack(gc.player1,"ghyb",5);
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"gjs3",1);
            gc.putQhsInBackPack(gc.player2,"ghyb",5);
            smsrsz2 = gc.allEquip.findByName("yxsmsrsz");
            smsrsz2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz2);
         }
         gc.ts.setTxt("成功领取 孟婆药剂x1、三级攻击石x1、桂花月饼x5、优秀神秘商人装x1");
         gc.stage.addChild(gc.ts);
      }
      
      protected function getNianShouPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNianPet());
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wphhd",1);
            gc.putQhsInBackPack(gc.player1,"xnhdl",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNianPet());
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            gc.putQhsInBackPack(gc.player2,"wphhd",1);
            gc.putQhsInBackPack(gc.player2,"xnhdl",1);
         }
         gc.ts.setTxt("成功领取 年兽宝宝、还魂丹x1、长生丹x1、新年红灯笼x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getNianPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(2 + Math.round(RandomControllor.getIns().getRandom() * 3));
         pif.setwarpower(2 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.settechnique(2 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.sethpQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 500)) * 1.3);
         pif.setmpQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
         pif.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
         pif.setdefQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNianPet1() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1800);
         pif.setmpQuality(200);
         pif.setatkQuality(1400);
         pif.setdefQuality(400);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNianPet3() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1800);
         pif.setmpQuality(200);
         pif.setatkQuality(1400);
         pif.setdefQuality(400);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNianPet2() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1900);
         pif.setmpQuality(200);
         pif.setatkQuality(1500);
         pif.setdefQuality(500);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function getSummerHoliday2014() : void
      {
         var equip:MyEquipObj = null;
         var equip2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(this.getEquip(false));
            gc.player1.petsAry.push(this.getYTPet());
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            equip = gc.allEquip.findByName("yxsmsrsz");
            equip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(equip);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(this.getEquip(false));
            gc.player2.petsAry.push(this.getYTPet());
            gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            equip2 = gc.allEquip.findByName("yxsmsrsz");
            equip2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(equip2);
         }
         gc.ts.setTxt("成功领取 阴阳斩龙剑、月兔宝宝、优秀神秘商人时装、长生丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getYTPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("rabbit1",1);
         pif.setperception(3 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.setwarpower(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.settechnique(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.sethpQuality(1430);
         pif.setmpQuality(1170);
         pif.setatkQuality(1560);
         pif.setdefQuality(520);
         pif.setHp(500);
         pif.setMp(200);
         pif.setAtk(30);
         pif.setDef(5);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getYTPet2() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("rabbit1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(1000);
         pif.setatkQuality(1500);
         pif.setdefQuality(500);
         pif.setHp(500);
         pif.setMp(200);
         pif.setAtk(30);
         pif.setDef(5);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getUFOPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("ufo1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1100);
         pif.setmpQuality(1000);
         pif.setatkQuality(1100);
         pif.setdefQuality(350);
         pif.setHp(250);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function getSheQuFiveYear() : void
      {
         gc.dataObject.worldtransfromTimes += 3;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player1,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player2,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player2,"wpst_1",1);
         }
         gc.ts.setTxt("成功领取社区五周年活动礼包");
         gc.stage.addChild(gc.ts);
      }
      
      protected function getDuanWuPresent() : void
      {
         var fb1:MyEquipObj = null;
         var fb2:MyEquipObj = null;
         var str:String = "青龙宝宝X1、龙王令X1";
         var fn:String = "";
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getQLPet());
            gc.putQhsInBackPack(gc.player1,"wplwl",1);
            fb1 = this.getQQEquip();
            if(fb1)
            {
               fn = fb1.getFillName();
               gc.player1.zblist.push(fb1);
            }
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getQLPet());
            gc.putQhsInBackPack(gc.player2,"wplwl",1);
            fb2 = this.getQQEquip(fn);
            if(fb2)
            {
               gc.player2.zblist.push(fb2);
            }
         }
         if(fb1)
         {
            str += fb1.ename + "X1";
         }
         gc.ts.setTxt(str);
         gc.stage.addChild(gc.ts);
      }
      
      private function getQLPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("dragon1",1);
         pif.setperception(3 + Math.round(RandomControllor.getIns().getRandom() * 2));
         pif.setwarpower(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.settechnique(3 + Math.round(RandomControllor.getIns().getRandom()));
         pif.sethpQuality(1430);
         pif.setmpQuality(780);
         pif.setatkQuality(1430);
         pif.setdefQuality(520);
         pif.setHp(400);
         pif.setMp(200);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getJPQLPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("dragon1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(700);
         pif.setatkQuality(1400);
         pif.setdefQuality(500);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getQQEquip(_fn:String = "") : MyEquipObj
      {
         var equip:MyEquipObj = null;
         var qqAry:Array = ["hsqq","h_sqq","lsqq","csqq","l_sqq","zsqq"];
         var r:uint = Math.round(RandomControllor.getIns().getRandom() * 5);
         if(qqAry[r])
         {
            if(_fn != "")
            {
               equip = gc.allEquip.findByName(_fn);
            }
            else
            {
               equip = gc.allEquip.findByName(qqAry[r]);
            }
            return equip;
         }
         return null;
      }
      
      private function getChildrenDayPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player1,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
            gc.dataObject.worldtransfromTimes += 10;
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpqhs1",9);
            gc.putQhsInBackPack(gc.player2,"wpsh_1",1);
            gc.putQhsInBackPack(gc.player2,"wpst_1",1);
            gc.dataObject.worldtransfromTimes += 10;
         }
         gc.ts.setTxt("成功领取五一活动礼包");
         gc.stage.addChild(gc.ts);
      }
      
      private function getPresent2() : void
      {
         var nmwsz:MyEquipObj = null;
         var eq:MyEquipObj = null;
         var nmwsz2:MyEquipObj = null;
         var eq2:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            nmwsz = gc.allEquip.findByName("ptzlwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
            eq = gc.allEquip.findByName("zlwdah");
            gc.player1.zblist.push(eq);
         }
         if(gc.player2.roleid > 0)
         {
            nmwsz2 = gc.allEquip.findByName("ptzlwsz");
            nmwsz2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz2);
            eq2 = gc.allEquip.findByName("zlwdah");
            gc.player2.zblist.push(eq2);
         }
         gc.ts.setTxt("成功领取 普通转轮王装、转轮王的哀嚎");
         gc.stage.addChild(gc.ts);
      }
      
      protected function getClientPhonePresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpcsd");
            gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.player1.petsAry.push(this.getGuiBuPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpcsd");
            gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
            gc.player2.petsAry.push(this.getGuiBuPet());
         }
         gc.ts.setTxt("成功领取龟布宝宝x1、钢石精灵x1、长生丹x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getGuiBuPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("turtle1",1);
         pif.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.sethpQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
         pif.setmpQuality((500 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
         pif.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
         pif.setdefQuality((300 + Math.round(RandomControllor.getIns().getRandom() * 170)) * 1.3);
         pif.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
         pif.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getJpGuiBuPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("turtle1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(1000);
         pif.setatkQuality(1200);
         pif.setdefQuality(700);
         pif.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
         pif.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNewJpGuiBuPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("turtle1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1600);
         pif.setmpQuality(1000);
         pif.setatkQuality(1000);
         pif.setdefQuality(700);
         pif.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
         pif.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getValentinesPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpygs",5);
            gc.putQhsInBackPack(gc.player1,"yhs",5);
            gc.putQhsInBackPack(gc.player1,"tss",5);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpygs",5);
            gc.putQhsInBackPack(gc.player2,"yhs",5);
            gc.putQhsInBackPack(gc.player2,"tss",5);
         }
         gc.ts.setTxt("成功领取摇光石x5、玉衡石x5、天枢石x5");
         gc.stage.addChild(gc.ts);
      }
      
      private function getJiPingHuWan() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getPet());
         }
         gc.ts.setTxt("成功领取一只极品虎丸");
         gc.stage.addChild(gc.ts);
      }
      
      private function getPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1300);
         pif.setmpQuality(1040);
         pif.setatkQuality(1300);
         pif.setdefQuality(520);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getChuanSongPresent() : void
      {
         gc.dataObject.worldtransfromTimes += 10;
         gc.ts.setTxt("成功领取昆仑山世界传送10次");
         gc.stage.addChild(gc.ts);
      }
      
      private function getShenMiPresent() : void
      {
         var myEquip:MyEquipObj = null;
         myEquip = null;
         if(gc.player1.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("ptsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(myEquip);
         }
         if(gc.player2.roleid > 0)
         {
            myEquip = gc.allEquip.findByName("ptsmsrsz");
            myEquip.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(myEquip);
         }
         gc.ts.setTxt("成功领取普通神秘商人时装");
         gc.stage.addChild(gc.ts);
      }
      
      private function getWeiXin2() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
         }
         gc.ts.setTxt("成功领取年兽精灵");
         gc.stage.addChild(gc.ts);
      }
      
      private function getDoubleFestival() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"ghyb",5);
            gc.putQhsInBackPack(gc.player1,"wptm",50);
            gc.putQhsInBackPack(gc.player1,"wpxt",50);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"ghyb",5);
            gc.putQhsInBackPack(gc.player2,"wptm",50);
            gc.putQhsInBackPack(gc.player2,"wpxt",50);
         }
         gc.ts.setTxt("成功领取桂花月饼x5、檀木x50、玄铁x50");
         gc.stage.addChild(gc.ts);
      }
      
      private function getChongZhiPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpxt",500);
            gc.putQhsInBackPack(gc.player1,"wpst_1",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpxt",500);
            gc.putQhsInBackPack(gc.player2,"wpst_1",1);
         }
         gc.ts.setTxt("成功领取 玄铁x500、一重神铁·轻羽x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getDoubleEgePresent() : void
      {
         var gcxdyy:MyEquipObj = null;
         if(gc.player1.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gc.player1.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player1,"wpxt",300);
            gc.putQhsInBackPack(gc.player1,"wpqhs1",10);
         }
         if(gc.player2.roleid > 0)
         {
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gc.player2.zblist.push(gcxdyy);
            gc.putQhsInBackPack(gc.player2,"wpxt",300);
            gc.putQhsInBackPack(gc.player2,"wpqhs1",10);
         }
         gc.ts.setTxt("成功领取 玄铁x300、1级强化石x10、龟丞相的遗言x1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getPhonePresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getMousePet());
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.player1.zblist.push(this.getEquip());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getMousePet());
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.player2.zblist.push(this.getEquip());
         }
         gc.ts.setTxt("成功领取 孟婆药剂X1、子鼠宝宝X1、阴阳斩龙剑X1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getMousePet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("mouse1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(200);
         pif.setatkQuality(1500);
         pif.setdefQuality(400);
         pif.setHp(1000);
         pif.setMp(300);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getMousePet2() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("mouse1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1690);
         pif.setmpQuality(200);
         pif.setatkQuality(1600);
         pif.setdefQuality(500);
         pif.setHp(1000);
         pif.setMp(300);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getEquip(_wx:Boolean = true, _fname:String = "yyzlj") : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName(_fname);
         equip.setEupdata(2.4);
         if(_wx)
         {
            equip.setWX({
               "jin":false,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
         }
         return equip;
      }
      
      private function getPCNewYear() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getNeatPet());
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.player1.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getNeatPet());
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.player2.plist.push(gc.allEquip.findByName("p_cycnjl"));
         }
         gc.ts.setTxt("成功领取 丑牛精灵X1、丑牛元帅X1、双倍经验丹X1");
         gc.stage.addChild(gc.ts);
      }
      
      private function getNeatPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(200);
         pif.setatkQuality(1600);
         pif.setdefQuality(400);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNeatPet2() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("neat1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1700);
         pif.setmpQuality(200);
         pif.setatkQuality(1800);
         pif.setdefQuality(500);
         pif.setHp(1200);
         pif.setMp(200);
         pif.setAtk(60);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      protected function errorHandle(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
      }
      
      protected function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}
