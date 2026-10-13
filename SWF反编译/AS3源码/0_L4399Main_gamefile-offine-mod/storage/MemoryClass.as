package storage
{
   import config.Config;
   import event.CommonEvent;
   import export.HeroBuff;
   import export.saveInterface.SaveInter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.SharedObject;
   import my.DebugArea;
   import my.DescribeClass;
   
   public class MemoryClass
   {
       
      
      private var gc:Config;
      
      public var so:SharedObject;
      
      private var mystorage:Object;
      
      private var secondStorage:Object;
      
      private var sevenstorage:Object;
      
      private var saveIndex:uint;
      
      private var date:Date;
      
      public function MemoryClass()
      {
         this.date = new Date();
         super();
         gc = Config.getInstance();
         if(gc.eventManger.hasEventListener("SaveGame"))
         {
            gc.eventManger.removeEventListener("SaveGame",saveGame);
            gc.eventManger.addEventListener("SaveGame",saveGame,false,0,true);
         }
         else
         {
            gc.eventManger.addEventListener("SaveGame",saveGame,false,0,true);
         }
         if(gc.eventManger.hasEventListener("ReadGame"))
         {
            gc.eventManger.removeEventListener("ReadGame",readGame);
            gc.eventManger.addEventListener("ReadGame",readGame,false,0,true);
         }
         else
         {
            gc.eventManger.addEventListener("ReadGame",readGame,false,0,true);
         }
         initSharedObject();
      }
      
      public function getStorage(storage:Object = null) : void
      {
         var cary:Array = null;
         var clen:* = 0;
         var i:* = 0;
         var santaiziTimes:int = 0;
         var buffObj:Object = null;
         var gcVersion:String = null;
         var readVersion:String = null;
         var gcNum:Number = Number(NaN);
         var readNum:Number = Number(NaN);
         var read:* = storage || this.mystorage;
         if(read)
         {
            if(read.luserid)
            {
               if(gc.getLocalUserId() != read.luserid)
               {
                  gc.ts.setTxt("存档用户名不符合");
                  gc.stage.addChild(gc.ts);
                  return;
               }
            }
            trace("getStorage--->获得等级加成");
            if(read.levelUpLimit != undefined)
            {
               gc.dataObject.levelUpLimit = read.levelUpLimit;
               if(gc.dataObject.levelUpLimit > gc.dataObject.maxLevelUpLimit)
               {
                  gc.dataObject.levelUpLimit = gc.dataObject.maxLevelUpLimit;
               }
            }
            trace("getStorage--->人物装备");
            gc.playNum = read.playerNum;
            gc.hasget = read.hasget;
            gc.hasgetsorry = read.hasgetsorry;
            if(read.player1_obj != undefined)
            {
               gc.player1.setSaveObj(read.player1_obj);
            }
            if(read.player2_obj != undefined)
            {
               gc.player2.setSaveObj(read.player2_obj);
            }
            trace("getStorage--->各种信息");
            gc.curBigLevel = read.curBigLevel;
            gc.curBigStage = read.curBigStage;
            trace("getStorage--->关卡信息");
            gc.savedBuffString = read.savedBuffString;
            gc.savedBuff.setFromMemory(gc.savedBuffString);
            trace("getStorage--->全局buff");
            if(read.mysterioustimes != undefined)
            {
               gc.dataObject.mysteriousshoptimes = read.mysterioustimes;
            }
            if(read.hasGetZhuZhangTYActivity != undefined)
            {
               gc.dataObject.hasGetZhuZhangTYActivity = read.hasGetZhuZhangTYActivity;
            }
            if(read.hasGetGameBoxActivity != undefined)
            {
               gc.dataObject.hasGetGameBoxActivity = read.hasGetGameBoxActivity;
            }
            if(read.hasGetKaPai_9_Activity != undefined)
            {
               gc.dataObject.hasGetKaPai_9_Activity = read.hasGetKaPai_9_Activity;
            }
            if(read.hasGetKaPai_1_Activity != undefined)
            {
               gc.dataObject.hasGetKaPai_1_Activity = read.hasGetKaPai_1_Activity;
            }
            if(read.hasWeiXin10Activity != undefined)
            {
               gc.dataObject.hasWeiXin10Activity = read.hasWeiXin10Activity;
            }
            if(read.hasWeiXin8Activity != undefined)
            {
               gc.dataObject.hasWeiXin8Activity = read.hasWeiXin8Activity;
            }
            if(read.hasWeiXin9Activity != undefined)
            {
               gc.dataObject.hasWeiXin9Activity = read.hasWeiXin9Activity;
            }
            if(read.hasGetKaiXuePresent != undefined)
            {
               gc.dataObject.hasGetKaiXuePresent = read.hasGetKaiXuePresent;
            }
            if(read.hasFifteenYearActivity != undefined)
            {
               gc.dataObject.hasFifteenYearActivity = read.hasFifteenYearActivity;
            }
            if(read.hasWeiXinBaoXiaoActivity != undefined)
            {
               gc.dataObject.hasWeiXinBaoXiaoActivity = read.hasWeiXinBaoXiaoActivity;
            }
            if(read.hasDWWeiXinBaoXiaoActivity != undefined)
            {
               gc.dataObject.hasDWWeiXinBaoXiaoActivity = read.hasDWWeiXinBaoXiaoActivity;
            }
            if(read.hasDWWeiXinBaoXiaoSj2Activity != undefined)
            {
               gc.dataObject.hasDWWeiXinBaoXiaoSj2Activity = read.hasDWWeiXinBaoXiaoSj2Activity;
            }
            if(read.hasWuYiBaoXiaoSjActivity != undefined)
            {
               gc.dataObject.hasWuYiBaoXiaoSjActivity = read.hasWuYiBaoXiaoSjActivity;
            }
            if(read.hasQiZhouNianActivity != undefined)
            {
               gc.dataObject.hasQiZhouNianActivity = read.hasQiZhouNianActivity;
            }
            if(read.hasGetDZPresent != undefined)
            {
               gc.dataObject.hasGetDZPresent = read.hasGetDZPresent;
            }
            if(read.hasGetChangeNamePresent != undefined)
            {
               gc.dataObject.hasGetChangeNamePresent = read.hasGetChangeNamePresent;
            }
            if(read.hasGetOneSalePresent != undefined)
            {
               gc.dataObject.hasGetOneSalePresent = read.hasGetOneSalePresent;
            }
            if(read.hasChallengeNewWorldBoss != undefined)
            {
               gc.dataObject.hasChallengeNewWorldBoss = read.hasChallengeNewWorldBoss;
            }
            if(read.hasGetAuth4399Present != undefined)
            {
               gc.dataObject.hasGetAuth4399Present = read.hasGetAuth4399Present;
            }
            if(read.whichlastworld != undefined)
            {
               gc.dataObject.whichlastworld = read.whichlastworld;
            }
            if(read.gardenExp != undefined)
            {
               gc.dataObject.gardenExp = read.gardenExp;
            }
            if(read.landgodExp != undefined)
            {
               gc.dataObject.landgodExp = read.landgodExp;
            }
            if(read.guiHuaNumber != undefined)
            {
               gc.dataObject.guiHuaNumber = read.guiHuaNumber;
            }
            if(read.hasgetanniversary != undefined)
            {
               gc.dataObject.hasgetanniversary = read.hasgetanniversary;
            }
            if(read.isGetShengdanShoushen != undefined)
            {
               gc.isGetShengdanShoushen = read.isGetShengdanShoushen;
            }
            if(read.zhaoyaojingTimes != undefined)
            {
               gc.dataObject.zhaoyaojingTimes = read.zhaoyaojingTimes;
            }
            if(read.worldtransfromTimes != undefined)
            {
               gc.dataObject.worldtransfromTimes = read.worldtransfromTimes;
            }
            if(read.isGetYikatong != undefined)
            {
               gc.isGetYikatong = read.isGetYikatong;
            }
            if(read.whiteQiqiu != undefined)
            {
               gc.dataObject.whiteQiqiu = read.whiteQiqiu;
            }
            if(read.fourPhalanx != undefined)
            {
               gc.dataObject.fourPhalanx = read.fourPhalanx;
               gc.petFormation.setSaveData(gc.dataObject.fourPhalanx);
            }
            if(read.cliffordStone != undefined)
            {
               gc.dataObject.cliffordStone = read.cliffordStone;
            }
            if(read.snowBossTimes != undefined)
            {
               gc.dataObject.snowBossTimes = read.snowBossTimes;
            }
            if(read.getVIPPresent != undefined)
            {
               gc.dataObject.getVIPPresent = read.getVIPPresent;
            }
            if(read.isGetNewLiBao != undefined)
            {
               gc.isGetNewLiBao = read.isGetNewLiBao;
            }
            if(read.newGuideInfo != undefined)
            {
               gc.newGuideInfo = read.newGuideInfo;
            }
            if(read.hasGetChildrenDayPresent != undefined)
            {
               gc.dataObject.hasGetChildrenDayPresent = read.hasGetChildrenDayPresent;
            }
            if(read.hasGetSolePresent != undefined)
            {
               gc.dataObject.hasGetSolePresent = read.hasGetSolePresent;
            }
            if(read.hasGetSolePresent3 != undefined)
            {
               gc.dataObject.hasGetSolePresent3 = read.hasGetSolePresent3;
            }
            if(read.hasGet50RegistrationBC != undefined)
            {
               gc.dataObject.hasGet50RegistrationBC = read.hasGet50RegistrationBC;
            }
            if(read.hasPresent2019_Yuanxiao2 != undefined)
            {
               gc.dataObject.hasPresent2019_Yuanxiao2 = read.hasPresent2019_Yuanxiao2;
            }
            if(read.hasPresent2019_nuandong != undefined)
            {
               gc.dataObject.hasPresent2019_nuandong = read.hasPresent2019_nuandong;
            }
            if(read.hasPresent2019_duanwu != undefined)
            {
               gc.dataObject.hasPresent2019_duanwu = read.hasPresent2019_duanwu;
            }
            if(read.hasPresent2019_Baoxiao2 != undefined)
            {
               gc.dataObject.hasPresent2019_Baoxiao2 = read.hasPresent2019_Baoxiao2;
            }
            if(read.hasPresent2020_neightBir != undefined)
            {
               gc.dataObject.hasPresent2020_neightBir = read.hasPresent2020_neightBir;
            }
            if(read.hasPresent2021_tenBir != undefined)
            {
               gc.dataObject.hasPresent2021_tenBir = read.hasPresent2021_tenBir;
            }
            if(read.hasPresent2019_xiaoyouxi != undefined)
            {
               gc.dataObject.hasPresent2019_xiaoyouxi = read.hasPresent2019_xiaoyouxi;
            }
            if(read.hasPresent2019_Yuanxiao != undefined)
            {
               gc.dataObject.hasPresent2019_Yuanxiao = read.hasPresent2019_Yuanxiao;
            }
            if(read.hasPresent2019_hangjia != undefined)
            {
               gc.dataObject.hasPresent2019_hangjia = read.hasPresent2019_hangjia;
            }
            if(read.hasPresent2020_newyear != undefined)
            {
               gc.dataObject.hasPresent2020_newyear = read.hasPresent2020_newyear;
            }
            if(read.nationalday2018 != undefined)
            {
               gc.dataObject.nationalday2018 = read.nationalday2018;
            }
            if(read.dujiaPresent13 != undefined)
            {
               gc.dataObject.dujiaPresent13 = read.dujiaPresent13;
            }
            if(read.hasbuypetsecondwarehouse != undefined)
            {
               if(read.hasbuypetsecondwarehouse == "true" || read.hasbuypetsecondwarehouse == true)
               {
                  gc.dataObject.hasbuypetsecondwarehouse = 2;
               }
               else if(read.hasbuypetsecondwarehouse == "false" || read.hasbuypetsecondwarehouse == false)
               {
                  gc.dataObject.hasbuypetsecondwarehouse = 1;
               }
               else
               {
                  gc.dataObject.hasbuypetsecondwarehouse = read.hasbuypetsecondwarehouse;
               }
            }
            trace("getStorage--->22222");
            if(read.constellationsLevel != undefined)
            {
               gc.dataObject.constellationsLevel = read.constellationsLevel;
               cary = String(gc.dataObject.constellationsLevel).split("_") as Array;
               clen = cary.length;
               gc.dataObject.constellationsLevel = "";
               i = 0;
               while(i < clen)
               {
                  if(cary[i] > 10)
                  {
                     cary[i] = 10;
                  }
                  gc.dataObject.constellationsLevel += cary[i] + "";
                  if(i != clen - 1)
                  {
                     gc.dataObject.constellationsLevel += "_";
                  }
                  i++;
               }
            }
            if(read.yh_bz_dl != undefined)
            {
               gc.dataObject.yh_bz_dl = read.yh_bz_dl;
            }
            if(read.petWareHouseSaveString != undefined)
            {
               gc.savePetSaveString(read.petWareHouseSaveString);
            }
            trace("getStorage--->每天一次信息");
            trace("[DailyDebug] curDate from gc.dataObjectInstance.curDate =",gc.dataObjectInstance.curDate);
            trace("[DailyDebug] read.yestoday (raw)                       =",read.yestoday," type:",typeof read.yestoday);
            if(read.yestoday)
            {
               trace("read.yestoday:" + read.yestoday);
               gc.dataObject.yestoday = read.yestoday;
               trace("[DailyDebug] gc.dataObject.yestoday after assign     =",gc.dataObject.yestoday);
               var sameDay:Boolean = String(gc.dataObject.yestoday) == String(gc.dataObjectInstance.curDate);
               trace("[DailyDebug] compare yestoday(" + gc.dataObject.yestoday + ") with curDate(" + gc.dataObjectInstance.curDate + ") => sameDay =",sameDay);
               if(sameDay)
               {
                  trace("[DailyDebug] ===== SAME DAY branch =====");
                  if(read.hasGetAlliance != undefined)
                  {
                     gc.dataObject.hasGetAlliance = read.hasGetAlliance;
                  }
                  gc.dataObject.issameday = true;
                  if(read.bossChallenge)
                  {
                     gc.bossChallenge = read.bossChallenge;
                  }
                  if(read.chanllengeFootBall != undefined)
                  {
                     gc.dataObject.chanllengeFootBall = read.chanllengeFootBall;
                  }
                  if(read.chanllengeQLJFuBen != undefined)
                  {
                     gc.dataObject.chanllengeQLJFuBen = read.chanllengeQLJFuBen;
                  }
                  if(read.chanllengeYJMB != undefined)
                  {
                     gc.dataObject.chanllengeYJMB = read.chanllengeYJMB;
                  }
                  if(read.chanllengenew12_3 != undefined)
                  {
                     gc.dataObject.chanllengenew12_3 = read.chanllengenew12_3;
                  }
                  if(read.threebossChanllenge != undefined)
                  {
                     gc.threebossChanllenge = read.threebossChanllenge;
                     DebugArea.getIns().traceOut("===================gc.threebossChanllenge:" + gc.threebossChanllenge);
                  }
                  if(read.vipsavelist != undefined)
                  {
                     gc.gameVip.vipsavelist = read.vipsavelist;
                  }
                  if(read.onedaytime != undefined)
                  {
                     gc.dataObject.onedaytime = read.onedaytime;
                  }
                  if(read.hasGetGameBoxYYLActivity4 != undefined)
                  {
                     gc.dataObject.hasGetGameBoxYYLActivity4 = read.hasGetGameBoxYYLActivity4;
                  }
                  if(read.hasSummerHoliday4Activity != undefined)
                  {
                     gc.dataObject.hasSummerHoliday4Activity = read.hasSummerHoliday4Activity;
                  }
                  if(read.hasSummerHoliday4Activity2 != undefined)
                  {
                     gc.dataObject.hasSummerHoliday4Activity2 = read.hasSummerHoliday4Activity2;
                  }
                  if(read.onedaytimeQueenMotherBuchang != undefined)
                  {
                     gc.dataObject.onedaytimeQueenMotherBuchang = read.onedaytimeQueenMotherBuchang;
                  }
                  if(read.onedaytimeQueenMother != undefined)
                  {
                     gc.dataObject.onedaytimeQueenMother = read.onedaytimeQueenMother;
                     if(int(gc.dataObject.onedaytimeQueenMother) == 1)
                     {
                        if(int(gc.dataObject.onedaytimeQueenMotherBuchang) == 1)
                        {
                           gc.dataObject.onedaytimeQueenMother = 0;
                           gc.dataObject.onedaytimeQueenMotherBuchang = 0;
                        }
                     }
                     else
                     {
                        gc.dataObject.onedaytimeQueenMotherBuchang = 0;
                     }
                  }
                  if(read.houyiTimes != undefined)
                  {
                     gc.dataObject.houyiTimes = read.houyiTimes;
                  }
                  if(read.yuelaoTimes != undefined)
                  {
                     gc.dataObject.yuelaoTimes = read.yuelaoTimes;
                  }
                  if(read.onedaytimeQueenMotherXntz != undefined)
                  {
                     gc.dataObject.onedaytimeQueenMotherXntz = read.onedaytimeQueenMotherXntz;
                  }
                  if(read.challengeChildrensTimes != undefined)
                  {
                     gc.dataObject.challengeChildrensTimes = read.challengeChildrensTimes;
                  }
                  if(read.throughPastTimes != undefined)
                  {
                     gc.dataObject.throughPastTimes = read.throughPastTimes;
                  }
                  if(read.gardenList != undefined)
                  {
                     gc.initGardenArray(read.gardenList as Array,true);
                  }
                  if(read.challengeSaints != undefined)
                  {
                     gc.dataObject.challengeSaints = read.challengeSaints;
                  }
                  if(read.challengeThreePrinceTimes != undefined)
                  {
                     gc.dataObject.challengeThreePrinceTimes = read.challengeThreePrinceTimes;
                  }
                  if(read.landgodbless != undefined)
                  {
                     gc.dataObject.landgodbless = read.landgodbless;
                  }
                  if(read.chanllengeChangEr2 != undefined)
                  {
                     gc.dataObject.chanllengeChangEr2 = read.chanllengeChangEr2;
                  }
                  if(read.chanllengeShouHuYueBing2 != undefined)
                  {
                     gc.dataObject.chanllengeShouHuYueBing2 = read.chanllengeShouHuYueBing2;
                  }
                  if(read.chanllengeChangEr3 != undefined)
                  {
                     gc.dataObject.chanllengeChangEr3 = read.chanllengeChangEr3;
                  }
                  if(read.isGetShengDanPresent != undefined)
                  {
                     gc.isGetShengDanPresent = read.isGetShengDanPresent;
                  }
                  if(read.isGetXiongshouPresent != undefined)
                  {
                     gc.isGetXiongshouPresent = read.isGetXiongshouPresent;
                  }
                  if(read.isGetEveryDayPresent != undefined)
                  {
                     gc.isGetEveryDayPresent = read.isGetEveryDayPresent;
                  }
                  if(read.constellationTimes != undefined)
                  {
                     gc.dataObject.constellationTimes = read.constellationTimes;
                  }
                  if(read.bxghTimes != undefined)
                  {
                     gc.dataObject.bbbbTimes = read.bxghTimes;
                  }
                  if(read.intoChildrenDayTime != undefined)
                  {
                     gc.dataObject.intoChildrenDayTime = read.intoChildrenDayTime;
                  }
                  if(read.allianceFbTimes != undefined)
                  {
                     gc.dataObject.allianceFbTimes = read.allianceFbTimes;
                  }
                  if(read.houyifb != undefined)
                  {
                     gc.dataObject.houyifb = read.houyifb;
                  }
                  if(read.houyifb2 != undefined)
                  {
                     gc.dataObject.houyifb2 = read.houyifb2;
                  }
                  if(read.beidouqixing != undefined)
                  {
                     gc.dataObject.beidouqixing = read.beidouqixing;
                  }
                  if(read.qingmingFB != undefined)
                  {
                     gc.dataObject.qingmingFB = read.qingmingFB;
                  }
                  if(read.guoqingFB != undefined)
                  {
                     gc.dataObject.guoqingFB = read.guoqingFB;
                  }
                  if(read.dajiFB != undefined)
                  {
                     gc.dataObject.dajiFB = read.dajiFB;
                  }
                  if(read.lsxxFB != undefined)
                  {
                     gc.dataObject.lsxxFB = read.lsxxFB;
                  }
                  if(read.yuelaoFB != undefined)
                  {
                     gc.dataObject.yuelaoFB = read.yuelaoFB;
                  }
                  if(read.hasGetWansheng2021 != undefined)
                  {
                     gc.dataObject.hasGetWansheng2021 = read.hasGetWansheng2021;
                  }
               }
               else
               {
                  trace("[DailyDebug] ===== NEW DAY branch =====");
                  trace("[DailyDebug] before reset: mysteriousshoptimes=",gc.dataObject.mysteriousshoptimes," constellationTimes=",gc.dataObject.constellationTimes," challengeRankTimes=",gc.dataObject.challengeRankTimes);
                  if(gc.getNewYearThreeTreasure("dl") < 50)
                  {
                     gc.setNewYearThreeTreasure("dl",10);
                  }
                  gc.dataObject.hasGetGameBoxYYLActivity4 = false;
                  gc.dataObject.hasSummerHoliday4Activity = false;
                  gc.dataObject.hasSummerHoliday4Activity2 = false;
                  gc.dataObject.onedaytimeQueenMother = 0;
                  gc.dataObject.onedaytimeQueenMotherXntz = 0;
                  gc.dataObject.onedaytimeQueenMotherBuchang = 0;
                  gc.dataObject.onedaytime = 0;
                  gc.dataObject.issameday = false;
                  trace("[DailyDebug] updating yestoday from",gc.dataObject.yestoday,"to",gc.dataObjectInstance.curDate);
                  gc.dataObject.yestoday = gc.dataObjectInstance.curDate;
                  gc.dataObject.mysteriousshoptimes = 5;
                  gc.dataObject.constellationTimes = 7;
                  gc.dataObject.challengeRankTimes = 10;
                  gc.bossChallenge = [0,0,0,0,0,0,0,0];
                  gc.threebossChanllenge = [0,0,0];
                  gc.gameVip.dataObject.dataObject = [false,0,0,0,false,0,0,0];
                  if(read.gardenList != undefined)
                  {
                     gc.initGardenArray(read.gardenList as Array,false);
                  }
                  gc.dataObject.challengeSaints = false;
                  if(read.challengeThreePrinceTimes != undefined)
                  {
                     santaiziTimes = int(read.challengeThreePrinceTimes) + 1;
                     if(santaiziTimes > 10)
                     {
                        santaiziTimes = 10;
                     }
                     gc.dataObject.challengeThreePrinceTimes = santaiziTimes;
                  }
                  gc.dataObject.landgodbless = false;
                  gc.dataObject.bbbbTimes = 1;
                  gc.dataObject.intoChildrenDayTime = 1;
                  gc.dataObject.allianceFbTimes = 1;
                  gc.dataObject.houyifb = 1;
                  gc.dataObject.houyifb2 = 1;
                  gc.dataObject.beidouqixing = 1;
                  gc.dataObject.qingmingFB = 1;
                  gc.dataObject.guoqingFB = 1;
                  gc.dataObject.dajiFB = 1;
                  gc.dataObject.lsxxFB = 1;
                  gc.dataObject.yuelaoFB = 1;
                  gc.dataObject.chanllengeChangEr2 = true;
                  gc.dataObject.chanllengeFootBall = false;
                  gc.dataObject.chanllengeQLJFuBen = false;
                  gc.dataObject.chanllengeYJMB = false;
                  gc.dataObject.chanllengenew12_3 = false;
                  gc.dataObject.chanllengeChangEr3 = true;
                  gc.dataObject.chanllengeShouHuYueBing2 = false;
                  gc.dataObject.hasGetWansheng2021 = false;
               }
            }
            if(read.hdInfo)
            {
               gc.hdInfo = String(read.hdInfo).split(",");
            }
            else
            {
               gc.hdInfo = [];
            }
            if(read.qhsInfo)
            {
               gc.qhsInfo = String(read.qhsInfo).split(",");
            }
            else
            {
               gc.qhsInfo = [];
            }
            trace("getStorage--->玩家buff");
            gc.heroBuffArray.length = 0;
            if(read.hpUpBuffCount > 0)
            {
               buffObj = {
                  "name":HeroBuff.HPUPBUFF,
                  "count":read.hpUpBuffCount
               };
               gc.heroBuffArray.push(buffObj);
            }
            trace("getStorage--->版本号检测");
            if(read.version != undefined)
            {
               gcVersion = gc.dataObject.version;
               readVersion = read.version;
               gcNum = Number(gcVersion);
               readNum = Number(readVersion);
               DebugArea.getIns().traceOut("===========gcNum：" + gcNum);
               DebugArea.getIns().traceOut("===========readNum：" + readNum);
               if(readNum > gcNum)
               {
                  gc.isVersionWrong = true;
               }
            }
         }
      }
      
      public function getSecondStorage() : void
      {
         var read:* = this.secondStorage;
         DebugArea.getIns().traceOut("存档:\n" + DescribeClass.getObjectString(read));
         if(read)
         {
            if(read.player1_obj != undefined)
            {
               gc.player3.setSaveObj(read.player1_obj,1);
               gc.player3.setSkillKeyPlayer3();
            }
         }
      }
      
      public function setStorage(sid:int = -1) : void
      {
         if(gc.isVersionWrong)
         {
            gc.ts.setTxt("该游戏不是最新版本！无法保存数据-ver:" + gc.dataObject.version);
            gc.stage.addChild(gc.ts);
            return;
         }
         mystorage = buildStorageObject();
         var roleName:String = "";
         if(gc.player1.roleid > 0)
         {
            roleName += gc.player1.getRoleName() + " ";
         }
         if(gc.player2.roleid > 0)
         {
            roleName += gc.player2.getRoleName();
         }
         if(roleName == "")
         {
            gc.ts.setTxt("存档异常,如果继续存档,可能导致标题为空,损坏存档!请刷新网页~");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(sid == -1)
         {
            if(!gc.saveInter)
            {
               gc.saveInter = AUtils.getNewObj("export.saveInterface.SaveInter") as SaveInter;
            }
            gc.saveInter.state = "save";
            gc.stage.addChild(gc.saveInter);
         }
         else
         {
            writeSlot(sid,roleName,mystorage);
            gc.showFloatTip("存档成功");
         }
      }
      
      public function storageValue(id:int, data:*) : void
      {
         gc.opening = true;
         this.mystorage = data;
      }
      
      public function secondStorageValue(data:*) : void
      {
         this.secondStorage = data;
      }
      
      private function saveGame(e:CommonEvent) : void
      {
         var index:int = int(e.data[0]);
         if(!so)
         {
            so = SharedObject.getLocal("DW_XYCS_V2");
         }
         if(!so.data.slots)
         {
            so.data.slots = [];
         }
         var roleName:String = "";
         if(gc.player1.roleid > 0)
         {
            roleName += gc.player1.getRoleName() + " ";
         }
         if(gc.player2.roleid > 0)
         {
            roleName += gc.player2.getRoleName();
         }
         if(roleName == "")
         {
            gc.ts.setTxt("存档异常,如果继续存档,可能导致标题为空,损坏存档!请刷新网页~");
            gc.stage.addChild(gc.ts);
            return;
         }
         var slot:Object = {
            "index":index,
            "title":roleName,
            "datetime":nowString(),
            "data":this.mystorage
         };
         so.data.slots[index] = slot;
         try
         {
            so.flush();
         }
         catch(err:Error)
         {
            trace("save flush error: " + err);
            gc.ts.setTxt("本地存档写入失败：" + err.message);
            gc.stage.addChild(gc.ts);
            return;
         }
         var sgi:Sprite = gc.stage.getChildByName("SavingGameMask") as Sprite;
         if(sgi && sgi.parent)
         {
            sgi.parent.removeChild(sgi);
         }
         if(gc.saveInter)
         {
            gc.saveInter.setIndex(getLocalSaveList());
         }
         gc.ts.setTxt("存档成功！");
         gc.stage.addChild(gc.ts);
         gc.luanqibazaojiami.saveId = index;
         gc.isnew = false;
      }
      
      private function readGame(e:CommonEvent) : void
      {
         var index:int = int(e.data[0]);
         readLocalGame(index);
         gc.luanqibazaojiami.saveId = index;
         gc.isnew = false;
      }
      
      public function readSevenObject() : void
      {
         initSharedObject();
         var data:Object = so.data.warehousedata;
         if(data == null)
         {
            data = {};
         }
         setSevenData({"warehousedata":data});
      }
      
      public function saveSevenData(warehousedata:Object) : void
      {
         sevenstorage = {};
         sevenstorage.warehousedata = warehousedata;
         gc.luanqibazaojiami.currentsaveindex = 6;
         initSharedObject();
         so.data.warehousedata = sevenstorage.warehousedata;
         try
         {
            so.flush();
         }
         catch(err:Error)
         {
            trace("saveSevenData flush error:",err);
            gc.ts.setTxt("仓库本地存档写入失败：" + err.message);
            gc.stage.addChild(gc.ts);
         }
      }
      
      public function setSevenData(readObj:Object) : void
      {
         if(readObj == null)
         {
            var data:Object = null;
         }
         else if(readObj.hasOwnProperty("warehousedata"))
         {
            data = readObj.warehousedata;
         }
         else
         {
            data = readObj;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("READSEVENOBJECT",data));
      }
      
      private function initSharedObject() : void
      {
         if(!so)
         {
            so = SharedObject.getLocal("DW_XYCS_V2");
         }
         if(!so.data.slots)
         {
            so.data.slots = [];
         }
         if(!so.data.warehousedata)
         {
            so.data.warehousedata = null;
         }
      }
      
      private function pad(n:int) : String
      {
         return n < 10 ? "0" + n : "" + n;
      }
      
      private function nowString() : String
      {
         var d:Date = new Date();
         return d.fullYear + "-" + pad(d.month + 1) + "-" + pad(d.date) + " " + pad(d.hours) + ":" + pad(d.minutes) + ":" + pad(d.seconds);
      }
      
      private function buildStorageObject() : Object
      {
         var obj:Object = {};
         obj.luserid = gc.getLocalUserId();
         obj.playerNum = gc.playNum;
         obj.hasget = gc.hasget;
         obj.hasgetsorry = gc.hasgetsorry;
         if(gc.player1.roleid > 0)
         {
            obj.player1_obj = gc.player1.getSaveObj();
         }
         if(gc.player2.roleid > 0)
         {
            obj.player2_obj = gc.player2.getSaveObj();
         }
         obj.curBigStage = gc.curBigStage;
         obj.curBigLevel = gc.curBigLevel;
         obj.savedBuffString = gc.savedBuffString;
         obj.mysterioustimes = gc.dataObject.mysteriousshoptimes;
         obj.yestoday = gc.dataObject.yestoday;
         obj.bossChallenge = gc.bossChallenge;
         obj.threebossChanllenge = gc.threebossChanllenge;
         obj.vipsavelist = gc.gameVip.vipsavelist;
         obj.onedaytime = gc.dataObject.onedaytime;
         obj.onedaytimeQueenMother = gc.dataObject.onedaytimeQueenMother;
         obj.onedaytimeQueenMotherXntz = gc.dataObject.onedaytimeQueenMotherXntz;
         obj.hasGetAlliance = gc.dataObject.hasGetAlliance;
         obj.hasGetZhuZhangTYActivity = gc.dataObject.hasGetZhuZhangTYActivity;
         obj.hasGetGameBoxActivity = gc.dataObject.hasGetGameBoxActivity;
         obj.hasGetKaPai_9_Activity = gc.dataObject.hasGetKaPai_9_Activity;
         obj.hasGetKaPai_1_Activity = gc.dataObject.hasGetKaPai_1_Activity;
         obj.hasWeiXin10Activity = gc.dataObject.hasWeiXin10Activity;
         obj.hasWeiXin8Activity = gc.dataObject.hasWeiXin8Activity;
         obj.hasWeiXin9Activity = gc.dataObject.hasWeiXin9Activity;
         obj.hasGetKaiXuePresent = gc.dataObject.hasGetKaiXuePresent;
         obj.hasFifteenYearActivity = gc.dataObject.hasFifteenYearActivity;
         obj.hasWeiXinBaoXiaoActivity = gc.dataObject.hasWeiXinBaoXiaoActivity;
         obj.hasDWWeiXinBaoXiaoActivity = gc.dataObject.hasDWWeiXinBaoXiaoActivity;
         obj.hasDWWeiXinBaoXiaoSj2Activity = gc.dataObject.hasDWWeiXinBaoXiaoSj2Activity;
         obj.hasWuYiBaoXiaoSjActivity = gc.dataObject.hasWuYiBaoXiaoSjActivity;
         obj.hasQiZhouNianActivity = gc.dataObject.hasQiZhouNianActivity;
         obj.hasGetOneSalePresent = gc.dataObject.hasGetOneSalePresent;
         obj.hasGetGameBoxYYLActivity4 = gc.dataObject.hasGetGameBoxYYLActivity4;
         obj.hasSummerHoliday4Activity = gc.dataObject.hasSummerHoliday4Activity;
         obj.hasSummerHoliday4Activity2 = gc.dataObject.hasSummerHoliday4Activity2;
         obj.hasGetSolePresent = gc.dataObject.hasGetSolePresent;
         obj.hasGetSolePresent3 = gc.dataObject.hasGetSolePresent3;
         obj.challengeChildrensTimes = gc.dataObject.challengeChildrensTimes;
         obj.throughPastTimes = gc.dataObject.throughPastTimes;
         obj.hasChallengeNewWorldBoss = gc.dataObject.hasChallengeNewWorldBoss;
         obj.hasGetAuth4399Present = gc.dataObject.hasGetAuth4399Present;
         obj.whichlastworld = gc.dataObject.whichlastworld;
         obj.hdInfo = gc.hdInfo.join(",");
         obj.qhsInfo = gc.qhsInfo.join(",");
         obj.isGetNewLiBao = gc.isGetNewLiBao;
         obj.gardenList = gc.gardenList;
         obj.gardenExp = gc.dataObject.gardenExp;
         obj.challengeSaints = gc.dataObject.challengeSaints;
         obj.challengeThreePrinceTimes = gc.dataObject.challengeThreePrinceTimes;
         obj.landgodExp = gc.dataObject.landgodExp;
         obj.landgodbless = gc.dataObject.landgodbless;
         obj.chanllengeChangEr2 = gc.dataObject.chanllengeChangEr2;
         obj.chanllengeChangEr3 = gc.dataObject.chanllengeChangEr3;
         obj.hasGetDZPresent = gc.dataObject.hasGetDZPresent;
         obj.hasGetChangeNamePresent = gc.dataObject.hasGetChangeNamePresent;
         obj.chanllengeShouHuYueBing2 = gc.dataObject.chanllengeShouHuYueBing2;
         obj.isGetShengDanPresent = gc.isGetShengDanPresent;
         obj.isGetXiongshouPresent = gc.isGetXiongshouPresent;
         obj.isGetEveryDayPresent = gc.isGetEveryDayPresent;
         obj.isGetShengdanShoushen = gc.isGetShengdanShoushen;
         obj.zhaoyaojingTimes = gc.dataObject.zhaoyaojingTimes;
         obj.guiHuaNumber = gc.dataObject.guiHuaNumber;
         obj.hasgetanniversary = gc.dataObject.hasgetanniversary;
         obj.hasbuypetsecondwarehouse = gc.dataObject.hasbuypetsecondwarehouse;
         obj.constellationsLevel = gc.dataObject.constellationsLevel;
         obj.worldtransfromTimes = gc.dataObject.worldtransfromTimes;
         obj.fourPhalanx = gc.dataObject.fourPhalanx;
         obj.cliffordStone = gc.dataObject.cliffordStone;
         obj.constellationTimes = gc.dataObject.constellationTimes;
         obj.yh_bz_dl = gc.dataObject.yh_bz_dl;
         obj.snowBossTimes = gc.dataObject.snowBossTimes;
         obj.getVIPPresent = gc.dataObject.getVIPPresent;
         obj.newGuideInfo = gc.newGuideInfo;
         obj.petWareHouseSaveString = gc.getPetSaveString();
         obj.bxghTimes = gc.dataObject.bbbbTimes;
         obj.isGetYikatong = gc.isGetYikatong;
         obj.whiteQiqiu = gc.dataObject.whiteQiqiu;
         obj.hasGetChildrenDayPresent = gc.dataObject.hasGetChildrenDayPresent;
         obj.intoChildrenDayTime = gc.dataObject.intoChildrenDayTime;
         obj.hasPresent2019_Yuanxiao2 = gc.dataObject.hasPresent2019_Yuanxiao2;
         obj.hasPresent2019_nuandong = gc.dataObject.hasPresent2019_nuandong;
         obj.hasPresent2019_duanwu = gc.dataObject.hasPresent2019_duanwu;
         obj.hasPresent2020_newyear = gc.dataObject.hasPresent2020_newyear;
         obj.hasPresent2019_Baoxiao2 = gc.dataObject.hasPresent2019_Baoxiao2;
         obj.hasPresent2020_neightBir = gc.dataObject.hasPresent2020_neightBir;
         obj.hasPresent2021_tenBir = gc.dataObject.hasPresent2021_tenBir;
         obj.hasPresent2019_xiaoyouxi = gc.dataObject.hasPresent2019_xiaoyouxi;
         obj.hasPresent2019_hangjia = gc.dataObject.hasPresent2019_hangjia;
         obj.hasPresent2019_Yuanxiao = gc.dataObject.hasPresent2019_Yuanxiao;
         obj.nationalday2018 = gc.dataObject.nationalday2018;
         obj.hasGet50RegistrationBC = gc.dataObject.hasGet50RegistrationBC;
         obj.houyifb = gc.dataObject.houyifb;
         obj.houyifb2 = gc.dataObject.houyifb2;
         obj.onedaytimeQueenMotherBuchang = gc.dataObject.onedaytimeQueenMotherBuchang;
         obj.beidouqixing = gc.dataObject.beidouqixing;
         obj.qingmingFB = gc.dataObject.qingmingFB;
         obj.guoqingFB = gc.dataObject.guoqingFB;
         obj.dajiFB = gc.dataObject.dajiFB;
         obj.lsxxFB = gc.dataObject.lsxxFB;
         obj.yuelaoFB = gc.dataObject.yuelaoFB;
         obj.chanllengeFootBall = gc.dataObject.chanllengeFootBall;
         obj.chanllengeQLJFuBen = gc.dataObject.chanllengeQLJFuBen;
         obj.chanllengeYJMB = gc.dataObject.chanllengeYJMB;
         obj.chanllengenew12_3 = gc.dataObject.chanllengenew12_3;
         obj.houyiTimes = gc.dataObject.houyiTimes;
         obj.yuelaoTimes = gc.dataObject.yuelaoTimes;
         if(gc.dataObject.levelUpLimit > gc.dataObject.maxLevelUpLimit)
         {
            gc.dataObject.levelUpLimit = gc.dataObject.maxLevelUpLimit;
         }
         obj.levelUpLimit = gc.dataObject.levelUpLimit;
         obj.version = gc.dataObject.version;
         return obj;
      }
      
      private function writeSlot(index:int, title:String, data:Object) : void
      {
         initSharedObject();
         var slots:Array = so.data.slots as Array;
         var obj:Object = {
            "index":index,
            "title":title,
            "datetime":nowString(),
            "data":data
         };
         slots[index] = obj;
         so.data.slots = slots;
         try
         {
            so.flush();
         }
         catch(err:Error)
         {
            trace("SharedObject flush error:",err);
         }
         gc.luanqibazaojiami.saveId = index;
         gc.isnew = false;
      }
      
      public function updateSaveListUI(ui:SaveInter) : void
      {
         initSharedObject();
         var slots:Array = so.data.slots as Array;
         if(!slots)
         {
            return;
         }
         var list:Array = [];
         var i:int = 0;
         while(i < slots.length)
         {
            var s:Object = slots[i];
            if(s != null)
            {
               if(s.index == null)
               {
                  s.index = i;
               }
               list.push(s);
            }
            i++;
         }
         ui.setIndex(list);
      }
      
      public function getLocalSaveList() : Array
      {
         if(!so)
         {
            so = SharedObject.getLocal("fqzs_save");
         }
         if(!so.data.slots)
         {
            so.data.slots = [];
         }
         var result:Array = [];
         var i:int = 0;
         while(i < 6)
         {
            var slot:Object = so.data.slots[i];
            if(slot && slot.data != null)
            {
               result.push({
                  "index":i,
                  "title":slot.title,
                  "datetime":slot.datetime,
                  "status":0
               });
            }
            i++;
         }
         return result;
      }
      
      public function readLocalGame(index:int) : void
      {
         initSharedObject();
         var slots:Array = so.data.slots as Array;
         if(!slots || !slots[index] || !slots[index].data)
         {
            gc.ts.setTxt("该位置没有存档");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.mystorage = slots[index].data;
         getStorage(this.mystorage);
         gc.isnew = false;
         gc.eventManger.dispatchEvent(new Event("SelectOver"));
         gc.eventManger.dispatchEvent(new CommonEvent("RemoveGameMenu"));
      }
   }
}
