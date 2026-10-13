package storage
{
   import config.Config;
   import event.CommonEvent;
   import export.HeroBuff;
   import export.saveInterface.SaveInter;
   import flash.display.Sprite;
   import flash.net.SharedObject;
   import my.DebugArea;
   import my.DescribeClass;
   import union.model.UnionManager;
   
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
         date = new Date();
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
      }
      
      public function getStorage(storage:Object = null) : void
      {
         var cary:* = null;
         var clen:* = 0;
         var i:* = 0;
         var santaiziTimes:int = 0;
         var buffObj:* = null;
         var gcVersion:* = null;
         var readVersion:* = null;
         var gcNum:Number = NaN;
         var readNum:Number = NaN;
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
               clen = uint(cary.length);
               gc.dataObject.constellationsLevel = "";
               for(i = uint(0); i < clen; )
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
            if(read.yestoday)
            {
               trace("read.yestoday:" + read.yestoday);
               gc.dataObject.yestoday = read.yestoday;
               if(gc.dataObject.yestoday == gc.dataObjectInstance.curDate)
               {
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
         if(!gc.checkWebUid())
         {
            gc.ts.setTxt("当前游戏帐号不是最新的游戏帐号，请重新登录！",9999);
            gc.stage.addChild(gc.ts);
            return;
         }
         gc.saveIntervelCount = 30;
         gc.startSaveTimer();
         if(gc.isVersionWrong)
         {
            gc.ts.setTxt("该游戏不是最新版本！无法保存数据-ver:" + gc.dataObject.version);
            gc.stage.addChild(gc.ts);
            return;
         }
         mystorage = {};
         mystorage.luserid = gc.getLocalUserId();
         mystorage.playerNum = gc.playNum;
         mystorage.hasget = gc.hasget;
         mystorage.hasgetsorry = gc.hasgetsorry;
         if(gc.player1.roleid > 0)
         {
            mystorage.player1_obj = gc.player1.getSaveObj();
         }
         if(gc.player2.roleid > 0)
         {
            mystorage.player2_obj = gc.player2.getSaveObj();
         }
         mystorage.curBigStage = gc.curBigStage;
         mystorage.curBigLevel = gc.curBigLevel;
         mystorage.savedBuffString = gc.savedBuffString;
         mystorage.mysterioustimes = gc.dataObject.mysteriousshoptimes;
         mystorage.yestoday = gc.dataObject.yestoday;
         mystorage.bossChallenge = gc.bossChallenge;
         mystorage.threebossChanllenge = gc.threebossChanllenge;
         mystorage.vipsavelist = gc.gameVip.vipsavelist;
         mystorage.onedaytime = gc.dataObject.onedaytime;
         mystorage.onedaytimeQueenMother = gc.dataObject.onedaytimeQueenMother;
         mystorage.onedaytimeQueenMotherXntz = gc.dataObject.onedaytimeQueenMotherXntz;
         mystorage.hasGetAlliance = gc.dataObject.hasGetAlliance;
         mystorage.hasGetZhuZhangTYActivity = gc.dataObject.hasGetZhuZhangTYActivity;
         mystorage.hasGetGameBoxActivity = gc.dataObject.hasGetGameBoxActivity;
         mystorage.hasGetKaPai_9_Activity = gc.dataObject.hasGetKaPai_9_Activity;
         mystorage.hasGetKaPai_1_Activity = gc.dataObject.hasGetKaPai_1_Activity;
         mystorage.hasWeiXin10Activity = gc.dataObject.hasWeiXin10Activity;
         mystorage.hasWeiXin8Activity = gc.dataObject.hasWeiXin8Activity;
         mystorage.hasWeiXin9Activity = gc.dataObject.hasWeiXin9Activity;
         mystorage.hasGetKaiXuePresent = gc.dataObject.hasGetKaiXuePresent;
         mystorage.hasFifteenYearActivity = gc.dataObject.hasFifteenYearActivity;
         mystorage.hasWeiXinBaoXiaoActivity = gc.dataObject.hasWeiXinBaoXiaoActivity;
         mystorage.hasDWWeiXinBaoXiaoActivity = gc.dataObject.hasDWWeiXinBaoXiaoActivity;
         mystorage.hasDWWeiXinBaoXiaoSj2Activity = gc.dataObject.hasDWWeiXinBaoXiaoSj2Activity;
         mystorage.hasWuYiBaoXiaoSjActivity = gc.dataObject.hasWuYiBaoXiaoSjActivity;
         mystorage.hasQiZhouNianActivity = gc.dataObject.hasQiZhouNianActivity;
         mystorage.hasGetOneSalePresent = gc.dataObject.hasGetOneSalePresent;
         mystorage.hasGetGameBoxYYLActivity4 = gc.dataObject.hasGetGameBoxYYLActivity4;
         mystorage.hasSummerHoliday4Activity = gc.dataObject.hasSummerHoliday4Activity;
         mystorage.hasSummerHoliday4Activity2 = gc.dataObject.hasSummerHoliday4Activity2;
         mystorage.hasGetSolePresent = gc.dataObject.hasGetSolePresent;
         mystorage.hasGetSolePresent3 = gc.dataObject.hasGetSolePresent3;
         mystorage.challengeChildrensTimes = gc.dataObject.challengeChildrensTimes;
         mystorage.throughPastTimes = gc.dataObject.throughPastTimes;
         mystorage.hasChallengeNewWorldBoss = gc.dataObject.hasChallengeNewWorldBoss;
         mystorage.hasGetAuth4399Present = gc.dataObject.hasGetAuth4399Present;
         mystorage.whichlastworld = gc.dataObject.whichlastworld;
         mystorage.hdInfo = gc.hdInfo.join(",");
         mystorage.qhsInfo = gc.qhsInfo.join(",");
         mystorage.isGetNewLiBao = gc.isGetNewLiBao;
         mystorage.gardenList = gc.gardenList;
         mystorage.gardenExp = gc.dataObject.gardenExp;
         mystorage.challengeSaints = gc.dataObject.challengeSaints;
         mystorage.challengeThreePrinceTimes = gc.dataObject.challengeThreePrinceTimes;
         mystorage.landgodExp = gc.dataObject.landgodExp;
         mystorage.landgodbless = gc.dataObject.landgodbless;
         mystorage.chanllengeChangEr2 = gc.dataObject.chanllengeChangEr2;
         mystorage.chanllengeChangEr3 = gc.dataObject.chanllengeChangEr3;
         mystorage.hasGetDZPresent = gc.dataObject.hasGetDZPresent;
         mystorage.hasGetChangeNamePresent = gc.dataObject.hasGetChangeNamePresent;
         mystorage.chanllengeShouHuYueBing2 = gc.dataObject.chanllengeShouHuYueBing2;
         mystorage.isGetShengDanPresent = gc.isGetShengDanPresent;
         mystorage.isGetXiongshouPresent = gc.isGetXiongshouPresent;
         mystorage.isGetEveryDayPresent = gc.isGetEveryDayPresent;
         mystorage.isGetShengdanShoushen = gc.isGetShengdanShoushen;
         mystorage.zhaoyaojingTimes = gc.dataObject.zhaoyaojingTimes;
         mystorage.guiHuaNumber = gc.dataObject.guiHuaNumber;
         mystorage.hasgetanniversary = gc.dataObject.hasgetanniversary;
         mystorage.hasbuypetsecondwarehouse = gc.dataObject.hasbuypetsecondwarehouse;
         mystorage.constellationsLevel = gc.dataObject.constellationsLevel;
         mystorage.worldtransfromTimes = gc.dataObject.worldtransfromTimes;
         mystorage.fourPhalanx = gc.dataObject.fourPhalanx;
         mystorage.cliffordStone = gc.dataObject.cliffordStone;
         mystorage.constellationTimes = gc.dataObject.constellationTimes;
         mystorage.yh_bz_dl = gc.dataObject.yh_bz_dl;
         mystorage.snowBossTimes = gc.dataObject.snowBossTimes;
         mystorage.getVIPPresent = gc.dataObject.getVIPPresent;
         mystorage.newGuideInfo = gc.newGuideInfo;
         mystorage.petWareHouseSaveString = gc.getPetSaveString();
         mystorage.bxghTimes = gc.dataObject.bbbbTimes;
         mystorage.isGetYikatong = gc.isGetYikatong;
         mystorage.whiteQiqiu = gc.dataObject.whiteQiqiu;
         mystorage.hasGetChildrenDayPresent = gc.dataObject.hasGetChildrenDayPresent;
         mystorage.intoChildrenDayTime = gc.dataObject.intoChildrenDayTime;
         mystorage.hasPresent2019_Yuanxiao2 = gc.dataObject.hasPresent2019_Yuanxiao2;
         mystorage.hasPresent2019_nuandong = gc.dataObject.hasPresent2019_nuandong;
         mystorage.hasPresent2019_duanwu = gc.dataObject.hasPresent2019_duanwu;
         mystorage.hasPresent2020_newyear = gc.dataObject.hasPresent2020_newyear;
         mystorage.hasPresent2019_Baoxiao2 = gc.dataObject.hasPresent2019_Baoxiao2;
         mystorage.hasPresent2020_neightBir = gc.dataObject.hasPresent2020_neightBir;
         mystorage.hasPresent2021_tenBir = gc.dataObject.hasPresent2021_tenBir;
         mystorage.hasPresent2019_xiaoyouxi = gc.dataObject.hasPresent2019_xiaoyouxi;
         mystorage.hasPresent2019_hangjia = gc.dataObject.hasPresent2019_hangjia;
         mystorage.hasPresent2019_Yuanxiao = gc.dataObject.hasPresent2019_Yuanxiao;
         mystorage.nationalday2018 = gc.dataObject.nationalday2018;
         mystorage.hasGet50RegistrationBC = gc.dataObject.hasGet50RegistrationBC;
         mystorage.houyifb = gc.dataObject.houyifb;
         mystorage.houyifb2 = gc.dataObject.houyifb2;
         mystorage.onedaytimeQueenMotherBuchang = gc.dataObject.onedaytimeQueenMotherBuchang;
         mystorage.beidouqixing = gc.dataObject.beidouqixing;
         mystorage.qingmingFB = gc.dataObject.qingmingFB;
         mystorage.guoqingFB = gc.dataObject.guoqingFB;
         mystorage.dajiFB = gc.dataObject.dajiFB;
         mystorage.lsxxFB = gc.dataObject.lsxxFB;
         mystorage.yuelaoFB = gc.dataObject.yuelaoFB;
         mystorage.chanllengeFootBall = gc.dataObject.chanllengeFootBall;
         mystorage.chanllengeQLJFuBen = gc.dataObject.chanllengeQLJFuBen;
         mystorage.chanllengeYJMB = gc.dataObject.chanllengeYJMB;
         mystorage.chanllengenew12_3 = gc.dataObject.chanllengenew12_3;
         mystorage.houyiTimes = gc.dataObject.houyiTimes;
         mystorage.yuelaoTimes = gc.dataObject.yuelaoTimes;
         if(gc.dataObject.levelUpLimit > gc.dataObject.maxLevelUpLimit)
         {
            gc.dataObject.levelUpLimit = gc.dataObject.maxLevelUpLimit;
         }
         mystorage.levelUpLimit = gc.dataObject.levelUpLimit;
         mystorage.version = gc.dataObject.version;
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
            gc.luanqibazaojiami.currentsaveindex = gc.luanqibazaojiami.saveId;
            GMain.serviceHold.saveData(roleName,this.mystorage,false,sid);
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
         var index:int = e.data[0];
         gc.luanqibazaojiami.saveId = index;
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
         gc.luanqibazaojiami.currentsaveindex = gc.luanqibazaojiami.saveId;
         GMain.serviceHold.saveData(roleName,this.mystorage,false,gc.luanqibazaojiami.saveId);
      }
      
      private function readGame(e:CommonEvent) : void
      {
         var rsdm:Sprite = AUtils.getNewObj("ReadSaveData") as Sprite;
         rsdm.name = "ReadSaveDataMask";
         var index:int = e.data[0];
         if(gc.currentRead == 0)
         {
            if(!gc.checkWebUid())
            {
               gc.ts.setTxt("当前游戏帐号不是最新的游戏帐号，请重新登录！",9999);
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.luanqibazaojiami.saveId = index;
            GMain.serviceHold.getData(false,gc.luanqibazaojiami.saveId);
         }
         else
         {
            GMain.serviceHold.getSecondaryData(index);
         }
         gc.stage.addChild(rsdm);
         UnionManager.getIns().getOwnUnion();
      }
      
      public function readSevenObject() : void
      {
         var rwh:Sprite = AUtils.getNewObj("ReadingWareHouse") as Sprite;
         rwh.name = "ReadingWareHouseMask";
         gc.stage.addChild(rwh);
         GMain.serviceHold.getData(false,6);
      }
      
      public function saveSevenData(warehousedata:Object) : void
      {
         sevenstorage = {};
         var sgi:Sprite = AUtils.getNewObj("SavingGameInterface") as Sprite;
         sgi.name = "SavingGameMask";
         gc.stage.addChild(sgi);
         sevenstorage.warehousedata = warehousedata;
         gc.luanqibazaojiami.currentsaveindex = 6;
         GMain.serviceHold.saveData("WareHouse",this.sevenstorage,false,6);
      }
      
      public function setSevenData(readObj:Object) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("READSEVENOBJECT",readObj.warehousedata));
      }
   }
}
