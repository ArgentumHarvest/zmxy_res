package
{
   import AssetsClass.AboutUsAssets;
   import AssetsClass.BuySkillAssets;
   import AssetsClass.GameCartoonAssets;
   import AssetsClass.GameHelp;
   import AssetsClass.GardenInterfaceAssets;
   import AssetsClass.MicropaymentInterfaceAssets;
   import AssetsClass.SelectRoleAssets;
   import AssetsClass.StrengthEquipmentAssets;
   import AssetsClass.TaskInterfaceAssets;
   import PhysicsWorld.PhysicsWorld;
   import base.BrowserInfo;
   import com.adobe.crypto.MD5;
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.ControlFactory;
   import com.superkaka.mvc.ProxyFactory;
   import config.Config;
   import config.HeroSkillProtect;
   import event.CommonEvent;
   import export.GameMenu;
   import export.LineChoose;
   import export.LoadingBar;
   import export.LoadingBar2;
   import export.NewWorldSelectPlace;
   import export.OutAndStopGame;
   import export.SelectPLace;
   import export.ThirdWorldSelectPlace;
   import export.forbit.ForBitInterface;
   import export.honor.AllianceSecondInterface;
   import export.huodong.AllHuoDongInterface;
   import export.huodong.AllHuoDongInterface2;
   import export.huodong.AllHuoDongInterface3;
   import export.huodong.ChineseValentinesDay;
   import export.lose.GameFail;
   import export.rank.RankPropertyCount;
   import export.win.GameWin;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.LocalConnection;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.System;
   import flash.text.Font;
   import flash.utils.ByteArray;
   import flash.utils.setInterval;
   import loader.Aloader;
   import loader.Aloader2;
   import manager.MusicManager;
   import mvc.control.SocketsSendControl;
   import mvc.control.net.rm.MyCommonReceiveControl;
   import mvc.control.net.rm.MyGameReceiveControl;
   import mvc.control.net.rm.MyGateReceiveControl;
   import mvc.control.net.rm.MyLineReceiveControl;
   import mvc.control.net.rm.MyLoginReceiveControl;
   import mvc.control.net.rm.MyPlayerReceiveControl;
   import mvc.control.net.rm.MyRoomReceiveControl;
   import mvc.proxy.FbSocketProxy;
   import mvc.proxy.GameSocketProxy;
   import mvc.proxy.GateSocketProxy;
   import mvc.proxy.ProtocolProxy;
   import my.DebugArea;
   import my.FinancialInfo;
   import my.HackChecker;
   import my.MainGame;
   import my.SaveResult;
   import myanalysis.MyAllEquipId;
   import myanalysis.MyAnalyzingEquip;
   import union.model.UnionManager;
   import unit4399.events.PayEvent;
   import unit4399.events.RankListEvent;
   import unit4399.events.SaveEvent;
   import unit4399.events.SecondaryEvent;
   
   [SWF(frameRate="24",backgroundColor="#ffffff",width="940",height="590")]
   public class GMain extends MovieClip
   {
      
      public static var _4399_function_ad_id:String = "92d6cef76cd06829e088932fe9fd819b";
      
      public static var _4399_function_secondary_id:String = "ebd8715ff7f9c360d6398dfb62465999";
      
      public static var serviceHold = null;
      
      private static var _this:GMain;
       
      
      var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
      var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      var _4399_function_rankList_id:String = "69f52ab6eb1061853a761ee8c26324ae";
      
      var _4399_function_union_id:String = "7c7a741b186b91e2975006321918345f";
      
      private var meid:MyAllEquipId;
      
      private var pay:PayMoneyVar;
      
      private var gc:Config;
      
      private var _loader:Aloader;
      
      private var _loader2:Aloader2;
      
      private var mainSence:Sprite;
      
      private var topSence:Sprite;
      
      public var curState:String;
      
      private var myAnalyEquip:MyAnalyzingEquip;
      
      [Embed(source="MainResourcev3730.swf",mimeType="application/octet-stream")]
      private var mainResuorce:Class;
      
      [Embed(symbol="BossBlood",source="MainResourcev3730.swf")]
      private var bossBlood:Class;
      
      [Embed(symbol="aaa",source="font.swf")]
      private var mainFont:Class;
      
      private var gm:GameMenu;
      
      private var submitFailReSubmitTimes:uint = 3;
      
      private var submitVipFailReSubmitTimes:uint = 3;
      
      private var netError:Boolean;
      
      private var mainResourceLoader:Loader;
      
      private var urlLoader:URLLoader;
      
      private var urlLoader2:URLLoader;
      
      public function GMain()
      {
         meid = new MyAllEquipId();
         pay = new PayMoneyVar();
         myAnalyEquip = new MyAnalyzingEquip();
         mainResuorce = §MainResourcev3730_swf$cb5145bd84b106fc07a861f6691ba44b-1947110218§;
         bossBlood = §MainResourcev3730_swf$cb5145bd84b106fc07a861f6691ba44b-239592852§;
         mainFont = §font_swf$87782ab87abc67e2525d4fcebc1c452b-469073389§;
         urlLoader = new URLLoader();
         urlLoader2 = new URLLoader();
         super();
         gc = new Config();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         gc.bossBloodClass = bossBlood;
         HeroSkillProtect.getInstance();
         HackChecker.enabledCheckSpeedUp(1000,50);
         HackChecker.hackHandler = cheatFunction;
         var mainBa:ByteArray = new mainResuorce() as ByteArray;
         mainResourceLoader = new Loader();
         mainResourceLoader.contentLoaderInfo.addEventListener("complete",__mainLoadComplete);
         mainResourceLoader.loadBytes(mainBa,new LoaderContext(false,ApplicationDomain.currentDomain));
         Font.registerFont(mainFont);
         var fontList:Array = Font.enumerateFonts(false);
         for each(var font in fontList)
         {
            trace("==================:" + font.fontName);
         }
         Security.allowDomain("*");
         System.useCodePage = false;
         this.tabChildren = false;
         this.tabEnabled = false;
      }
      
      public static function getInstance() : GMain
      {
         return _this;
      }
      
      public function setHold(hold:*) : void
      {
         serviceHold = hold;
      }
      
      protected function __mainLoadComplete(evt:Event) : void
      {
         mainResourceLoader.contentLoaderInfo.removeEventListener("complete",__mainLoadComplete);
         mainResourceLoader.unload();
         mainResourceLoader = null;
         _loader = new Aloader();
         _loader.init();
         _loader2 = new Aloader2();
         _this = this;
         gc.pWorld = new PhysicsWorld();
         gc.lc = new LocalConnection();
         this.mainSence = new Sprite();
         this.mainSence.tabChildren = false;
         this.mainSence.tabEnabled = false;
         this.topSence = new Sprite();
         this.topSence.tabChildren = false;
         this.topSence.tabEnabled = false;
         this.addChild(this.mainSence);
         this.addChild(this.topSence);
      }
      
      protected function __add(evt:Event) : void
      {
         if(evt.target is DisplayObjectContainer)
         {
            if((evt.target as DisplayObjectContainer).tabChildren)
            {
               (evt.target as DisplayObjectContainer).tabChildren = false;
            }
            if((evt.target as DisplayObjectContainer).tabEnabled)
            {
               (evt.target as DisplayObjectContainer).tabEnabled = false;
            }
         }
      }
      
      public function cheatFunction() : void
      {
         if(gc.isServerOk)
         {
            gc.closeScoket();
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            gc.ts.setTxt("使用变速齿轮,被踢出PK场!");
            this.switchSence("showStageMap");
         }
         else
         {
            gc.ts.setTxt("请勿使用变速齿轮!");
            if(gc.curStageAndCurLevel && gc.curStageAndCurLevel.curStage == 41 && gc.curStageAndCurLevel.curLevel == 1)
            {
               this.switchSence("showStageMap");
            }
         }
         gc.stage.addChild(gc.ts);
         gc.eventManger.dispatchEvent(new Event("cheat"));
      }
      
      private function saveProcess(e:SaveEvent) : void
      {
         e = e;
         try
         {
            switch(e.type)
            {
               case "getuserdata":
                  if(!gc.logInfo)
                  {
                     return;
                  }
                  trace("--SaveEvent.SAVE_GET--");
                  var clearMask:Function = function():*
                  {
                     DebugArea.getIns().traceOut("--clearMask--");
                     if(gc.loginAlert && gc.loginAlert.name == "LoginAlert" && gc.loginAlert.parent)
                     {
                        gc.loginAlert.parent.removeChild(gc.loginAlert);
                        gc.loginAlert = null;
                     }
                     if(gc.stage.getChildByName("ReadingWareHouseMask"))
                     {
                        gc.stage.removeChild(gc.stage.getChildByName("ReadingWareHouseMask"));
                     }
                     if(gc.stage.getChildByName("ReadSaveDataMask"))
                     {
                        gc.stage.removeChild(gc.stage.getChildByName("ReadSaveDataMask"));
                     }
                  };
                  if(e.data != null && e.data != "")
                  {
                     trace("SAVE_GET:e.data.index-->>" + e.data.index);
                     if(e.data.index == 6)
                     {
                        gc.isfirstread = false;
                        gc.memory.setSevenData(e.data.data);
                        clearMask();
                     }
                     else
                     {
                        var self:GMain = this;
                        gc.requestData(function():*
                        {
                           gc.memory.storageValue(e.data.index,e.data.data);
                           gm.showAndHide();
                           self.sendPlayerLv();
                           clearMask();
                        });
                     }
                  }
                  else
                  {
                     clearMask();
                  }
                  break;
               case "getDataExcep":
                  trace("SAVE_GET.getDataExcep:e.data.status-->>" + e.data.status);
                  if(e.data.status != 0)
                  {
                     var fbi:ForBitInterface = new ForBitInterface(e.data.status);
                     gc.stage.addChild(fbi);
                  }
                  break;
               case "saveuserdata":
                  trace("SaveEvent.SAVE_SET");
                  if(e.ret as Boolean == true)
                  {
                     if(!netError)
                     {
                        var sr:SaveResult = new SaveResult(SaveResult.SAVE_OK);
                        sr.x = 470;
                        sr.y = 400;
                        this.getTopSence().addChild(sr);
                     }
                     else
                     {
                        netError = false;
                     }
                     if(gc.isnew)
                     {
                        FinancialInfo.createSaveData(gc.logInfo.uid);
                        gc.isnew = false;
                     }
                     if(gc.saveInter && gc.saveInter.parent)
                     {
                        gc.saveInter.parent.removeChild(gc.saveInter);
                        gc.saveInter = null;
                     }
                     if(gc.luanqibazaojiami.currentsaveindex == 6)
                     {
                        gc.memory.setStorage(gc.luanqibazaojiami.saveId);
                     }
                     else
                     {
                        if(gc.stage.getChildByName("SavingGameMask"))
                        {
                           gc.stage.removeChild(gc.stage.getChildByName("SavingGameMask"));
                        }
                        gc.eventManger.dispatchEvent(new CommonEvent("SAVESEVENTSUCCESS"));
                     }
                  }
                  else
                  {
                     if(gc.saveInter)
                     {
                        if(gc.saveInter.getChildByName("SavingGameMask"))
                        {
                           gc.saveInter.removeChild(gc.saveInter.getChildByName("SavingGameMask"));
                        }
                     }
                     if(gc.stage.getChildByName("SavingGameMask"))
                     {
                        gc.stage.removeChild(gc.stage.getChildByName("SavingGameMask"));
                     }
                     sr = new SaveResult(SaveResult.SAVE_NO);
                     sr.x = 470;
                     sr.y = 400;
                     this.getTopSence().addChild(sr);
                  }
                  break;
               case "getuserdatalist":
                  trace("====SaveEvent.SAVE_LIST====");
                  if(gc.dealAlert && gc.dealAlert.name == "DealingAlert" && gc.dealAlert.parent)
                  {
                     gc.dealAlert.parent.removeChild(gc.dealAlert);
                     gc.dealAlert = null;
                  }
                  trace("e.ret--->>" + e.ret);
                  if(e.ret != null)
                  {
                     gc.saveInter.setIndex(e.ret as Array);
                  }
                  break;
               case "logreturn":
                  gc.initData();
                  gc.logInfo = e.ret;
                  GameConst.LOG_DATA = e.ret;
                  FinancialInfo.loginAndOut(gc.logInfo.uid,1);
                  DebugArea.getIns().traceOut("登录完成发出的事件-uid:" + gc.logInfo.uid);
                  gc.dataObjectInstance.loginUid = gc.logInfo.uid;
                  if(gc.logInfo.uid == 80222385 || gc.logInfo.uid == 76560645 || gc.logInfo.uid == 76803368 || gc.logInfo.uid == 1110671826)
                  {
                     gc.isTest = true;
                  }
                  if(e.ret)
                  {
                     gc.setLocalUserId(String(e.ret.uid));
                     gm.showSelectNum();
                     gm.getSaveData();
                     gm.isremoveLoginAlert();
                  }
                  this.connectToGate();
            }
         }
         catch(e:*)
         {
         }
      }
      
      private function connectToGate() : void
      {
      }
      
      public function showProgress(pro:int, fileIdx:int) : void
      {
         var lb:* = null;
         if(!this.topSence.getChildByName("showProgress"))
         {
            lb = new LoadingBar();
            lb.name = "showProgress";
            lb.setProcess(pro,fileIdx);
            lb.x = 470;
            lb.y = 295;
            this.topSence.addChild(lb);
         }
         else
         {
            LoadingBar(this.topSence.getChildByName("showProgress")).setProcess(pro,fileIdx);
         }
      }
      
      public function showLoadByStageAndLevelProgress(pro:int, idx:uint, totalLen:uint) : void
      {
         var lb:* = null;
         if(!this.topSence.getChildByName("showLoadByStageAndLevelProgress"))
         {
            lb = new LoadingBar2();
            lb.name = "showLoadByStageAndLevelProgress";
            lb.setProcess(pro,idx,totalLen);
            lb.x = 470;
            lb.y = 295;
            this.topSence.addChild(lb);
         }
         else
         {
            LoadingBar2(this.topSence.getChildByName("showLoadByStageAndLevelProgress")).setProcess(pro,idx,totalLen);
         }
      }
      
      public function processComplete() : void
      {
         var mc:MovieClip = this.topSence.getChildByName("showProgress") as MovieClip;
         if(mc)
         {
            this.topSence.removeChild(mc);
            mc = null;
         }
         mc = this.topSence.getChildByName("showLoadByStageAndLevelProgress") as MovieClip;
         if(mc)
         {
            this.topSence.removeChild(mc);
            mc = null;
         }
      }
      
      public function switchSence(str:String) : void
      {
         this.curState = str;
         switch(str)
         {
            case "startFighting":
               this.clearStageMap();
               startGame(gc.curStageAndCurLevel.curStage,gc.curStageAndCurLevel.curLevel);
               break;
            case "GameMenu":
               this.showGameMenu();
               break;
            case "SelectRole":
               this.showSelectRolw();
               break;
            case "showStageMap":
               this.showStageMap();
               break;
            case "showNewStageMap":
               this.showNewStageMap();
               break;
            case "showThirdStageMap":
               this.showThirdStageMap();
               break;
            case "gameOver":
               this.showGameOver();
               break;
            case "OpenAnimation":
               this.showOpenAnimation(null);
               break;
            case "ChineseValentinesDay":
               this.chineseValentinesDay(null);
               break;
            case "AllHuoDongInterface":
               this.allHuoDongInterface();
               break;
            case "AllHuoDongInterface2":
               this.allHuoDongInterface2();
            case "AllHuoDongInterface3":
               this.allHuoDongInterface3();
         }
      }
      
      private function added(e:*) : void
      {
         e = e;
         this.stage.addEventListener("added",__add);
         setInterval(function():*
         {
            if(gc.logInfo)
            {
               FinancialInfo.heartBeat(gc.logInfo.uid);
            }
         },300000);
         trace("GMain--added");
         this.tabChildren = false;
         gc.eventManger.addEventListener("LoadOver",loaderOver);
         gc.eventManger.addEventListener("StartSelectRole",selectRole);
         gc.eventManger.addEventListener("ShowTaskInterface",showTaskInterface);
         gc.eventManger.addEventListener("showShoping",showShoping);
         gc.eventManger.addEventListener("SelectOver",SelectRoleOver);
         gc.eventManger.addEventListener("selectStageOver",selectStageOver);
         gc.eventManger.addEventListener("showBuySkill",showBuySkill);
         gc.eventManger.addEventListener("showStrengthEquip",showStrengthEquip);
         gc.eventManger.addEventListener("showGradenInterface",showGradenInterface);
         gc.eventManger.addEventListener("heroDead",heroDead);
         gc.eventManger.addEventListener("GameOver",gameOver);
         gc.eventManger.addEventListener("ReStart",reStart);
         gc.eventManger.addEventListener("LevelVictor",levelVictor);
         gc.eventManger.addEventListener("ShowOpenAnimation",showOpenAnimation);
         gc.eventManger.addEventListener("ShowOpenAnimationOver",showOpenAnimationOver);
         gc.eventManger.addEventListener("showAboutUs",showAboutUs);
         gc.eventManger.addEventListener("GameHelp",gameHelp);
         gc.eventManger.addEventListener("AddGardenExp",updataGarden);
         stage.addEventListener("netSaveError",netSaveErrorHandler,false,0,true);
         stage.addEventListener("getuserdata",saveProcess);
         stage.addEventListener("saveuserdata",saveProcess);
         stage.addEventListener("getuserdatalist",saveProcess);
         stage.addEventListener("getDataExcep",saveProcess);
         stage.addEventListener("logreturn",saveProcess);
         stage.addEventListener("MVC_CLOSE_PANEL",closePanelHandler,false,0,true);
         stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
         stage.addEventListener("serverTimeEvent",onGetServerTimeHandler);
         stage.addEventListener("logsuccess",onPayEventHandler,false,0,true);
         stage.addEventListener("incMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("decMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("getMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("payMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("paiedMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("payError",onPayEventHandler,false,0,true);
         stage.addEventListener("rechargedMoney",onPayEventHandler,false,0,true);
         stage.addEventListener("secondaryLogin",secondaryEventHandle,false,0,true);
         stage.addEventListener("secondaryLogOut",secondaryEventHandle,false,0,true);
         stage.addEventListener("secondarySaveGet",secondaryEventHandle,false,0,true);
         stage.addEventListener("secondarySaveList",secondaryEventHandle,false,0,true);
         stage.addEventListener("secondarySaveSet",secondaryEventHandle,false,0,true);
         stage.addEventListener("rankListError",onRankListErrorHandler);
         stage.addEventListener("rankListSuccess",onRankListSuccessHandler);
         stage.addEventListener("activate",clickBack);
         stage.addEventListener("deactivate",clickOut);
         UnionManager.getIns().initData(stage);
         gc.stage = this.stage;
         if(this.loaderInfo)
         {
            if(this.loaderInfo.parameters)
            {
               if(this.loaderInfo.parameters.refer != undefined)
               {
                  gc.isComeFrom4399 = (this.loaderInfo.parameters.refer as String).indexOf("4399.com") == -1 ? false : true;
               }
            }
         }
         DebugArea.getIns().initWithContainer(this.stage);
         var date1:Date = new Date();
         if(date1.getTime() >= 1586016001000)
         {
            gc.isBlack = false;
         }
         else
         {
            gc.isBlack = true;
         }
         BrowserInfo.getBrowserInfo();
         var info:String = BrowserInfo.info || "";
         var barr:Array = info.split("|");
         if(barr[barr.length - 1] == "4399.zm5.air")
         {
            gc.isAirGame = true;
         }
         stage.showDefaultContextMenu = false;
         stage.addEventListener("rightClick",function(e:MouseEvent):void
         {
         });
      }
      
      private function removed(e:*) : void
      {
         gc.eventManger.removeEventListener("LoadOver",loaderOver);
         gc.eventManger.removeEventListener("StartSelectRole",selectRole);
         gc.eventManger.removeEventListener("SelectOver",SelectRoleOver);
         gc.eventManger.removeEventListener("ShowTaskInterface",showTaskInterface);
         gc.eventManger.removeEventListener("selectStageOver",selectStageOver);
         gc.eventManger.removeEventListener("showBuySkill",showBuySkill);
         gc.eventManger.removeEventListener("showStrengthEquip",showStrengthEquip);
         gc.eventManger.removeEventListener("showGradenInterface",showGradenInterface);
         gc.eventManger.removeEventListener("heroDead",heroDead);
         gc.eventManger.removeEventListener("GameOver",gameOver);
         gc.eventManger.removeEventListener("ReStart",reStart);
         gc.eventManger.removeEventListener("LevelVictor",levelVictor);
         gc.eventManger.removeEventListener("ShowOpenAnimation",showOpenAnimation);
         gc.eventManger.removeEventListener("ShowOpenAnimationOver",showOpenAnimationOver);
         gc.eventManger.removeEventListener("showAboutUs",showAboutUs);
         gc.eventManger.removeEventListener("GameHelp",gameHelp);
         gc.eventManger.removeEventListener("showShoping",showShoping);
         gc.eventManger.removeEventListener("AddGardenExp",updataGarden);
         stage.removeEventListener("getuserdata",saveProcess);
         stage.removeEventListener("saveuserdata",saveProcess);
         stage.removeEventListener("getuserdatalist",saveProcess);
         stage.removeEventListener("getDataExcep",saveProcess);
         stage.removeEventListener("logreturn",saveProcess);
         stage.removeEventListener("serverTimeEvent",onGetServerTimeHandler);
         stage.removeEventListener("activate",clickBack);
         stage.removeEventListener("deactivate",clickOut);
         stage.removeEventListener("rankListError",onRankListErrorHandler);
         stage.removeEventListener("rankListSuccess",onRankListSuccessHandler);
      }
      
      protected function onGetServerTimeHandler(evt:DataEvent) : void
      {
         gc.completeHandler(evt.data);
      }
      
      private function reSetRankTag() : void
      {
         trace("reSetRankTag -->>>" + reSetRankTag);
         gc.rankHasPassOneMin = true;
      }
      
      private function updataGarden(e:CommonEvent) : void
      {
         var after:* = 0;
         var obj:* = null;
         var befour:uint = gc.achieveLandLevel();
         if(befour < 9)
         {
            gc.dataObject.gardenExp += gc.dataObject.onehundred;
            after = uint(gc.achieveLandLevel());
            while(after > befour)
            {
               obj = {};
               obj.gid = after;
               obj.date = gc.dataObjectInstance.curDate;
               obj.type = gc.dataObject.one;
               obj.plantingLevel = gc.dataObject.zero;
               gc.gardenList.push(obj);
               after--;
            }
         }
      }
      
      private function clickBack(e:Event) : void
      {
         if(gc.isHideDebug)
         {
            gc.isczclick = false;
            gc.eventManger.dispatchEvent(new CommonEvent("VIPDATAREADING"));
         }
         if(gc.isHideDebug)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("REACHIEVEVIPWAREHOUSE"));
         }
         this.hideOutAndStopGame();
      }
      
      private function clickOut(e:Event) : void
      {
         gc.eventManger.dispatchEvent(new Event("DEACTIVATE"));
         if(gc.isinthegame)
         {
            this.showOutAndStopGame();
         }
      }
      
      private function showOutAndStopGame() : void
      {
         var oasg:* = null;
         if(this.getChildByName("OutAndStopGame") == null)
         {
            oasg = new OutAndStopGame();
            oasg.name = "OutAndStopGame";
            this.addChild(oasg);
         }
      }
      
      private function hideOutAndStopGame() : void
      {
         var sp:OutAndStopGame = this.getChildByName("OutAndStopGame") as OutAndStopGame;
         if(sp != null)
         {
            sp.hide();
         }
      }
      
      private function showAboutUs(e:CommonEvent) : void
      {
         var gh:AboutUsAssets = new AboutUsAssets();
         this.mainSence.addChild(gh);
      }
      
      private function gameHelp(e:CommonEvent) : void
      {
         var gh:GameHelp = new GameHelp();
         this.mainSence.addChild(gh);
      }
      
      private function showOpenAnimation(e:*) : void
      {
         var gca:GameCartoonAssets = new GameCartoonAssets();
         this.mainSence.addChild(gca);
      }
      
      private function chineseValentinesDay(e:*) : void
      {
         var cvd:ChineseValentinesDay = AUtils.getNewObj("export.huodong.ChineseValentinesDay") as ChineseValentinesDay;
         this.mainSence.addChild(cvd);
      }
      
      private function allHuoDongInterface() : void
      {
         var ahdi:AllHuoDongInterface = AUtils.getNewObj("export.huodong.AllHuoDongInterface") as AllHuoDongInterface;
         this.mainSence.addChild(ahdi);
      }
      
      private function allHuoDongInterface2() : void
      {
         var ahdi:AllHuoDongInterface2 = AUtils.getNewObj("export.huodong.AllHuoDongInterface2") as AllHuoDongInterface2;
         this.mainSence.addChild(ahdi);
      }
      
      private function allHuoDongInterface3() : void
      {
         var ahdi:AllHuoDongInterface3 = AUtils.getNewObj("export.huodong.AllHuoDongInterface3") as AllHuoDongInterface3;
         this.mainSence.addChild(ahdi);
      }
      
      private function showLineChoose(e:*) : void
      {
         var slc:LineChoose = AUtils.getNewObj("export.huodong.ChineseValentinesDay") as LineChoose;
         this.mainSence.addChild(slc);
      }
      
      private function showOpenAnimationOver(e:*) : void
      {
         gc.isGoToNewGuideStage = true;
         this.switchSence("showStageMap");
      }
      
      private function showBuySkill(e:CommonEvent) : void
      {
         var bs:BuySkillAssets = new BuySkillAssets(e.data.state);
         this.mainSence.addChild(bs);
      }
      
      private function showStrengthEquip(e:CommonEvent) : void
      {
         var se:StrengthEquipmentAssets = new StrengthEquipmentAssets(e.data.state);
         this.mainSence.addChild(se);
      }
      
      private function showGradenInterface(e:CommonEvent) : void
      {
         var gif:GardenInterfaceAssets = new GardenInterfaceAssets();
         this.mainSence.addChild(gif);
      }
      
      private function showShoping(e:CommonEvent) : void
      {
         var microShop:MicropaymentInterfaceAssets = new MicropaymentInterfaceAssets();
         this.mainSence.addChild(microShop);
      }
      
      public function getTopSence() : Sprite
      {
         return this.topSence;
      }
      
      private function SelectRoleOver(e:*) : void
      {
         Debug.trace("---SelectRoleOver---");
         if(gc.opening)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("RemoveSelectRoleInterface"));
            if(gc.dataObject.whichlastworld == 1)
            {
               this.switchSence("showNewStageMap");
            }
            else if(gc.dataObject.whichlastworld == 2)
            {
               this.switchSence("showThirdStageMap");
            }
            else
            {
               this.switchSence("showStageMap");
            }
         }
         else
         {
            gc.gameinwhere = "开场";
            this.switchSence("OpenAnimation");
         }
      }
      
      private function showStageMap() : void
      {
         var sp:* = null;
         trace("---showStageMap----");
         MusicManager.getInstance().play("begin");
         var second:NewWorldSelectPlace = this.mainSence.getChildByName("NewWorldSelectPlaceHasShow") as NewWorldSelectPlace;
         if(second)
         {
            this.mainSence.removeChild(second);
         }
         if(this.mainSence.getChildByName("SelectPlaceHasShow") == null)
         {
            gc.dataObject.whichlastworld = 0;
            sp = AUtils.getNewObj("export.SelectPLace") as SelectPLace;
            sp.name = "SelectPlaceHasShow";
            this.mainSence.addChild(sp);
         }
      }
      
      private function showNewStageMap() : void
      {
         var nwsp:* = null;
         trace("---showNewStageMap---");
         MusicManager.getInstance().play("begin");
         var first:SelectPLace = this.mainSence.getChildByName("SelectPlaceHasShow") as SelectPLace;
         if(first)
         {
            this.mainSence.removeChild(first);
         }
         var third:ThirdWorldSelectPlace = this.mainSence.getChildByName("ThirdWorldSelectPlaceHasShow") as ThirdWorldSelectPlace;
         if(third)
         {
            this.mainSence.removeChild(third);
         }
         if(this.mainSence.getChildByName("NewWorldSelectPlaceHasShow") == null)
         {
            gc.dataObject.whichlastworld = 1;
            nwsp = AUtils.getNewObj("export.NewWorldSelectPlace") as NewWorldSelectPlace;
            nwsp.name = "NewWorldSelectPlaceHasShow";
            this.mainSence.addChild(nwsp);
         }
      }
      
      private function showThirdStageMap() : void
      {
         var nwsp:* = null;
         trace("---showThirdStageMap---");
         MusicManager.getInstance().play("begin");
         var second:NewWorldSelectPlace = this.mainSence.getChildByName("NewWorldSelectPlaceHasShow") as NewWorldSelectPlace;
         if(second)
         {
            this.mainSence.removeChild(second);
         }
         if(this.mainSence.getChildByName("ThirdWorldSelectPlaceHasShow") == null)
         {
            gc.dataObject.whichlastworld = 2;
            nwsp = AUtils.getNewObj("export.ThirdWorldSelectPlace") as ThirdWorldSelectPlace;
            nwsp.name = "ThirdWorldSelectPlaceHasShow";
            this.mainSence.addChild(nwsp);
         }
      }
      
      private function clearStageMap() : void
      {
         if(this.mainSence.getChildByName("NewWorldSelectPlaceHasShow") != null)
         {
            this.mainSence.removeChild(this.mainSence.getChildByName("NewWorldSelectPlaceHasShow"));
         }
         if(this.mainSence.getChildByName("SelectPlaceHasShow") != null)
         {
            this.mainSence.removeChild(this.mainSence.getChildByName("SelectPlaceHasShow"));
         }
      }
      
      private function selectStageOver(e:*) : void
      {
         trace("GMain --selectStageOver");
         switchSence("startFighting");
      }
      
      private function showGameMenu() : void
      {
         if(this.mainSence.getChildByName("SelectPlaceHasShow"))
         {
            this.mainSence.removeChild(this.mainSence.getChildByName("SelectPlaceHasShow"));
         }
         if(gm == null)
         {
            gm = AUtils.getNewObj("export.GameMenu") as GameMenu;
            gm.name = "GameMenuHasShow";
         }
         if(!this.mainSence.getChildByName("GameMenuHasShow"))
         {
            this.mainSence.addChild(gm);
         }
      }
      
      private function showTaskInterface(e:*) : void
      {
         var tif:* = null;
         if(gc.allTask)
         {
            tif = new TaskInterfaceAssets();
            this.mainSence.addChild(tif);
         }
         else
         {
            gc.ts.setTxt("正在初始化数据，请稍候");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function selectRole(e:*) : *
      {
         this.switchSence("SelectRole");
      }
      
      private function showSelectRolw() : void
      {
         var sr:SelectRoleAssets = new SelectRoleAssets();
         this.mainSence.addChild(sr);
      }
      
      private function gameOver(e:*) : void
      {
         this.switchSence("gameOver");
      }
      
      private function showGameOver() : void
      {
         this.clearGameWinAndLose();
         this.curState = "gameFinished";
         MusicManager.getInstance().play("over");
         var gf:GameFail = AUtils.getNewObj("export.lose.GameFail") as GameFail;
         gf.name = "GameFail";
         this.mainSence.addChild(gf);
      }
      
      private function clearGameWinAndLose() : void
      {
         var gf:DisplayObject = this.mainSence.getChildByName("GameFail");
         if(gf)
         {
            this.mainSence.removeChild(gf);
         }
         var gw:DisplayObject = this.mainSence.getChildByName("GameWinHasShow");
         if(gw)
         {
            this.mainSence.removeChild(gw);
         }
      }
      
      private function reStart(e:*) : void
      {
         this.switchSence("startFighting");
      }
      
      private function levelVictor(e:*) : void
      {
         var gw:* = null;
         this.clearGameWinAndLose();
         if(!(gc.curStageAndCurLevel.curStage == 41 && gc.curStageAndCurLevel.curLevel == 1))
         {
            this.curState = "gameFinished";
            if(this.mainSence.getChildByName("GameWinHasShow") == null)
            {
               gw = AUtils.getNewObj("export.win.GameWin") as GameWin;
               gw.name = "GameWinHasShow";
               this.mainSence.addChild(gw);
            }
         }
      }
      
      private function heroDead(e:CommonEvent) : void
      {
         e = e;
         var afterdead:* = AUtils.getNewObj("PlayerDeadMc");
         afterdead.x = e.data.x;
         afterdead.y = e.data.y;
         gc.gameSence.addChild(afterdead);
         if(gc.isSingleGame())
         {
            TweenMax.delayedCall(2.5,function():*
            {
               MainGame.getInstance().checkGameOver();
            });
         }
      }
      
      public function startGame(level:uint, stage:uint) : void
      {
         new MainGame(this.mainSence).GameStart();
      }
      
      private function doLoadOK() : void
      {
         var i:int = 0;
         var obj:* = undefined;
         gc.pWorld.destroy();
         for(i = 0; i < this.numChildren; )
         {
            obj = this.getChildAt(i);
            gc.pWorld.addSubObj(obj);
            i++;
         }
         this.switchSence("GameMenu");
      }
      
      private function loaderOver(e:*) : *
      {
         gc.eventManger.removeEventListener("loaderOver",loaderOver);
         AUtils.checkLoadOK(this,doLoadOK);
      }
      
      public function getMainSence() : Sprite
      {
         return this.mainSence;
      }
      
      public function get loader() : Aloader
      {
         return this._loader;
      }
      
      private function netSaveErrorHandler(evt:Event) : void
      {
         netError = true;
         var sr:SaveResult = new SaveResult(SaveResult.SAVE_NO);
         sr.x = 470;
         sr.y = 400;
         this.getTopSence().addChild(sr);
      }
      
      private function closePanelHandler(e:*) : void
      {
         var maskSprite:* = null;
         if(gc.loginAlert && gc.loginAlert.parent)
         {
            gc.loginAlert.parent.removeChild(gc.loginAlert);
            gc.loginAlert = null;
         }
         if(e is DataEvent)
         {
            trace("e.data =" + e.data);
            if(e.data == 8)
            {
               maskSprite = gc.stage.getChildByName("maskSprite") as Sprite;
               if(maskSprite && gc.stage.contains(maskSprite))
               {
                  gc.stage.removeChild(maskSprite);
                  maskSprite = null;
               }
            }
         }
      }
      
      private function onUserLogOutHandler(e:*) : void
      {
         var mc:* = null;
         trace("onUserLogOutHandler");
         try
         {
            ProxyFactory.getIns().destroyProxy(GameSocketProxy);
            ProxyFactory.getIns().destroyProxy(FbSocketProxy);
            ProxyFactory.getIns().destroyProxy(GateSocketProxy);
            mc = this.topSence.getChildByName("showLoadByStageAndLevelProgress") as MovieClip;
            if(!mc)
            {
               if(gc.saveInter)
               {
                  gc.saveInter.clearTxt();
               }
               if(this.curState != "gameStarted")
               {
                  gc.initData();
               }
               else
               {
                  if(!gc.isSingleGame())
                  {
                     gc.closeScoket();
                  }
                  if(MainGame.getInstance())
                  {
                     MainGame.getInstance().destroyMode();
                  }
               }
            }
            else
            {
               gc.initData();
            }
            gc.doWhenQuitLogin();
            gc.eventManger.dispatchEvent(new Event("logout"));
            if(this.mainSence)
            {
               while(this.mainSence.numChildren > 0)
               {
                  this.mainSence.removeChild(this.mainSence.getChildAt(0));
               }
            }
            FinancialInfo.loginAndOut(gc.logInfo.uid,0);
            gc.ts.setTxt("退出成功");
            this.stage.addChild(gc.ts);
            gc.logInfo = null;
            this.switchSence("GameMenu");
         }
         catch(e:*)
         {
            gc.initData();
            gc.doWhenQuitLogin();
            gc.ts.setTxt("退出游戏出错，请刷新网页");
            this.stage.addChild(gc.ts);
         }
      }
      
      private function onPayEventHandler(e:PayEvent) : void
      {
         var infoArray:* = null;
         var errorCode:* = 0;
         trace("支付事件类型--------->" + e.type + "  e.data is Boolean------>" + (e.data is Boolean));
         if(gc.stage.getChildByName("maskrenewalseMask") != null)
         {
            gc.stage.removeChild(gc.stage.getChildByName("maskrenewalseMask"));
         }
         switch(e.type)
         {
            case "logsuccess":
               trace("登录成功------>uid:" + e.data.uid + "  name:" + e.data.name);
               break;
            case "incMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("增加游戏币后的余额为：" + e.data.balance);
                  gc.eventManger.dispatchEvent(new CommonEvent("GetMoneySuccess",[e.data.balance]));
                  break;
               }
               trace("增加游戏币错误！");
               break;
            case "decMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("减少游戏币后的余额为：" + e.data.balance);
                  gc.gameVip.dataObject.lastMoney = int(e.data.balance);
                  if(gc.isingameshop || gc.lastPaymentString != "ConfigRenewalseEquipment")
                  {
                     gc.ts.setTxt("购买成功");
                     gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[e.data.balance]));
                  }
                  else
                  {
                     gc.ts.setTxt("续费成功");
                     gc.renewalseSuccess(e.data.balance);
                  }
               }
               else
               {
                  trace("减少游戏币错误！");
                  gc.ts.setTxt("购买失败");
               }
               gc.stage.addChild(gc.ts);
               break;
            case "getMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("获取游戏币余额为：" + e.data.balance);
                  gc.hasGetMoney = true;
                  gc.gameVip.setLastMoney(e.data.balance);
                  gc.getAllMoney(e.data.balance);
                  gc.eventManger.dispatchEvent(new CommonEvent("GetMoneySuccess",[e.data.balance]));
                  break;
               }
               gc.ts.setTxt("获取点券余额失败");
               gc.stage.addChild(gc.ts);
               trace("获取游戏币余额错误！");
               break;
            case "payMoney":
               trace("充值游戏币失败");
               break;
            case "paiedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("获取累积消费的游戏币为：" + e.data.balance);
                  gc.gameVip.setPaiedMoney(e.data.balance);
               }
               else
               {
                  gc.ts.setTxt("获取失败");
                  gc.stage.addChild(gc.ts);
                  trace("获取累积消费的游戏币错误！");
               }
               break;
            case "rechargedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  trace("获取总充值结果: -->>" + e.data.balance);
                  gc.gameVip.setAllMoney(e.data.balance);
                  gc.eventManger.dispatchEvent(new CommonEvent("ACHIEVEVIPDATAOVER"));
                  this.submitVipFailReSubmitTimes = 3;
               }
               else
               {
                  if(this.submitVipFailReSubmitTimes > 0)
                  {
                     gc.eventManger.dispatchEvent(new CommonEvent("VIPDATAREADING"));
                     this.submitVipFailReSubmitTimes--;
                  }
                  else
                  {
                     gc.ts.setTxt("总余额请求失败");
                     gc.stage.addChild(gc.ts);
                  }
                  trace("获取累积充值的游戏币错误！");
               }
               break;
            case "payError":
               if(e.data == null)
               {
                  break;
               }
               infoArray = String(e.data.info).split("|");
               errorCode = uint(infoArray[0]);
               switch(int(errorCode))
               {
                  case 0:
                     gc.ts.setTxt("支付接口错误，请退出重新登录！");
                     gc.stage.addChild(gc.ts);
                     gm.isremoveLoginAlert();
                     break;
                  case 1:
                     break;
                  case 2:
                     break;
                  case 3:
                     break;
                  case 4:
                     if(!gc.isingameshop)
                     {
                        gc.renewalseFail();
                     }
                     gc.eventManger.dispatchEvent(new CommonEvent("BuyFail"));
                     gc.ts.setTxt("购买失败");
                     gc.stage.addChild(gc.ts);
                     break;
                  case 5:
               }
               break;
         }
      }
      
      private function onRankListErrorHandler(evt:RankListEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         var obj:Object = evt.data;
         var str:String = "apiFlag:" + obj.apiName + "   errorCode:" + obj.code + "   message:" + obj.message + "\n";
         trace(str);
         var _loc5_:* = obj.apiName;
         if("3" === _loc5_)
         {
            if(this.submitFailReSubmitTimes > 0)
            {
               gc.ts.setTxt("提交战斗力失败,重新提交中");
               gc.stage.addChild(gc.ts);
               RankPropertyCount.submitRankScore(gc);
               this.submitFailReSubmitTimes--;
            }
            else
            {
               gc.ts.setTxt("提交战斗力连续失败3次,停止提交");
               gc.stage.addChild(gc.ts);
            }
         }
         if(int(obj.code) == 10005)
         {
            gc.ts.setTxt("请不要在一个浏览器登录2个4399帐号");
            gc.stage.addChild(gc.ts);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("RANKLISTERROR"));
      }
      
      private function onRankListSuccessHandler(evt:RankListEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         var obj:Object = evt.data;
         trace("apiFlag:" + obj.apiName + "\n");
         var data:* = obj.data;
         switch(obj.apiName)
         {
            case "1":
               break;
            case "2":
               decodeSelfRangeListInfo(data);
               break;
            case "4":
               decodeRankListInfo(data);
               break;
            case "3":
               decodeSumitScoreInfo(data);
               this.submitFailReSubmitTimes = 3;
               break;
            case "5":
               decodeUserData(data);
         }
      }
      
      private function decodeUserData(dataObj:Object) : void
      {
         if(dataObj == null)
         {
            trace("没有用户数据！\n");
            return;
         }
      }
      
      private function decodeSumitScoreInfo(dataAry:Array) : void
      {
         var tmpObj:* = null;
         var str:* = null;
         var code:* = null;
         if(dataAry == null)
         {
            trace("没有数据,返回结果有问题！\n");
            return;
         }
         for(var i in dataAry)
         {
            tmpObj = dataAry[i];
            str = "第" + (i + 1) + "条数据。排行榜ID：" + tmpObj.rId + ",当前排名:" + tmpObj.curRank + ",当前分数：" + tmpObj.curScore + ",上一局排名：" + tmpObj.lastRank + ",上一局分数：" + tmpObj.lastScore + "tmpObj.message: " + tmpObj.message + "\n";
            trace("战斗力提交成功-str:" + str);
            code = tmpObj.code;
            trace("code:" + code);
            if(code == "10000")
            {
               gc.ts.setTxt("提交成功");
               gc.stage.addChild(gc.ts);
               if(tmpObj.lastRank == 0)
               {
                  if(gc.dataObject.gongxun != 0 || gc.dataObject.challengeRankTimes != 30)
                  {
                     gc.dataObject.gongxun = 0;
                     gc.dataObject.challengeRankTimes = 30;
                     RankPropertyCount.submitRankScore(gc);
                  }
                  else
                  {
                     gc.eventManger.dispatchEvent(new CommonEvent("RANKSUBMITSUCCESS",[]));
                  }
               }
               else
               {
                  gc.eventManger.dispatchEvent(new CommonEvent("RANKSUBMITSUCCESS",[]));
               }
            }
            else if(code == "20005")
            {
               gc.rankhaslimit = true;
               gc.eventManger.dispatchEvent(new CommonEvent("SUBMITFAIL_RANKHASLOCK"));
            }
         }
      }
      
      private function decodeRankListInfo(dataAry:Array) : void
      {
         var tmpObj:* = null;
         var str:* = null;
         if(dataAry == null || dataAry.length == 0)
         {
            trace("没有数据！\n");
            gc.eventManger.dispatchEvent(new CommonEvent("ASKOWNRANKNULL"));
            return;
         }
         trace("decodeRankListInfo");
         for(var i in dataAry)
         {
            tmpObj = dataAry[i];
            str = "第" + (i + 1) + "条数据。存档索引：" + tmpObj.index + ",用户id:" + tmpObj.uId + ",用户名：" + tmpObj.userName + ",分数：" + tmpObj.score + ",排名：" + tmpObj.rank + ",来自：" + tmpObj.area + ",扩展信息：" + tmpObj.extra + "\n";
            trace(str);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("RANKLISTINFOSUCCESS",[dataAry]));
      }
      
      private function decodeSelfRangeListInfo(dataAry:Array) : void
      {
         var tmpObj:* = null;
         var str:* = null;
         if(dataAry == null || dataAry.length == 0)
         {
            trace("没有数据！\n");
            gc.eventManger.dispatchEvent(new CommonEvent("ASKOWNRANKNULL"));
            return;
         }
         trace("decodeSelfRangeListInfo");
         for(var i in dataAry)
         {
            tmpObj = dataAry[i];
            str = "第" + (i + 1) + "条数据。存档索引：" + tmpObj.index + ",用户id:" + tmpObj.uId + ",用户名：" + tmpObj.userName + ",分数：" + tmpObj.score + ",排名：" + tmpObj.rank + ",来自：" + tmpObj.area + ",扩展信息：" + tmpObj.extra + "\n";
            trace(str);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("SELFRANGELISTINFOSUCCESS",[dataAry]));
      }
      
      private function secondaryEventHandle(e:SecondaryEvent) : void
      {
         var playerNum:int = 0;
         var dataArr:* = null;
         trace("接收双人账号事件：" + e.type);
         var info:Object = e.data;
         if(info == null)
         {
            trace("双人账号事件获取数据失败!");
            return;
         }
         switch(e.type)
         {
            case "secondaryLogin":
               if(info.code == "20000")
               {
                  trace("次账号登录成功！   uid:" + info.uid + "   name:" + info.name + "   nickName:" + info.nickName);
                  gc.currentRead = 1;
                  gc.showReadSaveInter();
                  FinancialInfo.loginNew(info.uid);
                  AllianceSecondInterface.getIns().getKey(info.uid);
               }
               else
               {
                  trace("次账号登录失败！code:" + info.code);
               }
               break;
            case "secondaryLogOut":
               trace("次账号退出成功！");
               gc.doWhenSecondLogout();
               gc.ts.setTxt("退出成功");
               gc.stage.addChild(gc.ts);
               gc.eventManger.dispatchEvent(new Event("SECOND_QUIT_COMPLETE"));
               break;
            case "secondarySaveSet":
               if(info.code == "50000")
               {
                  trace("次账号保存存档成功！");
               }
               else
               {
                  trace("次账号保存存档失败！code:" + info.code);
               }
               break;
            case "secondarySaveGet":
               if(info.code == "40000")
               {
                  trace("次账号获得存档成功！index:" + info.data.index + ",data:" + info.data.data + ",datetime:" + info.data.datetime + ",title:" + info.data.title);
                  if(gc.loginAlert && gc.loginAlert.name == "LoginAlert" && gc.loginAlert.parent)
                  {
                     gc.loginAlert.parent.removeChild(gc.loginAlert);
                     gc.loginAlert = null;
                  }
                  if(gc.stage.getChildByName("ReadSaveDataMask"))
                  {
                     gc.stage.removeChild(gc.stage.getChildByName("ReadSaveDataMask"));
                  }
                  playerNum = info.data.data.playerNum;
                  if(playerNum >= 2)
                  {
                     gc.ts.setTxt("无法邀请双人档！");
                     gc.stage.addChild(gc.ts);
                  }
                  else
                  {
                     gc.memory.secondStorageValue(info.data.data);
                     gc.memory.getSecondStorage();
                     gc.ts.setTxt("读档成功");
                     gc.stage.addChild(gc.ts);
                     gc.eventManger.dispatchEvent(new Event("SECOND_GET_DATA_COMPLETE"));
                  }
               }
               else
               {
                  trace("次账号获得存档失败！code:" + info.code);
               }
               break;
            case "secondarySaveList":
               if(info.code == "30000")
               {
                  trace("次账号获得存档列表成功！");
                  if(gc.dealAlert && gc.dealAlert.name == "DealingAlert" && gc.dealAlert.parent)
                  {
                     gc.dealAlert.parent.removeChild(gc.dealAlert);
                     gc.dealAlert = null;
                  }
                  dataArr = info.data as Array;
                  if(gc.saveInter)
                  {
                     gc.saveInter.setIndex(dataArr);
                  }
               }
               else
               {
                  trace("次账号获得存档集合失败！code:" + info.code);
               }
         }
      }
      
      private function sendFiveYear() : void
      {
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         urlLoader.addEventListener("ioError",errorHandle);
         urlLoader.addEventListener("securityError",errorHandle);
         var urlVariables:URLVariables = new URLVariables();
         urlVariables.uid = gc.logInfo.uid;
         urlVariables.game_id = 1;
         var ctime:Date = new Date();
         urlVariables.time = ctime.getTime() / 1000;
         urlVariables.app_id = 38;
         var token:String = MD5.hash(urlVariables.app_id + "||" + urlVariables.game_id + "||" + urlVariables.time + "||" + urlVariables.uid + "||" + "/events/2014/fiveyear/login-counter" + "||" + "919e2199989011d08e1c37f03017a27b");
         urlVariables.token = token;
         var urlReuest:URLRequest = new URLRequest("http://my.4399.com/events/2014/fiveyear/login-counter");
         urlReuest.method = "POST";
         urlReuest.data = urlVariables;
         urlLoader.load(urlReuest);
      }
      
      protected function completeHandler(e:Event) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
      }
      
      protected function errorHandle(e:Event) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
      }
      
      private function sendPlayerLv() : void
      {
         urlLoader2 = new URLLoader();
         urlLoader2.dataFormat = "text";
         urlLoader2.addEventListener("complete",completeHandler2);
         urlLoader2.addEventListener("ioError",errorHandle2);
         urlLoader2.addEventListener("securityError",errorHandle2);
         var urlVariables:URLVariables = new URLVariables();
         urlVariables.ac = "getUserMaxLevel";
         urlVariables.uid = gc.logInfo.uid;
         var ctime:Date = new Date();
         urlVariables.time = Math.floor(ctime.getTime() / 1000);
         urlVariables.maxLevel = "zm3-" + gc.player1.getCurLevel();
         var key:String = "1c4f7c131963b1c0cc308b562f678c8d";
         var sign:String = MD5.hash(urlVariables.uid + urlVariables.time + urlVariables.maxLevel + key);
         urlVariables.sign = sign;
         var urlReuest:URLRequest = new URLRequest("https://huodong2.4399.com/2025/zmwsldgq/api/ajax_api.php");
         urlReuest.method = "POST";
         urlReuest.data = urlVariables;
         urlLoader2.load(urlReuest);
      }
      
      protected function completeHandler2(e:Event) : void
      {
         urlLoader2.removeEventListener("complete",completeHandler2);
         urlLoader2.removeEventListener("ioError",errorHandle2);
         urlLoader2.removeEventListener("securityError",errorHandle2);
      }
      
      protected function errorHandle2(e:Event) : void
      {
         urlLoader2.removeEventListener("complete",completeHandler2);
         urlLoader2.removeEventListener("ioError",errorHandle2);
         urlLoader2.removeEventListener("securityError",errorHandle2);
      }
   }
}
