package config
{
   import PhysicsWorld.PhysicsWorld;
   import base.BaseGameSence;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import base.BasePet;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.multi4399.Client;
   import com.superkaka.game.Const.GameConst;
   import event.AEventDispatcher;
   import export.FloorBg;
   import export.GameInfo;
   import export.Infomation;
   import export.honor.AllianceData;
   import export.honor.AllianceSecondInterface;
   import export.honor.AllianceSprite;
   import export.muti.ArenaSprite;
   import export.muti.NodeInfo;
   import export.rank.RankUsers;
   import export.saveInterface.SaveInter;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import loader.Aloader2;
   import manager.PayManager;
   import mvc.controllor.PlayerDatasControllor;
   import mvc.controllor.RandomControllor;
   import my.AllEquipment;
   import my.ChatInFb;
   import my.ContinuitySignIn;
   import my.DebugArea;
   import my.FinancialInfo;
   import my.KeyBoardControl;
   import my.MyEquipObj;
   import my.NewPlayerGuide;
   import my.SavedBuff;
   import my.ViewControllor;
   import petInfo.Formation.PetFormation;
   import petInfo.PetInfo;
   import petInfo.PetJNSuit;
   import petInfo.PetSuit;
   import storage.MemoryClass;
   import task.GameTask;
   import user.MutiUser;
   import user.User;
   import vip.GameVip;
   
   public class Config
   {
      
      static var instance:Config;
      
      public static var MODE1:int = 1;
      
      public static var MODE2:int = 2;
      
      public static var MODE3:int = 3;
       
      
      public var memory:MemoryClass;
      
      public var localuserid1:String = "";
      
      public var localuserid2:String = "";
      
      public var localuserid3:Array;
      
      public var opening:Boolean = false;
      
      public var openinghhe:Boolean = true;
      
      public var gameinwhere:String = "开场";
      
      public var eventManger:AEventDispatcher;
      
      public var playNum:uint;
      
      public var hero1:BaseHero;
      
      public var hero2:BaseHero;
      
      public var hero3:BaseHero;
      
      public var player1:User;
      
      public var player2:User;
      
      public var player3:User;
      
      public var gameSence:BaseGameSence;
      
      public var frameClips:uint = 24;
      
      public var gameInfo:GameInfo;
      
      public var pWorld:PhysicsWorld;
      
      public var bg1:FloorBg;
      
      public var bg2:MovieClip;
      
      public var stage:Stage;
      
      public var isStopGame:Boolean = false;
      
      public var isOpenBackPack:Boolean = false;
      
      public var vControllor:ViewControllor;
      
      public var keyboardControl:KeyBoardControl;
      
      public var allEquip:AllEquipment;
      
      public var allTask:GameTask;
      
      public var otherList:Array;
      
      public var isnew:Boolean = true;
      
      public var hasget:Boolean = false;
      
      public var hasgetsorry:uint = 0;
      
      public var isGoToNewGuideStage:Boolean = false;
      
      public var newGuideInfo:String = "000000000";
      
      public var selectplaceGuideInfo:String = "000000000";
      
      public var isHideDebug:Boolean = true;
      
      public var isFirstPlayGame:Boolean = true;
      
      public var isTest:Boolean = false;
      
      public var isintheselectmap:Boolean = false;
      
      public var isingameshop:Boolean = false;
      
      public var lastPaymentString:String = "";
      
      public var isinthegame:Boolean = false;
      
      public var curBigStage:uint = 1;
      
      public var curBigLevel:uint = 1;
      
      public var lc:LocalConnection;
      
      public var playerName:String;
      
      public var logInfo:Object;
      
      public var loginAlert:MovieClip;
      
      public var dealAlert:Sprite;
      
      public var saveInter:SaveInter;
      
      public var lastSubmitScore:int;
      
      public var saveIntervelCount:int;
      
      public var saveTimer:Timer;
      
      public var startTime:int;
      
      public var pausepre:int;
      
      public var pauseaft:int;
      
      public var pauseTime:int;
      
      public var endTime:int;
      
      public var isBlack:Boolean = false;
      
      public var timeCountArray:Array;
      
      public var ts:Infomation;
      
      public var luanqibazaojiami:Antiwear;
      
      public var currentRead:int = 0;
      
      public var isManyOpen:Boolean = false;
      
      public var afterManyOpenCheckFunc:Function = null;
      
      public var server:Client;
      
      public var isServerOk:Boolean = false;
      
      public var hdInfo:Array;
      
      public var qhsInfo:Array;
      
      public var isLevelClear:Boolean = false;
      
      public var maxMonsterPerScreen:int = 8;
      
      public var gameMode:int;
      
      public var lastDelayTime:uint;
      
      public var heroBuffArray:Array;
      
      public var sid:int = -1;
      
      public var curStageAndCurLevel:Antiwear;
      
      public var whoreadbackpackage:uint = 0;
      
      public var whobuying:uint = 1;
      
      public var position:String;
      
      public var isRoomOnwer:Boolean = false;
      
      public var roomOnwerSid:int = -1;
      
      public var nodeInfo:NodeInfo;
      
      public var nodeFloor:uint = 0;
      
      public var roomInfo:String = "NO";
      
      public var obbsiteArray:Array;
      
      public var gameScore:Object;
      
      public var cardId:String = "";
      
      public var bossChallenge:Array;
      
      public var threebossChanllenge:Array;
      
      public var dataObject:Antiwear;
      
      public var dataObjectInstance:Antiwear;
      
      public var hasGetMoney:Boolean = false;
      
      public var hasGetTabelScore:Boolean = false;
      
      public var gameVip:GameVip;
      
      public var rankHasPassOneMin:Boolean = true;
      
      public var hasShowLMTS:Boolean = false;
      
      public var rankList:Array;
      
      public var rangeList:Array;
      
      public var ownRankUser:RankUsers;
      
      public var rankhaslimit:Boolean = false;
      
      public var auth4399 = null;
      
      public var suggestAuth;
      
      public var canelTimes:Number = 0;
      
      public var hasAutoTips = false;
      
      public var lastSubmitName = "";
      
      public var lastSubmitCId = "";
      
      public var dataXml:XML;
      
      public var zblist:Array;
      
      public var djlist:Array;
      
      public var szlist:Array;
      
      public var petlist:Array;
      
      public var isfirstread:Boolean = true;
      
      public var isczclick:Boolean = false;
      
      public var isfirstinselectplace:Boolean = true;
      
      public var isfirstLogin:Boolean = true;
      
      public var gardenList:Array;
      
      public var isGetNewWorldGuess:Boolean = false;
      
      public var isGetShengDanPresent:Boolean = false;
      
      public var isGetXiongshouPresent:Boolean = false;
      
      public var isGetEveryDayPresent:Boolean = false;
      
      public var isDoubleExp:Boolean = false;
      
      public var isUseZhaoyaojing:Boolean = false;
      
      public var stage531Type:uint = 1;
      
      public var stage541Type:uint = 1;
      
      public var stage541Args:Array;
      
      private var requestDataCb:Function;
      
      public var isGetShengdanShoushen:Boolean = false;
      
      public var shengdanShoushenArray:Array;
      
      public var isGetYikatong:Boolean = false;
      
      public var isGetNewLiBao:Boolean = false;
      
      public var NewLiBaoArray:Array;
      
      public var chatRegExp:RegExp;
      
      public var wordFilters:Array;
      
      public var savedBuff:SavedBuff;
      
      public var savedBuffString:String = "";
      
      public var isComeFrom4399:Boolean = true;
      
      public var isVersionWrong:Boolean = false;
      
      public var bossBloodClass:Class;
      
      public var rankUsers:RankUsers;
      
      public var allSklName:Array;
      
      public var needMMP:Array;
      
      public var petSuitInfo:PetSuit;
      
      public var petJNSuitInfo:PetJNSuit;
      
      public var petFormation:PetFormation;
      
      public var isPkOk:int = -1;
      
      public var playerGuide:NewPlayerGuide;
      
      public var honorData:AllianceData;
      
      public var isDirectGoToRoomChoose:Boolean = false;
      
      public var baxianMonsterId:uint = 163;
      
      public var monsterIdforStage641:uint = 219;
      
      public var qixingMonsterId:int = 180;
      
      public var guoqingMonsterId:int = 183;
      
      public var stage461Type:int = 0;
      
      public var randomMonster:int = 0;
      
      public var isBeatBeidou:Boolean = false;
      
      public var xunhuanStartTime:Number = 1.3866912E12;
      
      public var diffDays:int = 0;
      
      public var diffWeeks:int = 0;
      
      public var isFramePk:Boolean = false;
      
      public var isAirGame:Boolean = false;
      
      private var rwequipfn:MyEquipObj;
      
      private var whichplayer:uint;
      
      public var pay:PayMoneyVar;
      
      private var urlLoader:Object;
      
      public function Config()
      {
         localuserid3 = [];
         eventManger = new AEventDispatcher();
         allEquip = new AllEquipment();
         otherList = [];
         timeCountArray = [];
         ts = new Infomation();
         luanqibazaojiami = new Antiwear(new binaryEncrypt());
         hdInfo = [];
         qhsInfo = [];
         heroBuffArray = [];
         nodeInfo = new NodeInfo();
         obbsiteArray = [];
         gameScore = {
            "sl1_1":0,
            "sl1_2":0,
            "sl1_3":0,
            "sl2_1":0,
            "sl2_2":0,
            "sl2_3":0,
            "sl3_1":0,
            "sl3_2":0,
            "sl3_3":0,
            "sl4_1":0,
            "sl5_1":0,
            "sl6_1":0,
            "sl7_1":0,
            "sl8_1":0,
            "sl9_1":0
         };
         bossChallenge = [0,0,0,0,0,0];
         threebossChanllenge = [0,0,0];
         dataObjectInstance = new Antiwear(new binaryEncrypt());
         gameVip = new GameVip();
         rankList = [];
         rangeList = [];
         suggestAuth = {};
         zblist = [];
         djlist = [];
         szlist = [];
         petlist = [];
         gardenList = [];
         stage541Args = [0,0,0,0];
         shengdanShoushenArray = [585691310,420897412,380169237,31803368,594315325,408465392,445739459,63637235,348642020,353339961,56684075,390342404,513138106,220468617,474401594,207071854,354092572,202039149,618434975,86036379,319409687,416142548,419686516,375069091,245812578,449445354,553740443,622426214,250560255,578650653,664350483,300677926,388879187,668204344,400893503,636478886,405903237,132128919,625700324,276461138,396235390,376494432,387436552,406071914,101326944,635758533,324137279,398754425,507497725,242995938,243377837,376686047];
         NewLiBaoArray = [];
         allSklName = [["slz","zz","sx","qsez","hmz"],["lys","hytj","lyfb","jdy","hyjj"],["sgq","myhc","jgz","tjgl","jhsj"],["blb","xbz","shy","sjt","smb"],["dj","sd","rj","zznh","syzq"],["ssp","jsp","dgq","xgq","tmc"],["zq","mbyj","wdww","jdz","mds"],["qlj","tkj","dzj","lybj","mmw"]];
         needMMP = [[10,20,0,40,50],[20,20,40,40,50],[20,50,50,80,100],[20,40,40,0,100],[10,20,0,20,50],[15,25,35,45,30],[20,30,40,50,60],[20,35,50,30,60]];
         petSuitInfo = new PetSuit();
         petJNSuitInfo = new PetJNSuit();
         petFormation = new PetFormation();
         pay = PayMoneyVar.getInstance();
         super();
         if(!instance)
         {
            instance = this;
            this.dataObjectInstance.curDate = "2000-01-01";
            this.dataObjectInstance.curTime = "12:12:12";
            if(!this.isHideDebug)
            {
               this.dataObjectInstance.loginUid = 243377837;
            }
            else
            {
               this.dataObjectInstance.loginUid = 0;
            }
            initData();
         }
      }
      
      public static function getInstance() : Config
      {
         return instance;
      }
      
      public function initData() : void
      {
         this.currentRead = 0;
         this.isStopGame = false;
         this.hasShowLMTS = false;
         this.luanqibazaojiami.saveId = -1;
         this.luanqibazaojiami.currentsaveindex = -1;
         this.destroyHero();
         this.gameVip.doWhenInitData();
         this.opening = false;
         this.player1 = new User();
         this.player1.init(0);
         this.player2 = new User();
         this.player2.init(1);
         this.player3 = new User();
         this.player3.init(1);
         this.curBigLevel = 1;
         this.curBigStage = 1;
         this.saveIntervelCount = 0;
         this.memory = new MemoryClass();
         this.hasget = false;
         this.hasgetsorry = 0;
         this.cardId = "";
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.rankhaslimit = false;
         this.rankHasPassOneMin = true;
         this.dataObject.yestoday = this.dataObjectInstance.curDate;
         this.dataObject.zero = 0;
         this.dataObject.one = 1;
         this.dataObject.two = 2;
         this.dataObject.three = 3;
         this.dataObject.four = 4;
         this.dataObject.five = 5;
         this.dataObject.six = 6;
         this.dataObject.seven = 7;
         this.dataObject.eight = 8;
         this.dataObject.night = 9;
         this.dataObject.ten = 10;
         this.dataObject.onehundred = 100;
         this.dataObject.threehundred = 300;
         this.dataObject.sixhundred = 600;
         this.dataObject.one_one_thd = 1100;
         this.dataObject.one_eigth_thd = 1800;
         this.dataObject.two_sevent_thd = 2700;
         this.dataObject.three_night_thd = 3900;
         this.dataObject.five_four_thd = 5400;
         this.dataObject.twenty = 20;
         this.dataObject.sixty = 60;
         this.dataObject.fifty = 50;
         this.dataObject.one_two_hundred = 120;
         this.dataObject.one_eight_hundred = 180;
         this.dataObject.two_four_hundred = 240;
         this.dataObject.mysteriousshoptimes = 5;
         this.dataObject.issameday = true;
         this.dataObject.onedaytime = 0;
         this.dataObject.onedaytimeQueenMother = 0;
         this.dataObject.onedaytimeQueenMotherBuchang = 1;
         this.dataObject.onedaytimeQueenMotherXntz = 0;
         this.dataObject.hasChildrensDay = false;
         this.dataObject.hasEigthAnniversary = false;
         this.dataObject.hasNewEigthAnniversary = false;
         this.dataObject.hasGetAuth4399Present = false;
         this.dataObject.hasGetAlliance = false;
         this.dataObject.hasGetDeskTopActivity = false;
         this.dataObject.hasGetNewYearPresent2015 = false;
         this.dataObject.hasGetZhuZhangTYActivity = false;
         this.dataObject.hasGetGameBoxActivity = false;
         this.dataObject.hasGetKaPai_9_Activity = false;
         this.dataObject.hasGetKaPai_1_Activity = false;
         this.dataObject.hasWeiXin7Activity = false;
         this.dataObject.hasWeiXin8Activity = false;
         this.dataObject.hasWeiXin9Activity = false;
         this.dataObject.hasWeiXin10Activity = false;
         this.dataObject.hasGetKaiXuePresent = false;
         this.dataObject.hasGetMidAutumn2018Present = false;
         this.dataObject.hasSummer2017 = false;
         this.dataObject.hasFifteenYearActivity = false;
         this.dataObject.hasWeiXinBaoXiaoActivity = false;
         this.dataObject.hasDWWeiXinBaoXiaoActivity = false;
         this.dataObject.hasDWWeiXinBaoXiaoSjActivity = false;
         this.dataObject.hasDWWeiXinBaoXiaoSj2Activity = false;
         this.dataObject.hasWuYiBaoXiaoSjActivity = false;
         this.dataObject.hasQiZhouNianActivity = false;
         this.dataObject.hasGetGameBoxYYLActivity = false;
         this.dataObject.hasGetGameBoxYYLActivity3 = false;
         this.dataObject.hasGetGameBoxYYLActivity4 = false;
         this.dataObject.hasSummerHoliday4Activity = false;
         this.dataObject.hasSummerHoliday4Activity2 = false;
         this.dataObject.hasGetSolePresent = false;
         this.dataObject.hasGetSolePresent3 = false;
         this.dataObject.everyDayPresent2016 = false;
         this.dataObject.everyDayPresent2016_new = false;
         this.dataObject.millionEveryDayPresent2016_7 = false;
         this.dataObject.hasGetOneSalePresent = false;
         this.dataObject.challengeChildrensTimes = 3;
         this.dataObject.chanllengeChangEr2 = true;
         this.dataObject.chanllengeChangEr3 = true;
         this.dataObject.chanllengeShouHuYueBing2 = false;
         this.dataObject.chanllengeQLJFuBen = false;
         this.dataObject.kaixuelibao2016 = false;
         this.dataObject.chanllengeFootBall = false;
         this.dataObject.chanllengeYJMB = false;
         this.dataObject.guiHuaNumber = 0;
         this.dataObject.throughPastTimes = 1;
         this.dataObject.hasChallengeNewWorldBoss = false;
         this.dataObject.whichlastworld = 0;
         this.dataObject.turntableScore = 0;
         this.dataObject.gardenExp = 0;
         this.dataObject.landgodExp = 0;
         this.dataObject.landgodbless = false;
         this.petlist = [];
         this.dataObject.hasbuypetsecondwarehouse = 1;
         this.dataObject.challengeSaints = false;
         this.dataObject.challengeThreePrinceTimes = 1;
         this.dataObject.whichSaints = 1;
         this.dataObject.maxLevelUpLimit = 10;
         this.dataObject.levelUpLimit = 0;
         this.dataObject.hasgetanniversary = "false_false";
         this.bossChallenge = [0,0,0,0,0,0];
         this.threebossChanllenge = [0,0,0];
         this.hasGetMoney = false;
         this.hasGetTabelScore = false;
         this.qhsInfo = [];
         this.dataObject.gongxun = 0;
         this.dataObject.challengeRankTimes = 30;
         this.dataObject.topLevel = 80;
         this.dataObject.constellationsLevel = "0_0_0_0_0_0_0_0";
         this.dataObject.zhaoyaojingTimes = 0;
         this.dataObject.worldtransfromTimes = 0;
         this.dataObject.fourPhalanx = "0-0_0-0_0-0_0-0";
         this.dataObject.cliffordStone = "0-0_0-0_0-0_0-0";
         this.dataObject.constellationTimes = 7;
         this.dataObject.newyear_2013_mark = "";
         this.dataObject.newyear_2016_mark = "";
         this.dataObject.yh_bz_dl = "0_0_5";
         this.dataObject.snowBossTimes = 0;
         this.dataObject.getVIPPresent = "false_false_false_false_false";
         this.dataObject.bbbbTimes = 1;
         this.dataObject.whiteQiqiu = 0;
         this.isGoToNewGuideStage = false;
         this.dataObject.hasGetChildrenDayPresent = false;
         this.dataObject.intoChildrenDayTime = 1;
         this.dataObject.allianceFbTimes = 1;
         this.dataObject.houyifb = 1;
         this.dataObject.houyifb2 = 1;
         this.dataObject.hasGet50RegistrationBC = false;
         this.dataObject.dujiaPresent16 = false;
         this.dataObject.dujiaPresent17 = false;
         this.dataObject.nationalday2018 = false;
         this.dataObject.beidouqixing = 1;
         this.dataObject.qingmingFB = 1;
         this.dataObject.guoqingFB = 1;
         this.dataObject.dajiFB = 1;
         this.dataObject.lsxxFB = 1;
         this.dataObject.houyiTimes = 0;
         this.dataObject.yuelaoTimes = 0;
         this.dataObject.yuelaoFB = 1;
         this.dataObject.usewhichlb = 4;
         this.dataObject.chanllengenew12_3 = false;
         this.dataObject.hasGetDZPresent = false;
         this.dataObject.hasGetChangeNamePresent = false;
         this.dataObject.hasPresent2020_newyear = false;
         this.dataObject.hasGetWansheng2014 = true;
         this.dataObject.hasGetWansheng2021 = false;
         this.dataObject.hasPresent2019_Baoxiao2 = false;
         this.dataObject.hasPresent2019_Yuanxiao = false;
         this.dataObject.hasPresent2019_Yuanxiao2 = false;
         this.dataObject.hasPresent2019_hangjia = false;
         this.dataObject.hasPresent2019_duanwu = false;
         this.dataObject.hasPresent2019_xiaoyouxi = false;
         this.dataObject.hasPresent2019_nuandong = false;
         this.dataObject.hasPresent2020_neightBir = false;
         this.dataObject.hasPresent2021_tenBir = false;
         this.savedBuffString = "";
         this.savedBuff = new SavedBuff();
         this.curStageAndCurLevel = new Antiwear(new binaryEncrypt());
         this.curStageAndCurLevel.curStage = 1;
         this.curStageAndCurLevel.curLevel = 1;
         this.isGetNewWorldGuess = false;
         this.rankList = [];
         this.rangeList = [];
         this.ownRankUser = null;
         this.isGetShengDanPresent = false;
         this.isGetXiongshouPresent = false;
         this.isGetEveryDayPresent = false;
         this.isDoubleExp = false;
         this.isGetShengdanShoushen = false;
         this.isUseZhaoyaojing = false;
         this.isGetNewLiBao = false;
         this.isfirstLogin = true;
         this.isGetYikatong = false;
         this.randomMonster = 0;
         this.initGardenArray();
         this.dataObject.version = 38.4;
         this.auth4399 = null;
         this.petFormation.resetData();
         this.playerGuide = new NewPlayerGuide();
         this.newGuideInfo = "000000000";
         this.selectplaceGuideInfo = "000000000";
         this.honorData = new AllianceData();
         ContinuitySignIn.getIns().init();
      }
      
      public function initGardenArray(ary:Array = null, issamedate:Boolean = true) : void
      {
         var i:* = 0;
         var obj:* = null;
         var alen:* = 0;
         trace("ary -->>" + ary);
         this.gardenList = [];
         for(i = uint(0); i < this.achieveLandLevel(); )
         {
            obj = {};
            obj.gid = i + 1;
            obj.date = this.dataObjectInstance.curDate;
            obj.type = this.dataObject.one;
            obj.plantingLevel = this.dataObject.zero;
            this.gardenList.push(obj);
            i++;
         }
         if(ary != null)
         {
            for(alen = uint(ary.length); alen-- > 0; )
            {
               if(this.gardenList[alen])
               {
                  this.gardenList[alen] = ary[alen];
                  if(!issamedate)
                  {
                     if(this.gardenList[alen].type == this.dataObject.four)
                     {
                        this.gardenList[alen].type = this.dataObject.one;
                        this.gardenList[alen].date = this.dataObjectInstance.curDate;
                     }
                  }
               }
            }
         }
      }
      
      public function getTotalTopLevel() : int
      {
         return this.dataObject.topLevel + this.dataObject.levelUpLimit;
      }
      
      public function findObjectByLandId(gid:uint) : Object
      {
         for(var glen:uint = this.gardenList.length; glen-- > 0; )
         {
            if(this.gardenList[glen].gid == gid)
            {
               return this.gardenList[glen];
            }
         }
         var obj:Object = {};
         obj.gid = gid;
         obj.date = this.dataObjectInstance.curDate;
         obj.type = this.dataObject.one;
         obj.plantingLevel = this.dataObject.zero;
         this.gardenList.push(obj);
         return obj;
      }
      
      public function achieveLandLevel() : int
      {
         if(!this.isHideDebug)
         {
            return this.dataObject.night;
         }
         if(this.dataObject.gardenExp < this.dataObject.onehundred)
         {
            return this.dataObject.one;
         }
         if(this.dataObject.gardenExp >= this.dataObject.onehundred && this.dataObject.gardenExp < this.dataObject.threehundred)
         {
            return this.dataObject.two;
         }
         if(this.dataObject.gardenExp >= this.dataObject.threehundred && this.dataObject.gardenExp < this.dataObject.sixhundred)
         {
            return this.dataObject.three;
         }
         if(this.dataObject.gardenExp >= this.dataObject.sixhundred && this.dataObject.gardenExp < this.dataObject.one_one_thd)
         {
            return this.dataObject.four;
         }
         if(this.dataObject.gardenExp >= this.dataObject.one_one_thd && this.dataObject.gardenExp < this.dataObject.one_eigth_thd)
         {
            return this.dataObject.five;
         }
         if(this.dataObject.gardenExp >= this.dataObject.one_eigth_thd && this.dataObject.gardenExp < this.dataObject.two_sevent_thd)
         {
            return this.dataObject.six;
         }
         if(this.dataObject.gardenExp >= this.dataObject.two_sevent_thd && this.dataObject.gardenExp < this.dataObject.three_night_thd)
         {
            return this.dataObject.seven;
         }
         if(this.dataObject.gardenExp >= this.dataObject.three_night_thd && this.dataObject.gardenExp < this.dataObject.five_four_thd)
         {
            return this.dataObject.eight;
         }
         if(this.dataObject.gardenExp >= this.dataObject.five_four_thd)
         {
            return this.dataObject.night;
         }
         return this.dataObject.one;
      }
      
      public function achieveLandGodLevel() : int
      {
         if(!this.isHideDebug)
         {
            return this.dataObject.five;
         }
         if(this.dataObject.landgodExp < this.dataObject.sixty)
         {
            return this.dataObject.one;
         }
         if(this.dataObject.landgodExp >= this.dataObject.sixty && this.dataObject.landgodExp < this.dataObject.one_two_hundred)
         {
            return this.dataObject.two;
         }
         if(this.dataObject.landgodExp >= this.dataObject.one_two_hundred && this.dataObject.landgodExp < this.dataObject.one_eight_hundred)
         {
            return this.dataObject.three;
         }
         if(this.dataObject.landgodExp >= this.dataObject.one_eight_hundred && this.dataObject.landgodExp < this.dataObject.two_four_hundred)
         {
            return this.dataObject.four;
         }
         if(this.dataObject.landgodExp >= this.dataObject.two_four_hundred)
         {
            return this.dataObject.five;
         }
         return this.dataObject.one;
      }
      
      public function doWhenQuitLogin() : void
      {
         this.isfirstread = true;
         this.isfirstinselectplace = true;
         this.gameVip = new GameVip();
         if(this.allTask)
         {
            this.allTask.newAllTask();
         }
         if(AllianceSprite.getInstance())
         {
            AllianceSprite.getInstance().destroy();
         }
         if(this.saveInter)
         {
            if(this.saveInter.getChildByName("SavingGameMask"))
            {
               this.saveInter.removeChild(this.saveInter.getChildByName("SavingGameMask"));
            }
            if(this.saveInter.parent)
            {
               this.saveInter.parent.removeChild(this.saveInter);
               this.saveInter = null;
            }
         }
      }
      
      public function addMysteriousshoptimes() : void
      {
         if(this.gameVip.vipsavelist[4] == false)
         {
            if(this.gameVip.getVipLevel() >= 2)
            {
               trace("add five times mysteriousshoptimes!!!");
               this.gameVip.vipsavelist[4] = true;
               this.dataObject.mysteriousshoptimes += 5;
            }
         }
      }
      
      public function isInSea() : Boolean
      {
         return this.curStageAndCurLevel.curStage == 10;
      }
      
      public function setLocalUserId(uid:String) : void
      {
         var flen:uint = uid.length;
         var rd:uint = Math.round(RandomControllor.getIns().getRandom() * flen);
         this.localuserid1 = uid.substr(0,rd);
         this.localuserid2 = uid.substr(rd,flen - rd);
         this.localuserid3 = AUtils.enCodeString(uid);
      }
      
      public function getLocalUserId() : String
      {
         if(this.localuserid1 + this.localuserid2 != AUtils.getDeCodeString(this.localuserid3))
         {
            throw new Error("数据被修改！");
         }
         return this.localuserid1 + this.localuserid2;
      }
      
      public function isInPk() : Boolean
      {
         if(this.isInRoom())
         {
            if(this.nodeInfo)
            {
               if(this.nodeInfo.GameMode == ArenaSprite.ARENASPRITE_MODE_1V1 || this.nodeInfo.GameMode == ArenaSprite.ARENASPRITE_MODE_HUNZHAN)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isInFuben() : Boolean
      {
         if(this.isInRoom())
         {
            if(this.nodeInfo)
            {
               if(this.nodeInfo.GameMode == ArenaSprite.ARENASPRITE_FUBEN1 || this.nodeInfo.GameMode == ArenaSprite.ARENASPRITE_FUBEN2)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isInHost() : Boolean
      {
         return this.nodeFloor == 2;
      }
      
      public function isInRoom() : Boolean
      {
         return this.nodeFloor == 3;
      }
      
      public function isInRoomOrSingleGame() : Boolean
      {
         return this.nodeFloor == 3 || this.nodeFloor == 0;
      }
      
      public function isSingleGame() : Boolean
      {
         return this.nodeFloor == 0;
      }
      
      public function isInWeiPkHost() : Boolean
      {
         return this.curStageAndCurLevel.curStage == 41 && this.curStageAndCurLevel.curLevel == 1;
      }
      
      public function isInWeiPk() : Boolean
      {
         return this.curStageAndCurLevel.curStage == 42 && this.curStageAndCurLevel.curLevel == 1;
      }
      
      public function getHeroBySidAndRoleId(sid:int, roleId:uint) : BaseHero
      {
         var bh:* = null;
         var i:int = 0;
         for(i = 0; i < this.pWorld.getOtherHeroArray().length; )
         {
            bh = this.pWorld.getOtherHeroArray()[i] as BaseHero;
            if(bh && bh.sid == sid && bh.getRoleId() == roleId)
            {
               return bh;
            }
            i++;
         }
         if(sid == this.sid)
         {
            if(this.hero1 && this.hero1.getRoleId() == roleId)
            {
               return this.hero1;
            }
            if(this.hero2 && this.hero2.getRoleId() == roleId)
            {
               return this.hero2;
            }
         }
         return null;
      }
      
      public function getPetBySidAndRoleId(sid:int, roleId:uint) : BasePet
      {
         var bp:* = null;
         var bh:BaseHero = this.getHeroBySidAndRoleId(sid,roleId);
         if(bh)
         {
            return bh.getPet();
         }
         return null;
      }
      
      public function getMutiUserBySidAndRoleId(sid:int, roleId:uint) : MutiUser
      {
         for each(var muti in this.pWorld.getOtherHeroUserArray())
         {
            if(muti.sid == sid && muti.roleId == roleId)
            {
               return muti;
            }
         }
         return null;
      }
      
      public function closeScoket() : void
      {
         ChatInFb.getIns().hide();
         this.sid = -1;
         this.roomOnwerSid = -1;
         this.nodeFloor = 0;
         this.isRoomOnwer = false;
         if(this.isServerOk)
         {
            this.isServerOk = false;
            if(this.server)
            {
               this.server.close();
            }
         }
         this.server = null;
      }
      
      public function sendSelfMutiUserInfo(roleId:uint) : void
      {
         var muti:* = null;
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            muti = this.getMutiUserBySidAndRoleId(this.sid,roleId);
            if(muti)
            {
               str = roleId + "," + muti.getMutiInfo();
               this.server.ins_bo_node(64,AUtils.stringToByteArray(str),true);
               this.server.submit(0);
            }
         }
      }
      
      public function sendSelfHpInfo(roleId:uint) : void
      {
         var muti:* = null;
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            muti = this.getMutiUserBySidAndRoleId(this.sid,roleId);
            if(muti)
            {
               ba = new ByteArray();
               ba.writeByte(roleId);
               ba.writeInt(muti.hp);
               ba.writeInt(muti.shp);
               this.server.ins_bo_node(1025,ba,true);
               this.server.submit(0);
            }
         }
      }
      
      public function sendPetAction(roleId:uint, action:String, posX:Number, posY:Number) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = roleId + "," + action + "," + posX + "," + posY;
            this.server.ins_bo_node(20,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function getUserInfoByUid(uid:uint) : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_fetch_user(1 | 2 | 4,uid);
            this.server.submit(33);
         }
      }
      
      public function getOtherPlayersInfo() : *
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_get_node(512);
            this.server.ins_return_to_param(2,true);
            this.server.ins_fetch_users(2 | 4,new ByteArray());
            this.server.submit(2);
         }
      }
      
      public function gameStart() : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_set_node(8192,1);
            this.server.ins_bo_node(769,new ByteArray());
            this.server.submit(0);
         }
      }
      
      public function sendGameCountdown() : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_bo_node(768,new ByteArray(),false);
            this.server.submit(0);
         }
      }
      
      public function getRoomInfo() : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_get_node(2);
            this.server.ins_get_node(4);
            this.server.ins_get_node(1024);
            this.server.ins_get_node(4096);
            this.server.ins_get_node(2048);
            this.server.submit(516);
         }
      }
      
      public function quitRoom() : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_goto_parent();
            this.server.submit(513);
         }
      }
      
      public function createRoom(params:Array, maxVisitors:uint) : void
      {
         var averageLevel:* = 0;
         var str:* = null;
         var ba:* = null;
         if(this.server && this.isServerOk)
         {
            this.nodeInfo.GameMode = params[1];
            this.nodeInfo.averLevel = this.getAverageLevel();
            this.nodeInfo.roomName = params[0];
            this.nodeInfo.mpInfo = params[2];
            averageLevel = uint(this.getAverageLevel());
            this.nodeInfo.averLevel = averageLevel;
            this.nodeInfo.singleIdPlayerNum = this.playNum;
            params.push(averageLevel);
            params.push(this.playNum);
            str = params.join(",");
            ba = AUtils.stringToByteArray(str);
            this.server.ins_auto_goto_child(1);
            this.server.ins_set_node(4,ba);
            this.server.ins_set_node(4096,maxVisitors);
            this.server.submit(512);
         }
      }
      
      public function filterChat(str:String) : String
      {
         var i:* = undefined;
         var word:* = null;
         if(!this.wordFilters)
         {
            return "*";
         }
         for(i = 0; i < this.wordFilters.length; )
         {
            word = this.wordFilters[i];
            if(word != "")
            {
               while(1)
               {
                  if(str.indexOf(word) == -1)
                  {
                     break;
                  }
                  str = str.replace(word,"*");
               }
            }
            i++;
         }
         return str;
      }
      
      public function sendChat(str:String) : void
      {
         var info:* = null;
      }
      
      public function sendOtherBuff(sid:int, roleId:uint, attackKind:String, params:Array = null) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = sid + "," + roleId + "," + attackKind + "," + (!!params ? params.join("|") : "");
            this.server.ins_bo_node(273,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendAttack(roleId:uint, attackKind:String, direct:uint, xx:Number, yy:Number, params:Array = null, initTimer:uint = 0) : void
      {
         var ba:* = null;
         var state:* = 0;
         var paramsString:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(roleId);
            state = uint(ActionStateConst.getInstence().getStateByAction(attackKind));
            ba.writeByte(state);
            ba.writeByte(direct);
            ba.writeShort(int(xx));
            ba.writeShort(int(yy));
            paramsString = params.join("|");
            ba.writeUTF(paramsString);
            ba.writeInt(initTimer);
            this.server.ins_bo_node(17,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendPetAttack(roleId:uint, attackKind:String, direct:uint, xx:Number, yy:Number, params:Array = null) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = roleId + "," + attackKind + "," + direct + "," + xx + "," + yy + "," + params.join("|");
            this.server.ins_bo_node(19,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function getDelay() : void
      {
         if(this.server && this.isServerOk)
         {
            this.lastDelayTime = getTimer();
            this.server.ins_nop();
            this.server.submit(16);
         }
      }
      
      public function sendRun(bh:BaseHero) : void
      {
         var str:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            str = bh.getRoleId() + "," + (!!bh.isLeft ? 1 : 0) + "," + (!!bh.isRight ? 1 : 0);
            this.server.ins_bo_node(9,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterWalk(bm:BaseMonster) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeShort(bm.entityId);
            ba.writeByte(!!bm.isLeft ? 1 : 0);
            ba.writeByte(!!bm.isRight ? 1 : 0);
            this.server.ins_bo_node(4096,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterCreate(entityId:uint, kind:uint, xx:Number, yy:Number) : void
      {
         var str:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            str = entityId + "," + kind + "," + xx + "," + yy;
            this.server.ins_bo_node(4097,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterWait(bm:BaseMonster) : void
      {
         var str:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            str = bm.entityId + "";
            this.server.ins_bo_node(4098,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterAction(bm:BaseMonster) : void
      {
         var ba:* = null;
         var state:* = 0;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeShort(bm.entityId);
            state = uint(ActionStateConst.getInstence().getStateByAction(bm.curAction));
            ba.writeByte(state);
            ba.writeShort(int(bm.x));
            ba.writeShort(int(bm.y));
            this.server.ins_bo_node(4099,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendBeHurtedByMonster(bh:BaseHero, entityId:uint, attackBackX:int, attackBackY:int) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(bh.getRoleId());
            ba.writeShort(entityId);
            ba.writeShort(attackBackX);
            ba.writeShort(attackBackY);
            this.server.ins_bo_node(4100,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterHpChange(bm:BaseMonster, hpChange:int) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeShort(bm.entityId);
            ba.writeInt(hpChange);
            this.server.ins_bo_node(4101,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterHurted(bm:BaseMonster, roleId:uint, attackBackX:int, attackBackY:int, initTimer:uint) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeShort(bm.entityId);
            ba.writeByte(roleId);
            ba.writeShort(attackBackX);
            ba.writeShort(attackBackY);
            ba.writeInt(initTimer);
            this.server.ins_bo_node(4102,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendMonsterBuff(bm:BaseMonster, buffName:String, time:uint) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeShort(bm.entityId);
            ba.writeUTF(buffName);
            ba.writeShort(time);
            this.server.ins_bo_node(4103,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendRoleWushuangStart(roleId:uint) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(roleId);
            this.server.ins_bo_node(4104,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendRoleWushuangOver(roleId:uint) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(roleId);
            this.server.ins_bo_node(4105,ba,true);
            this.server.submit(0);
         }
      }
      
      public function setMyData() : void
      {
         if(this.server && this.isServerOk)
         {
            this.server.ins_set_user(4,this.getSaveInfo());
            this.server.submit(0);
         }
      }
      
      public function sendDead(roleId:uint) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = roleId + ",";
            this.server.ins_bo_node(7,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendPetDead(roleId:uint) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = roleId + ",";
            this.server.ins_bo_node(113,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendHurt(hurt:int, sid:int, roleId:uint, action:String, attackBackX:int, attackBackY:int, initTimer:uint, isSetActionHurt:Boolean = true, isNeedToAttackBack:Boolean = true) : void
      {
         var ba:* = null;
         var state:* = 0;
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(roleId);
            ba.writeInt(hurt);
            ba.writeInt(sid);
            state = uint(ActionStateConst.getInstence().getStateByAction(action));
            ba.writeByte(state);
            ba.writeByte(attackBackX);
            ba.writeByte(attackBackY);
            ba.writeInt(initTimer);
            ba.writeByte(!!isSetActionHurt ? 1 : 0);
            ba.writeByte(!!isNeedToAttackBack ? 1 : 0);
            this.server.ins_bo_node(6,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendPetHurt(hurt:int, sid:int, roleId:uint, action:String, attackBackX:int, attackBackY:int, initTimer:uint, isSetActionHurt:Boolean = true, isNeedToAttackBack:Boolean = true) : void
      {
         var str:* = null;
         if(this.server && this.isServerOk)
         {
            str = roleId + "," + hurt + "," + sid + "," + action + "," + attackBackX + "," + attackBackY + "," + initTimer + "," + (!!isSetActionHurt ? 1 : 0) + "," + (!!isNeedToAttackBack ? 1 : 0);
            this.server.ins_bo_node(97,AUtils.stringToByteArray(str),true);
            this.server.submit(0);
         }
      }
      
      public function sendLorRInfo(bh:BaseHero) : void
      {
         var ba:* = null;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(bh.getRoleId());
            ba.writeByte(!!bh.isLeft ? 1 : 0);
            ba.writeByte(!!bh.isRight ? 1 : 0);
            this.server.ins_bo_node(5,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendWalkInfo(bh:BaseHero) : void
      {
         var ba:* = null;
         var state:* = 0;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(bh.getRoleId());
            state = uint(ActionStateConst.getInstence().getStateByAction(bh.getBBDC().getState()));
            ba.writeByte(state);
            ba.writeByte(!!bh.isLeft ? 1 : 0);
            ba.writeByte(!!bh.isRight ? 1 : 0);
            this.server.ins_bo_node(4,ba,true);
            this.server.submit(0);
         }
      }
      
      public function sendPosition(bh:BaseHero) : void
      {
         var ba:* = null;
         var state:* = 0;
         var xx:int = 0;
         var yy:int = 0;
         if(!this.nodeInfo.isStart)
         {
            return;
         }
         if(this.server && this.isServerOk)
         {
            ba = new ByteArray();
            ba.writeByte(bh.getRoleId());
            state = uint(ActionStateConst.getInstence().getStateByAction(bh.getBBDC().getState()));
            ba.writeByte(state);
            xx = int(bh.x);
            yy = int(bh.y);
            ba.writeShort(xx);
            ba.writeShort(yy);
            ba.writeByte(!!bh.isLeft ? 1 : 0);
            ba.writeByte(!!bh.isRight ? 1 : 0);
            this.server.ins_bo_node(3,ba,true);
            this.server.submit(0);
         }
      }
      
      public function getSaveInfo() : XML
      {
         var pi:* = null;
         var str:String = "<heros>";
         if(this.hero1 && this.hero1.getPlayer())
         {
            str += "<heros>";
            if(this.honorData && this.honorData.nicheng)
            {
               str += "<un>" + this.honorData.nicheng + "</un>";
            }
            else
            {
               str += "<un>" + this.sid + "</un>";
            }
            str += "<rid>" + this.hero1.getRoleId() + "</rid>";
            str += "<posX>" + this.hero1.x + "</posX>";
            str += "<posY>" + this.hero1.y + "</posY>";
            str += "<dir>" + this.hero1.getBBDC().getDirect() + "</dir>";
            str += "<level>" + this.hero1.roleProperies.getLevel() + "</level>";
            str += "<cloId>" + this.hero1.getCurClothId() + "</cloId>";
            str += "<weaId>" + this.hero1.getCurWeaponId() + "</weaId>";
            str += "<def>" + this.hero1.roleProperies.getDefense() + "</def>";
            str += "<mdef>" + this.hero1.roleProperies.getMagicDef() + "</mdef>";
            str += "<hp>" + this.hero1.roleProperies.getSHHP() + "</hp>";
            str += "<honor>" + this.honorData.honorName + "</honor>";
            str += "<job>" + this.honorData.jobName + "</job>";
            pi = this.hero1.getPlayer().findCurrentPet();
            if(pi)
            {
               str += "<petName>" + pi.getPetName() + "</petName>";
               str += "<petLv>" + pi.getLevel() + "</petLv>";
               str += "<petHp>" + pi.getHp() + "</petHp>";
               str += "<petMp>" + pi.getMp() + "</petMp>";
            }
            if(this.hero1.getCurMagicWeapon())
            {
               str += "<bmwId>" + this.hero1.getCurMagicWeapon().bmwId + "</bmwId>";
            }
            str += "</heros>";
         }
         if(this.hero2 && this.hero2.getPlayer())
         {
            str += "<heros>";
            if(this.honorData && this.honorData.nicheng)
            {
               str += "<un>" + this.honorData.nicheng + "</un>";
            }
            else
            {
               str += "<un>" + this.sid + "</un>";
            }
            str += "<rid>" + this.hero2.getRoleId() + "</rid>";
            str += "<posX>" + this.hero2.x + "</posX>";
            str += "<posY>" + this.hero2.y + "</posY>";
            str += "<dir>" + this.hero2.getBBDC().getDirect() + "</dir>";
            str += "<level>" + this.hero2.roleProperies.getLevel() + "</level>";
            str += "<cloId>" + this.hero2.getCurClothId() + "</cloId>";
            str += "<weaId>" + this.hero2.getCurWeaponId() + "</weaId>";
            str += "<hp>" + this.hero2.roleProperies.getSHHP() + "</hp>";
            str += "<def>" + this.hero2.roleProperies.getDefense() + "</def>";
            str += "<mdef>" + this.hero2.roleProperies.getMagicDef() + "</mdef>";
            str += "<honor>" + this.honorData.honorName + "</honor>";
            str += "<job>" + this.honorData.jobName + "</job>";
            pi = this.hero2.getPlayer().findCurrentPet();
            if(pi)
            {
               str += "<petName>" + pi.getPetName() + "</petName>";
               str += "<petLv>" + pi.getLevel() + "</petLv>";
               str += "<petHp>" + pi.getHp() + "</petHp>";
               str += "<petMp>" + pi.getMp() + "</petMp>";
            }
            if(this.hero2.getCurMagicWeapon())
            {
               str += "<bmwId>" + this.hero2.getCurMagicWeapon().bmwId + "</bmwId>";
            }
            str += "</heros>";
         }
         str += "</heros>";
         return new XML(str);
      }
      
      public function getAverageLevel() : uint
      {
         if(this.playNum == 1)
         {
            return this.player1.getCurLevel();
         }
         if(this.playNum == 2)
         {
            return (this.player1.getCurLevel() + this.player2.getCurLevel()) / 2;
         }
         return 0;
      }
      
      public function getAverageLevelNumber() : Number
      {
         if(this.playNum == 1)
         {
            return this.player1.getCurLevel();
         }
         if(this.playNum == 2)
         {
            return (this.player1.getCurLevel() + this.player2.getCurLevel()) / 2;
         }
         return 0;
      }
      
      public function destroyHero() : void
      {
         if(this.hero1)
         {
            this.hero1.destroy();
         }
         if(this.hero2)
         {
            this.hero2.destroy();
         }
         this.hero1 = null;
         this.hero2 = null;
      }
      
      public function newRole() : void
      {
      }
      
      public function checkPayForEquipment() : Boolean
      {
         if(this.gameVip.isToGetAllMoneyData)
         {
            if(this.gameVip.getAllMoney() > 0)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public function createHero() : void
      {
         this.hero1 = null;
         this.hero2 = null;
         this.hero3 = null;
         if(PlayerDatasControllor.getIns().playerDatas.length > 0)
         {
            for each(var pl in PlayerDatasControllor.getIns().playerDatas)
            {
               if(pl.data.uid != GameConst.UID)
               {
                  this.player2.roleid = pl.data.roleid;
                  this.player2.controlPlayer = 0;
               }
            }
         }
         PlayerDatasControllor.getIns().playerDatas.length = 0;
         this.pWorld.heroArray.length = 0;
         if(this.player1.roleid > 0)
         {
            this.hero1 = AUtils.getNewObj("export.hero.Role" + this.player1.roleid) as BaseHero;
            this.hero1.setPlayer(this.player1);
            this.keyboardControl.setRole1(this.hero1);
            this.vControllor.setRole1(this.hero1);
            this.hero1.x = 100;
            this.hero1.y = 350;
            this.player1.isRealiveByBagua = false;
         }
         if(this.player2.roleid > 0)
         {
            this.hero2 = AUtils.getNewObj("export.hero.Role" + this.player2.roleid) as BaseHero;
            this.hero2.setPlayer(this.player2);
            this.keyboardControl.setRole2(this.hero2);
            this.vControllor.setRole2(this.hero2);
            this.hero2.x = 150;
            this.hero2.y = 350;
            this.player2.isRealiveByBagua = false;
         }
         if(this.isFramePk)
         {
            if(this.player1.index <= this.player2.index)
            {
               if(this.hero1)
               {
                  this.hero1.x = 100;
                  this.hero1.start();
                  this.gameSence.addChild(this.hero1);
                  this.pWorld.heroArray.push(this.hero1);
               }
               if(this.hero2)
               {
                  this.hero2.x = 150;
                  this.hero2.start();
                  this.gameSence.addChild(this.hero2);
                  this.pWorld.heroArray.push(this.hero2);
               }
            }
            else
            {
               if(this.hero2)
               {
                  this.hero2.x = 100;
                  this.hero2.start();
                  this.pWorld.heroArray.push(this.hero2);
                  this.gameSence.addChild(this.hero2);
               }
               if(this.hero1)
               {
                  this.hero1.x = 150;
                  this.hero1.start();
                  this.pWorld.heroArray.push(this.hero1);
                  this.gameSence.addChild(this.hero1);
               }
            }
         }
         else
         {
            if(this.hero1)
            {
               this.hero1.start();
               this.pWorld.heroArray.push(this.hero1);
               this.gameSence.addChild(this.hero1);
            }
            if(this.hero2)
            {
               this.hero2.start();
               this.pWorld.heroArray.push(this.hero2);
               this.gameSence.addChild(this.hero2);
            }
         }
         if(!this.isCannotUsePlayer3())
         {
            if(this.player3.roleid > 0)
            {
               this.hero3 = AUtils.getNewObj("export.hero.Role" + this.player3.roleid) as BaseHero;
               this.hero3.setPlayer(this.player3);
               this.pWorld.heroArray.push(this.hero3);
               this.keyboardControl.setRole2(this.hero3);
               this.vControllor.setRole2(this.hero3);
               this.hero3.x = 100;
               this.hero3.y = 350;
               this.hero3.start();
               this.player3.isRealiveByBagua = false;
               this.gameSence.addChild(this.hero3);
            }
         }
      }
      
      public function isCannotUsePlayer3() : Boolean
      {
         var bool:Boolean = false;
         return Boolean(this.curStageAndCurLevel.curStage == 0 || this.curStageAndCurLevel.curStage == 42);
      }
      
      public function createHeroWhenQuitRoom() : void
      {
         if(this.hero1 && this.gameSence.contains(this.hero1))
         {
            if(this.hero1.getPet() && this.gameSence.contains(this.hero1.getPet()))
            {
               this.gameSence.removeChild(this.hero1.getPet());
            }
            this.gameSence.removeChild(this.hero1);
         }
         if(this.hero2 && this.gameSence.contains(this.hero2))
         {
            if(this.hero2.getPet() && this.gameSence.contains(this.hero2.getPet()))
            {
               this.gameSence.removeChild(this.hero2.getPet());
            }
            this.gameSence.removeChild(this.hero2);
         }
         this.createHero();
         var ttf:TextFormat = new TextFormat();
         ttf.size = 20;
         ttf.color = 16711680;
         if(this.hero1)
         {
            this.hero1.sid = this.sid == -1 ? 0 : this.sid;
            this.hero1.setNameTextField(this.sid + " P",ttf);
         }
         if(this.hero2)
         {
            this.hero2.sid = this.sid == -1 ? 0 : this.sid;
            this.hero2.setNameTextField(this.sid + " P",ttf);
         }
      }
      
      public function newGameClick() : void
      {
         this.curBigStage = 1;
         this.curBigLevel = 1;
         this.curStageAndCurLevel.curStage = 1;
         this.curStageAndCurLevel.curLevel = 1;
         this.hdInfo = [];
         this.luanqibazaojiami.saveId = -1;
         if(!this.isHideDebug)
         {
            this.curBigStage = 21;
            this.curBigLevel = 1;
         }
      }
      
      public function getMinIdxInHeroAndPet() : int
      {
         var idxTemp:int = 0;
         var minIdx:* = int(999);
         for each(var bo in this.getPlayerAndPetArray())
         {
            if(bo.parent == this.gameSence)
            {
               idxTemp = this.gameSence.getChildIndex(bo);
               if(idxTemp != -1)
               {
                  minIdx = minIdx > idxTemp ? idxTemp : minIdx;
               }
            }
         }
         if(minIdx == 999)
         {
            minIdx = int(0);
         }
         return minIdx;
      }
      
      public function getMinIdxInHero() : int
      {
         var idxTemp:int = 0;
         var minIdx:* = int(999);
         for each(var bo in this.getPlayerArray())
         {
            if(bo.parent == this.gameSence)
            {
               idxTemp = this.gameSence.getChildIndex(bo);
               if(idxTemp != -1)
               {
                  minIdx = minIdx > idxTemp ? idxTemp : minIdx;
               }
            }
         }
         if(minIdx == 999)
         {
            minIdx = int(0);
         }
         return minIdx;
      }
      
      public function destroyGame() : void
      {
         this.otherList = [];
         this.isLevelClear = false;
      }
      
      public function getUsersArray() : Array
      {
         var arr:Array = [];
         if(this.player1.index <= this.player2.index)
         {
            if(this.player1.roleid > 0)
            {
               arr.push(this.player1);
            }
            if(this.player2.roleid > 0)
            {
               arr.push(this.player2);
            }
         }
         else
         {
            if(this.player2.roleid > 0)
            {
               arr.push(this.player2);
            }
            if(this.player1.roleid > 0)
            {
               arr.push(this.player1);
            }
         }
         if(this.player3.roleid > 0)
         {
            arr.push(this.player3);
         }
         return arr;
      }
      
      public function getPlayerArray() : Array
      {
         var arr:Array = [];
         if(this.player1.index <= this.player2.index)
         {
            if(this.hero1 && !this.hero1.isDead())
            {
               arr.push(this.hero1);
            }
            if(this.hero2 && !this.hero2.isDead())
            {
               arr.push(this.hero2);
            }
         }
         else
         {
            if(this.hero2 && !this.hero2.isDead())
            {
               arr.push(this.hero2);
            }
            if(this.hero1 && !this.hero1.isDead())
            {
               arr.push(this.hero1);
            }
         }
         if(this.hero3 && !this.hero3.isDead())
         {
            arr.push(this.hero3);
         }
         return arr;
      }
      
      public function getPetArray() : Array
      {
         var i:int = 0;
         var bh:* = null;
         var arr:Array = [];
         var bhArr:Array = this.getPlayerArray();
         for(i = 0; i < bhArr.length; )
         {
            bh = bhArr[i];
            if(bh.getPet())
            {
               arr.push(bh.getPet());
            }
            i++;
         }
         return arr;
      }
      
      public function getPlayerAndPetArray() : Array
      {
         var i:int = 0;
         var bh:* = null;
         var arr:Array = [];
         var bhArr:Array = this.getPlayerArray();
         for(i = 0; i < bhArr.length; )
         {
            bh = bhArr[i];
            arr.push(bh);
            if(bh.getPet())
            {
               arr.push(bh.getPet());
            }
            i++;
         }
         return arr;
      }
      
      public function getPlayerAndPetAndSummonArray() : Array
      {
         var arr:Array = [];
         if(this.hero1 && !this.hero1.isDead())
         {
            arr.push(this.hero1);
            if(this.hero1.getPet())
            {
               arr.push(this.hero1.getPet());
            }
            if(this.hero1.getSummon())
            {
               arr.push(this.hero1.getSummon());
            }
         }
         if(this.hero2 && !this.hero2.isDead())
         {
            arr.push(this.hero2);
            if(this.hero2.getPet())
            {
               arr.push(this.hero2.getPet());
            }
            if(this.hero2.getSummon())
            {
               arr.push(this.hero2.getSummon());
            }
         }
         if(this.hero3 && !this.hero3.isDead())
         {
            arr.push(this.hero3);
            if(this.hero3.getPet())
            {
               arr.push(this.hero3.getPet());
            }
            if(this.hero3.getSummon())
            {
               arr.push(this.hero3.getSummon());
            }
         }
         return arr;
      }
      
      public function getRandomPlayer() : BaseHero
      {
         var rand:int = RandomControllor.getIns().getRandom() * this.getPlayerArray().length;
         return this.getPlayerArray()[rand];
      }
      
      public function getSomeOneEquipNumberByName(fillname:String) : uint
      {
         var i:* = 0;
         var temp:* = null;
         var dlen:uint = this.djlist.length;
         for(i = uint(0); i < dlen; )
         {
            temp = this.djlist[i];
            if(temp.getFillName() == fillname)
            {
               return temp.getENum();
            }
            i++;
         }
         return 0;
      }
      
      public function judgeDJBackPack(player:User, _fname:String) : Boolean
      {
         var wplayer:* = null;
         if(player.getSomeOneEquipNumberByName(_fname) <= 0 && player.djlist.length >= player.getMax())
         {
            wplayer = "玩家一";
            if(player.controlPlayer == 0)
            {
               wplayer = "玩家一";
            }
            else
            {
               wplayer = "玩家二";
            }
            this.ts.setTxt(wplayer + "背包道具已满!");
            this.stage.addChild(this.ts);
            return true;
         }
         return false;
      }
      
      public function judgeBackPack(player:User, bname:String) : Boolean
      {
         var wplayer:String = "玩家一";
         if(player.controlPlayer == 0)
         {
            wplayer = "玩家一";
         }
         else
         {
            wplayer = "玩家二";
         }
         if(player[bname].length >= player.getMax())
         {
            this.ts.setTxt(wplayer + "背包已满!");
            this.stage.addChild(this.ts);
            return true;
         }
         return false;
      }
      
      public function putQhsInBackPack(player:User, _name:String, num:int = 1, _isshop:Boolean = false, _isask:Boolean = false) : void
      {
         if(_name.indexOf("jns") != -1)
         {
            player.jnslist = this.putQHsInArray(_name,player.jnslist,num,_isshop,_isask,player);
         }
         else
         {
            player.djlist = this.putQHsInArray(_name,player.djlist,num,_isshop,_isask,player);
         }
      }
      
      public function putQHsInArray(_name:String, inarr:Array = null, num:int = 1, _isshop:Boolean = false, _isask:Boolean = false, _player:User = null) : Array
      {
         var newMyEquip:* = null;
         var obj:* = null;
         var temp:* = null;
         var ary:* = null;
         temp = null;
         for(var wplen:uint = inarr.length; wplen-- > 0; )
         {
            if(_name == inarr[wplen].getFillName())
            {
               newMyEquip = inarr[wplen];
               break;
            }
         }
         trace("_isshop -->" + _isshop + " _isask -->" + _isask);
         if(newMyEquip != null)
         {
            newMyEquip.setNum(num);
            if(this.isHideDebug)
            {
               if(_isshop)
               {
                  newMyEquip.setShopAttribute(newMyEquip.getShopAttribtue() + num);
               }
               if(_isask)
               {
                  obj = [];
                  if(_isshop)
                  {
                     obj.push(FinancialInfo.getItemIdByName(newMyEquip.getFillName(),0));
                  }
                  else
                  {
                     obj.push(FinancialInfo.getItemIdByName(newMyEquip.getFillName(),1));
                  }
                  obj.push(1);
                  obj.push(num);
                  if(_player)
                  {
                     temp = _player.getSomeEquipInPackBackByName(newMyEquip.getFillName());
                     temp && obj.push(temp.getENum());
                  }
                  FinancialInfo.sendInfoToFinancialServer(this.logInfo.uid,[obj],this.getTimeStamp(),this.gameVip.dataObject.lastMoney);
               }
            }
            this.eventManger.dispatchEvent(new Event("CHANGETXT"));
         }
         else
         {
            newMyEquip = allEquip.findByName(_name);
            newMyEquip.setnum(num);
            if(this.isHideDebug)
            {
               if(_isshop)
               {
                  newMyEquip.setShopAttribute(newMyEquip.getShopAttribtue() + num);
               }
               if(_isask)
               {
                  ary = [];
                  if(_isshop)
                  {
                     ary.push(FinancialInfo.getItemIdByName(newMyEquip.getFillName(),0));
                  }
                  else
                  {
                     ary.push(FinancialInfo.getItemIdByName(newMyEquip.getFillName(),1));
                  }
                  ary.push(1);
                  ary.push(num);
                  if(_player)
                  {
                     temp = _player.getSomeEquipInPackBackByName(newMyEquip.getFillName());
                     temp && obj.push(temp.getENum());
                  }
                  trace("newMyEquip is null stage-ary->>" + ary);
                  FinancialInfo.sendInfoToFinancialServer(this.logInfo.uid,[ary],this.getTimeStamp(),this.gameVip.dataObject.lastMoney);
               }
            }
            inarr.push(newMyEquip);
         }
         return inarr;
      }
      
      public function renewalseEquip(_whichplayer:uint, _rwequip:MyEquipObj) : void
      {
         this.rwequipfn = _rwequip;
         this.whichplayer = _whichplayer;
         if(rwequipfn.getFillName() == "ptsmsrsz" || rwequipfn.getFillName() == "yxsmsrsz" || rwequipfn.getFillName() == "jlsmsrsz" || rwequipfn.getFillName() == "sssmsrsz")
         {
            this.dataObject.szxfprice = 100;
         }
         else
         {
            this.dataObject.szxfprice = 500;
         }
         if(this.gameVip.dataObject.lastMoney < this.dataObject.szxfprice)
         {
            this.ts.setTxt("账户余额不足");
            this.stage.addChild(this.ts);
         }
         else
         {
            pay.money = int(this.dataObject.szxfprice);
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(9,"道具9",pay.money,1);
               this.lastPaymentString = "ConfigRenewalseEquipment";
               this.addActionMask("renewalse");
            }
         }
      }
      
      public function getAllMoney(money:uint) : void
      {
         this.gameVip.dataObject.lastMoney = money;
      }
      
      public function renewalseSuccess(last:uint) : void
      {
         var etemp:* = null;
         var _ename:* = null;
         if(this.lastPaymentString != "ConfigRenewalseEquipment")
         {
            return;
         }
         this.lastPaymentString = "";
         var exictmask:Sprite = this.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            this.stage.removeChild(exictmask);
            exictmask = null;
         }
         this.gameVip.dataObject.lastMoney = last;
         if(this.rwequipfn)
         {
            etemp = this.allEquip.findByName(this.rwequipfn.getFillName());
            this.rwequipfn.instruction = etemp.instruction;
            this.rwequipfn.setFashionTime(this.dataObjectInstance.curDate);
            _ename = this.rwequipfn.getFillName();
            if(this.rwequipfn.getFillName() == "ptsmsrsz" || this.rwequipfn.getFillName() == "yxsmsrsz" || this.rwequipfn.getFillName() == "jlsmsrsz" || this.rwequipfn.getFillName() == "sssmsrsz")
            {
               FinancialInfo.sendInfoToFinancialServer(this.logInfo.uid,[[{
                  "id":10360,
                  "ename":_ename
               },1,1],[{
                  "id":10360,
                  "ename":_ename
               },0,1]],this.getTimeStamp(),this.gameVip.dataObject.lastMoney);
            }
            else
            {
               FinancialInfo.sendInfoToFinancialServer(this.logInfo.uid,[[{
                  "id":10350,
                  "ename":_ename
               },1,1],[{
                  "id":10350,
                  "ename":_ename
               },0,1]],this.getTimeStamp(),this.gameVip.dataObject.lastMoney);
            }
         }
         if(this.isHideDebug)
         {
            this.memory.setStorage(this.luanqibazaojiami.saveId);
         }
      }
      
      public function renewalseFail() : void
      {
         var exictmask:Sprite = this.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            this.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      public function addActionMask(mark:String = "") : void
      {
         var s:* = null;
         var exictmask:Sprite = this.stage.getChildByName("execuitionAction" + mark) as Sprite;
         if(exictmask == null)
         {
            s = AUtils.getNewObj("mask" + mark) as Sprite;
            s.name = "execuitionAction" + mark;
            this.stage.addChild(s);
         }
         else
         {
            trace("The Action Mask has already excist");
         }
      }
      
      public function removedActionMask(mark:String = "") : void
      {
         var exictmask:Sprite = this.stage.getChildByName("execuitionAction" + mark) as Sprite;
         if(exictmask)
         {
            this.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      public function getPetSaveString() : String
      {
         var i:* = 0;
         var plen:uint = this.petlist.length;
         var saveStr:String = "";
         for(i = uint(0); i < plen; )
         {
            saveStr += PetInfo(this.petlist[i]).getSaveString();
            if(i != plen - 1)
            {
               saveStr += "}";
            }
            i++;
         }
         return saveStr;
      }
      
      public function savePetSaveString(data:String) : void
      {
         var plen:* = 0;
         var pet:* = null;
         var dataXml:XML = Aloader2.getInstance().decryptXml();
         this.dataXml = dataXml;
         this.petlist.length = 0;
         var dataArray:Array = data.split("}");
         for(var dlen:uint = dataArray.length; dlen-- > 0; )
         {
            if(dataArray[dlen] != "")
            {
               plen = uint(this.petlist.length);
               pet = new PetInfo();
               pet.setSaveString(dataArray[dlen]);
               pet.checkDataAbnormal(dataXml.pet.gamepet.(@petname == pet.getPetPreName()));
               this.petlist.push(pet);
            }
         }
      }
      
      public function requestData(cb:Function) : void
      {
         this.requestDataCb = cb;
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         urlLoader.addEventListener("ioError",__requestDataError);
         urlLoader.addEventListener("securityError",__requestDataError);
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time&" + RandomControllor.getIns().getRandom()));
      }
      
      private function __requestDataError(evt:Event) : void
      {
         urlLoader.load(new URLRequest("https://save.api.4399.com/?ac=get_time&" + RandomControllor.getIns().getRandom()));
      }
      
      public function completeHandler(data:*) : void
      {
         var ary:* = null;
         var jObj:* = undefined;
         var baxianArr:* = null;
         var idx:int = 0;
         var timeData:String = "";
         if(data is Event)
         {
            urlLoader.removeEventListener("complete",completeHandler);
            urlLoader.removeEventListener("ioError",__requestDataError);
            urlLoader.removeEventListener("securityError",__requestDataError);
            jObj = JSON.parse(urlLoader.data);
            ary = String(jObj["time"]).split(" ");
         }
         else
         {
            timeData = data;
            if(timeData == "")
            {
               this.ts.setTxt("获取时间失败！请刷新网页");
               this.stage.addChild(this.ts);
               return;
            }
            ary = timeData.split(" ");
         }
         this.dataObjectInstance.curDate = ary[0];
         this.dataObjectInstance.curTime = ary[1];
         this.dataObject.yestoday = this.dataObjectInstance.curDate;
         var dayAry1:Array = this.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date:Date = new Date(year1,month1,day1);
         var nowTime:Number = date.getTime();
         var diffTime:Number = nowTime - this.xunhuanStartTime;
         trace("nowTime:" + nowTime);
         trace("diffTime:" + diffTime);
         if(diffTime >= 0)
         {
            this.diffDays = diffTime / 86400000;
            this.diffWeeks = this.diffDays / 7;
            trace("this.diffDays：" + this.diffDays);
            trace("this.diffWeeks：" + this.diffWeeks);
            this.allTask = new GameTask();
            this.allTask.newAllTask();
            baxianArr = [163,175,165,166,168,169,174,164];
            idx = this.diffWeeks % 8;
            this.baxianMonsterId = baxianArr[idx];
         }
         if(this.requestDataCb)
         {
            this.requestDataCb();
            this.requestDataCb = null;
         }
      }
      
      public function getTimeStamp() : int
      {
         var ary:Array = String(this.dataObjectInstance.curDate).split("-");
         var date:Date = new Date(ary[0],ary[1],ary[2]);
         return date.getTime() / 1000;
      }
      
      public function findLhValueBySkillName(str:String) : int
      {
         var sit:int = 0;
         var slen:uint = this.allSklName.length;
         var ary:Array = [];
         for(var nary:Array = []; slen-- > 0; )
         {
            ary = this.allSklName[slen];
            if(ary)
            {
               sit = ary.indexOf(str);
               if(sit != -1)
               {
                  nary = this.needMMP[slen];
                  if(nary)
                  {
                     return nary[sit];
                  }
                  return 0;
               }
            }
         }
         return 0;
      }
      
      public function findOneTimeGoodsByFillName(_fillname:String) : Boolean
      {
         if(_fillname == "wpqhs1" || _fillname == "wpqhs2" || _fillname == "wpqhs3" || _fillname == "wpqhs4" || _fillname == "sms2" || _fillname == "sms3" || _fillname == "mfs2" || _fillname == "mfs3" || _fillname == "gjs2" || _fillname == "gjs3" || _fillname == "fys2" || _fillname == "fys3" || _fillname == "wpxyf" || _fillname == "wpbdf" || _fillname == "wptlz" || _fillname == "wpllz" || _fillname == "wphlz" || _fillname == "wpflz" || _fillname == "wpslz" || _fillname == "lhys" || _fillname == "jyd3" || _fillname == "djyys" || _fillname == "css_2" || _fillname == "mpyj" || _fillname == "css12" || _fillname == "css18" || _fillname == "sbjyd" || _fillname == "jyys" || _fillname == "wpcsd" || _fillname == "wphhd" || _fillname == "cwzzxld" || _fillname == "cwjnxld")
         {
            return true;
         }
         return false;
      }
      
      public function getAllAnalyzeConstellationsLevelSum() : int
      {
         var cary:Array = String(this.dataObject.constellationsLevel).split("_") as Array;
         var clen:uint = cary.length;
         for(var levelSum:uint = 0; clen-- > 0; )
         {
            if(int(cary[clen]) > 0)
            {
               levelSum += int(cary[clen]);
            }
         }
         return levelSum;
      }
      
      public function getAnalyzeConstellationsLevel(ws:int) : int
      {
         var cary:Array = String(this.dataObject.constellationsLevel).split("_") as Array;
         if(cary[ws - 1] != undefined)
         {
            return cary[ws - 1];
         }
         return 0;
      }
      
      public function setAnalyzeConstellationsLevel(bid:uint, level:int) : void
      {
         var j:* = 0;
         var i:* = 0;
         if(level > 10)
         {
            level = 10;
         }
         var bool:Boolean = false;
         var cary:Array = String(this.dataObject.constellationsLevel).split("_") as Array;
         if(cary[bid - 1] != undefined)
         {
            if(cary[bid - 1] < level)
            {
               cary[bid - 1] = level;
               bool = true;
            }
         }
         else
         {
            for(j = uint(8); j < bid; )
            {
               if(cary[j] == undefined)
               {
                  if(j != bid)
                  {
                     cary.push(0);
                  }
                  else
                  {
                     cary.push(level);
                  }
               }
               j++;
            }
            bool = true;
         }
         var clen:uint = cary.length;
         this.dataObject.constellationsLevel = "";
         for(i = uint(0); i < clen; )
         {
            this.dataObject.constellationsLevel += cary[i] + "";
            if(i != clen - 1)
            {
               this.dataObject.constellationsLevel += "_";
            }
            i++;
         }
         if(bool)
         {
            if(this.isHideDebug)
            {
               this.memory.setStorage(this.luanqibazaojiami.saveId);
            }
         }
      }
      
      public function judgeFourPhalanx(phalanx:uint) : Boolean
      {
         var fary:Array = String(this.dataObject.fourPhalanx).split("_") as Array;
         var tag:uint = 0;
         if(phalanx == 0)
         {
            tag = 0;
         }
         else if(phalanx == 1)
         {
            tag = 1;
         }
         else if(phalanx == 2)
         {
            tag = 2;
         }
         else if(phalanx == 3)
         {
            tag = 3;
         }
         var ary:Array = String(fary[tag]).split("-") as Array;
         var _value1:uint = ary[0];
         var _value2:uint = ary[1];
         if(_value1 >= 10 && _value2 >= 10)
         {
            return true;
         }
         return false;
      }
      
      public function setAnalyzeFourPhalanx(phalanx:uint) : void
      {
         var i:* = 0;
         var fary:Array = String(this.dataObject.fourPhalanx).split("_") as Array;
         var tag:uint = 0;
         if(phalanx == 0)
         {
            tag = 0;
         }
         else if(phalanx == 1)
         {
            tag = 1;
         }
         else if(phalanx == 2)
         {
            tag = 2;
         }
         else if(phalanx == 3)
         {
            tag = 3;
         }
         var ary:Array = String(fary[tag]).split("-") as Array;
         var _value1:uint = int(ary[1]);
         var _value2:uint = int(ary[0]);
         _value1++;
         ary[1] = _value1;
         if(ary[1] > 10)
         {
            if(_value2 < 10)
            {
               _value2++;
               ary[0] = _value2;
               ary[1] = 1;
            }
            else
            {
               ary[1] = 10;
            }
         }
         fary[tag] = ary[0] + "-" + ary[1];
         var clen:uint = fary.length;
         this.dataObject.fourPhalanx = "";
         for(i = uint(0); i < clen; )
         {
            this.dataObject.fourPhalanx += fary[i] + "";
            if(i != clen - 1)
            {
               this.dataObject.fourPhalanx += "_";
            }
            i++;
         }
      }
      
      public function getPhalanxStone(phalanx:uint) : Array
      {
         var cary:Array = String(this.dataObject.cliffordStone).split("_") as Array;
         var tag:uint = 0;
         if(phalanx == 0)
         {
            tag = 0;
         }
         else if(phalanx == 1)
         {
            tag = 1;
         }
         else if(phalanx == 2)
         {
            tag = 2;
         }
         else if(phalanx == 3)
         {
            tag = 3;
         }
         return String(cary[tag]).split("-") as Array;
      }
      
      public function setCliffordStone(stoneName:String, stoneNum:int) : void
      {
         var i:* = 0;
         var tag:uint = 0;
         var secondTag:uint = 0;
         var cary:Array = String(this.dataObject.cliffordStone).split("_") as Array;
         if(stoneName == "zqjystone" || stoneName == "zqymstone")
         {
            tag = 0;
            if(stoneName == "zqjystone")
            {
               secondTag = 0;
            }
            else
            {
               secondTag = 1;
            }
         }
         if(stoneName == "xwjystone" || stoneName == "xwljstone")
         {
            tag = 1;
            if(stoneName == "xwjystone")
            {
               secondTag = 0;
            }
            else
            {
               secondTag = 1;
            }
         }
         var ary:Array = String(cary[tag]).split("-") as Array;
         var _value:uint = int(ary[secondTag]);
         _value += stoneNum;
         ary[secondTag] = _value;
         cary[tag] = ary[0] + "-" + ary[1];
         var clen:uint = cary.length;
         this.dataObject.cliffordStone = "";
         for(i = uint(0); i < clen; )
         {
            this.dataObject.cliffordStone += cary[i] + "";
            if(i != clen - 1)
            {
               this.dataObject.cliffordStone += "_";
            }
            i++;
         }
      }
      
      public function setNewYearThreeTreasure(treasureName:String, treasureNum:int) : void
      {
         var i:* = 0;
         var tag:uint = 0;
         var yary:Array = String(this.dataObject.yh_bz_dl).split("_") as Array;
         if(treasureName == "yh")
         {
            tag = 0;
         }
         else if(treasureName == "bz")
         {
            tag = 1;
         }
         else if(treasureName == "dl")
         {
            tag = 2;
         }
         var _value:uint = int(yary[tag]);
         _value += treasureNum;
         yary[tag] = _value;
         var clen:uint = yary.length;
         this.dataObject.yh_bz_dl = "";
         for(i = uint(0); i < clen; )
         {
            this.dataObject.yh_bz_dl += yary[i] + "";
            if(i != clen - 1)
            {
               this.dataObject.yh_bz_dl += "_";
            }
            i++;
         }
      }
      
      public function getNewYearThreeTreasure(treasureName:String) : uint
      {
         var tag:uint = 0;
         var yary:Array = String(this.dataObject.yh_bz_dl).split("_") as Array;
         if(treasureName == "yh")
         {
            tag = 0;
         }
         else if(treasureName == "bz")
         {
            tag = 1;
         }
         else if(treasureName == "dl")
         {
            tag = 2;
         }
         return int(yary[tag]);
      }
      
      public function startSaveTimer() : void
      {
         if(!this.saveTimer)
         {
            this.saveTimer = new Timer(1000);
            this.saveTimer.addEventListener("timer",__timer);
         }
         if(this.saveIntervelCount != 0)
         {
            this.saveTimer.start();
         }
      }
      
      protected function __timer(evt:TimerEvent) : void
      {
         if(this.saveIntervelCount > 0)
         {
            this.saveIntervelCount--;
         }
         else
         {
            this.saveTimer.stop();
            this.saveTimer.reset();
         }
      }
      
      public function getPetSwfNameByPetName(name:String) : String
      {
         trace("getPetSwfNameByPetName==================name:" + name);
         var returnString:String = "";
         switch(name)
         {
            case "nian":
               returnString = "nianv1040";
               break;
            case "monkey":
               returnString = "monkeyv690";
               break;
            case "horse":
               returnString = "horsev680";
               break;
            case "tigress":
               returnString = "tigressv680";
               break;
            case "turtle":
               returnString = "turtlev680";
               break;
            case "phoenix":
               returnString = "phoenixv680";
               break;
            case "dragon":
               returnString = "dragonv680";
               break;
            case "rabbit":
               returnString = "rabbitv680";
               break;
            case "ufo":
               returnString = "ufov680";
               break;
            case "mouse":
               returnString = "mousev790";
               break;
            case "neat":
               returnString = "neat";
               break;
            case "roomhorse":
               returnString = "roomhorse";
               break;
            case "terribletiger":
               returnString = "yintiger";
         }
         return returnString;
      }
      
      public function getRoleSwfNameByRoleName(name:String) : String
      {
         var returnString:String = "";
         switch(name)
         {
            case "Role1":
               returnString = "Role1v690";
               break;
            case "Role2":
               returnString = "Role2v3550";
               break;
            case "Role3":
               returnString = "Role3v690";
               break;
            case "Role4":
               returnString = "Role4v3550";
         }
         return returnString;
      }
      
      public function getMonsterById(entityId:uint) : BaseMonster
      {
         for each(var bm in this.pWorld.monsterArray)
         {
            if(bm.entityId == entityId)
            {
               return bm;
            }
         }
         return null;
      }
      
      public function checkWebUid() : Boolean
      {
         if(!this.isHideDebug)
         {
            return true;
         }
         var webuid:Number = ExternalInterface.call("UniLogin.getUid");
         var myUid:Number = this.logInfo.uid;
         DebugArea.getIns().traceOut("checkWebUid--webuid:" + webuid + ",myuid:" + myUid);
         return webuid == myUid;
      }
      
      public function getNoSignDay() : String
      {
         var i:* = 0;
         var dary:Array = this.dataObjectInstance.curDate.split("-");
         var tary:Array = this.dataObject.newyear_2016_mark.split("-");
         var curDay:int = int(dary[2]);
         for(i = uint(7); i <= 14; )
         {
            if(tary.indexOf(i + "") == -1)
            {
               if(curDay != i)
               {
                  return i + "";
               }
               return "";
            }
            if(curDay == i)
            {
               return "";
            }
            i++;
         }
         return "";
      }
      
      public function signAgainDay(_day:String) : void
      {
         this.dataObject.newyear_2016_mark += _day + "-";
      }
      
      public function showReadSaveInter() : void
      {
         if(!this.saveInter)
         {
            this.saveInter = AUtils.getNewObj("export.saveInterface.SaveInter") as SaveInter;
         }
         this.saveInter.state = "read";
         this.stage.addChild(this.saveInter);
      }
      
      public function doWhenSecondLogout() : void
      {
         this.player3 = new User();
         this.player3.init(1);
         AllianceSecondInterface.getIns().honorData = null;
      }
      
      public function openUrl(url:String) : void
      {
         if(this.isAirGame)
         {
            ExternalInterface.call("openUrl",url);
         }
         else
         {
            navigateToURL(new URLRequest(url),"_blank");
         }
      }
      
      public function openPay() : void
      {
         var param:Object = {
            "index":3,
            "username":this.logInfo.name,
            "role":this.logInfo.nickName
         };
         ExternalInterface.call("openPay",JSON.stringify(param));
      }
      
      public function goBack() : void
      {
         ExternalInterface.call("goBack");
      }
   }
}
