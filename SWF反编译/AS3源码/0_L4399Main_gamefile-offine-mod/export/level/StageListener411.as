package export.level
{
   import AssetsClass.ChildrenDayAssets;
   import AssetsClass.EightImmortalsInterfaceAssets;
   import AssetsClass.InvitationAssets;
   import AssetsClass.RankTopAssets;
   import AssetsClass.SevenStarInteraceAssets;
   import AssetsClass.ValentinesInterfaceAssets;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.ControlFactory;
   import event.CommonEvent;
   import export.alliance.AllianceInterfaceShow;
   import export.huodong.advertising.YaYaLeBitTurntableInterface;
   import export.huodong.kunlun.KunlunMountains;
   import export.huodong.newyear.NewYearFirecracker;
   import export.huodong.newyear.NewYearFireworks;
   import export.huodong.newyear.NewYearLantern;
   import export.huodong.worldtransfrom.TransfromInterface;
   import export.level.StageListener411Children.Bianpao;
   import export.level.StageListener411Children.Clock;
   import export.level.StageListener411Children.Xiannv;
   import export.level.StageListener411Children.Yanhua;
   import export.mirror.MirrorInterface;
   import export.monster.Monster154;
   import export.queenmother.QueenMotherInterface;
   import export.queenmother.XiaoLongNvInterface;
   import export.renewalse.RenewalseThisSZ;
   import export.renewalse.shiershengxiaoChoose;
   import export.taskInterface.RewardTaskInterface;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import loader.HttpLoader;
   import mvc.control.SocketsSendControl;
   import mvc.controllor.ProtocalControl;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener411 extends BaseLevelListenering
   {
       
      
      private var xiannv:Xiannv;
      
      private var paihangbang:MovieClip;
      
      private var curShowSprite:DisplayObjectContainer;
      
      private var rwDoor:MovieClip;
      
      private var zhaoyaojing:MirrorInterface;
      
      private var bgMask:Bitmap;
      
      private var floorMask:Bitmap;
      
      private var clock:Clock;
      
      private var bianpaoSprite:NewYearFirecracker;
      
      private var yanhuaSprite:NewYearFireworks;
      
      private var denglongSrptei:NewYearLantern;
      
      private var transferDoor:TransfromInterface;
      
      private var snowBoss:MovieClip;
      
      private var pkTransferDoor:MovieClip;
      
      private var alliacnceNpc:MovieClip;
      
      private var xiaolongnvNpc:MovieClip;
      
      private var qixiBtn:SimpleButton;
      
      private var baxianBtn:SimpleButton;
      
      private var doubuBtn:SimpleButton;
      
      private var sheridunc:MovieClip;
      
      private var liuyimc:MovieClip;
      
      private var qljbtn:SimpleButton;
      
      private var yjmbbtn:SimpleButton;
      
      private var newbtn12_3:SimpleButton;
      
      private var saveyuebingbutton:SimpleButton;
      
      private var childDayAss:SimpleButton;
      
      private var footballbtn:SimpleButton;
      
      private var tjjmbtn:SimpleButton;
      
      private var inviteBtn:SimpleButton;
      
      private var inviteBgDirect:int = 1;
      
      private var inviteGlow:GlowFilter;
      
      private var bianpao:Bianpao;
      
      private var yanhua:Yanhua;
      
      private var dl:Monster154;
      
      private var dlAppearCount:uint = 960;
      
      private var dlAppearCountConst:uint = 1440;
      
      private var lastPay:String = "";
      
      private var httpsLoader:HttpLoader;
      
      private var wangmu:MovieClip;
      
      private var wangwang:MovieClip;
      
      private var wangwangPanel:MovieClip;
      
      private var renewalse:RenewalseThisSZ;
      
      private var shiershengxiao:shiershengxiaoChoose;
      
      public function StageListener411()
      {
         this.httpsLoader = new HttpLoader();
         this.waitForRegisterDataArray = ["sl41xiannv"];
         super();
         gc.eventManger.addEventListener("stagelistener481denglongappear",__showDenglong);
         gc.eventManger.addEventListener("GoToPKSystem",__gotoPKSystem);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         shiershengxiao = new shiershengxiaoChoose();
         shiershengxiao.name = "shiershengxiaoChoose";
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "StageListener411")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.lastPaymentString = "";
         gc.gameVip.dataObject.lastMoney = e.data[0];
         if(this.lastPay == "football")
         {
            gc.curStageAndCurLevel.curStage = 60;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.lastPay == "saveyuebing")
         {
            gc.curStageAndCurLevel.curStage = 63;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.lastPay == "qljfb")
         {
            gc.curStageAndCurLevel.curStage = 15;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this.lastPay == "newbtn12_3")
         {
            gc.curStageAndCurLevel.curStage = 64;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else
         {
            if(this.lastPay == "sherifb")
            {
               gc.dataObject.houyifb2++;
               this.goIntoHouYiSheRi();
               return;
            }
            gc.curStageAndCurLevel.curStage = 61;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      override public function step() : void
      {
         super.step();
         if(this.dl)
         {
            if(this.dl.isReadyToDestroy)
            {
               this.dl = null;
            }
         }
         if(this.inviteBtn)
         {
            if(this.inviteBgDirect == 0)
            {
               if(this.inviteGlow.alpha == 1)
               {
                  this.inviteBgDirect = 1;
               }
               else
               {
                  this.inviteGlow.alpha += 0.05;
               }
            }
            else if(this.inviteGlow.alpha == 0)
            {
               this.inviteBgDirect = 0;
            }
            else
            {
               this.inviteGlow.alpha -= 0.05;
            }
            this.inviteBtn.filters = [this.inviteGlow];
         }
         if(this.footballbtn)
         {
            if(this.inviteBgDirect == 0)
            {
               if(this.inviteGlow.alpha == 1)
               {
                  this.inviteBgDirect = 1;
               }
               else
               {
                  this.inviteGlow.alpha += 0.05;
               }
            }
            else if(this.inviteGlow.alpha == 0)
            {
               this.inviteBgDirect = 0;
            }
            else
            {
               this.inviteGlow.alpha -= 0.05;
            }
            this.footballbtn.filters = [this.inviteGlow];
         }
         if(this.yjmbbtn)
         {
            if(this.inviteBgDirect == 0)
            {
               if(this.inviteGlow.alpha == 1)
               {
                  this.inviteBgDirect = 1;
               }
               else
               {
                  this.inviteGlow.alpha += 0.05;
               }
            }
            else if(this.inviteGlow.alpha == 0)
            {
               this.inviteBgDirect = 0;
            }
            else
            {
               this.inviteGlow.alpha -= 0.05;
            }
            this.yjmbbtn.filters = [this.inviteGlow];
         }
         if(this.newbtn12_3)
         {
            if(this.inviteBgDirect == 0)
            {
               if(this.inviteGlow.alpha == 1)
               {
                  this.inviteBgDirect = 1;
               }
               else
               {
                  this.inviteGlow.alpha += 0.05;
               }
            }
            else if(this.inviteGlow.alpha == 0)
            {
               this.inviteBgDirect = 0;
            }
            else
            {
               this.inviteGlow.alpha -= 0.05;
            }
            this.newbtn12_3.filters = [this.inviteGlow];
         }
         if(this.qljbtn)
         {
            if(this.inviteBgDirect == 0)
            {
               if(this.inviteGlow.alpha == 1)
               {
                  this.inviteBgDirect = 1;
               }
               else
               {
                  this.inviteGlow.alpha += 0.05;
               }
            }
            else if(this.inviteGlow.alpha == 0)
            {
               this.inviteBgDirect = 0;
            }
            else
            {
               this.inviteGlow.alpha -= 0.05;
            }
            this.qljbtn.filters = [this.inviteGlow];
         }
         if(this.xiannv)
         {
            this.xiannv.step();
         }
         if(this.yanhua)
         {
            this.yanhua.step();
         }
         if(this.bianpao)
         {
            this.bianpao.step();
         }
         if(this.snowBoss)
         {
            if(this.snowBoss.currentFrame == int(gc.dataObject.snowBossTimes) || this.snowBoss.currentFrame == this.snowBoss.totalFrames)
            {
               this.snowBoss.stop();
            }
         }
         if(this.dlAppearCount < this.dlAppearCountConst)
         {
            this.dlAppearCount++;
            if(this.dlAppearCount == this.dlAppearCountConst)
            {
               if(this.dl)
               {
                  this.dl.destroy();
                  this.dl = null;
               }
               this.showDenglong();
            }
         }
         if(this.bianpao && this.bianpaoSprite)
         {
            if(this.bianpao.isStarting())
            {
               this.bianpaoSprite.mouseEnabled = false;
               this.bianpaoSprite.mouseChildren = false;
            }
            else
            {
               this.bianpaoSprite.mouseEnabled = true;
               this.bianpaoSprite.mouseChildren = true;
            }
         }
         if(this.yanhua && this.yanhuaSprite)
         {
            if(this.yanhua.isStarting())
            {
               this.yanhuaSprite.mouseEnabled = false;
               this.yanhuaSprite.mouseChildren = false;
            }
            else
            {
               this.yanhuaSprite.mouseEnabled = true;
               this.yanhuaSprite.mouseChildren = true;
            }
         }
      }
      
      private function __showDenglong(evt:CommonEvent) : void
      {
         this.showDenglong();
      }
      
      private function showDenglong() : void
      {
         var dl:Number = NaN;
         if(gc.isBlack)
         {
            return;
         }
         if(!this.dl)
         {
            dl = gc.getNewYearThreeTreasure("dl");
            if(dl > 0)
            {
               this.dl = MainGame.getInstance().createMonster(154,gc.hero1.x,600) as Monster154;
               this.dlAppearCount = 0;
               this.dlAppearCountConst = gc.frameClips * (60 + RandomControllor.getIns().getRandom() * 60);
            }
         }
      }
      
      override public function start() : void
      {
         var uid:int = 0;
         var i:int = 0;
         var mc:MovieClip = null;
         if(!gc.isGetShengdanShoushen)
         {
            if(gc.logInfo)
            {
               uid = parseInt(gc.logInfo.uid);
               if(gc.shengdanShoushenArray.indexOf(uid) != -1)
               {
                  gc.dataObject.zhaoyaojingTimes = 3;
                  gc.isGetShengdanShoushen = true;
               }
            }
         }
         this.floorMask = AUtils.getImageObj("StageLister411BlackFloor") as Bitmap;
         this.floorMask.x = -22.05;
         this.floorMask.y = 497;
         gc.gameSence.addChild(this.floorMask);
         xiannv = new Xiannv();
         xiannv.x = 530;
         xiannv.y = 430;
         gc.gameSence.addChild(xiannv);
         wangmu = AUtils.getNewObj("wangmu") as MovieClip;
         wangmu.x = 730;
         wangmu.y = 430;
         gc.gameSence.addChild(wangmu);
         var flower:Bitmap = AUtils.getImageObj("sl41flower") as Bitmap;
         flower.x = -40;
         flower.y = 375;
         gc.gameSence.addChild(flower);
         paihangbang = AUtils.getNewObj("rankDoor") as MovieClip;
         paihangbang.x = 490;
         paihangbang.y = 70;
         gc.gameSence.addChild(paihangbang);
         this.rwDoor = AUtils.getNewObj("rewardWantedCircular") as MovieClip;
         this.rwDoor.graphics.beginFill(16711680,0);
         this.rwDoor.graphics.drawRect(-15,-15,30,30);
         this.rwDoor.graphics.endFill();
         this.rwDoor.x = 870;
         this.rwDoor.y = 350;
         gc.gameSence.addChild(this.rwDoor);
         this.xiaolongnvNpc = AUtils.getNewObj("xiaolongnvNpc") as MovieClip;
         this.xiaolongnvNpc.x = 1150;
         this.xiaolongnvNpc.y = 455;
         gc.gameSence.addChild(this.xiaolongnvNpc);
         this.snowBoss = AUtils.getNewObj("StageListener411SnowBoss") as MovieClip;
         this.snowBoss.x = 1119;
         this.snowBoss.y = -141;
         this.snowBoss.gotoAndStop(1);
         gc.gameSence.addChild(this.snowBoss);
         this.refreshSnowBoss();
         this.pkTransferDoor = AUtils.getNewObj("transferDoor") as MovieClip;
         this.pkTransferDoor.x = 1620;
         this.pkTransferDoor.y = 345;
         this.pkTransferDoor.gotoAndStop(1);
         gc.gameSence.addChild(this.pkTransferDoor);
         if(gc.isHideDebug)
         {
            pkTransferDoor.visible = false;
         }
         this.alliacnceNpc = AUtils.getNewObj("allianceNpc") as MovieClip;
         this.alliacnceNpc.x = 1420;
         this.alliacnceNpc.y = 415;
         gc.gameSence.addChild(this.alliacnceNpc);
         var keyW:MovieClip = AUtils.getNewObj("rankDoorW") as MovieClip;
         keyW.x = 1420;
         keyW.y = 280;
         gc.gameSence.addChild(keyW);
         super.start();
         this.bgMask = AUtils.getImageObj("StageLister411BlackBG") as Bitmap;
         this.bgMask.x = -20;
         this.bgMask.y = -933;
         gc.gameSence.bgContainer.addChild(this.bgMask);
         this.showMaskByTime();
         var ta:Array = gc.pWorld.getTransferDoorArray();
         i = 0;
         while(i < ta.length)
         {
            mc = ta[i];
            mc.visible = true;
            i++;
         }
         var startX:Number = 230;
         this.zhaoyaojing = new MirrorInterface();
         this.zhaoyaojing.x = startX;
         this.zhaoyaojing.y = 0;
         gc.gameInfo.addChild(this.zhaoyaojing);
         this.clock = new Clock();
         this.clock.x = 1085;
         this.clock.y = -70;
         gc.gameSence.addChild(this.clock);
         this.clock.showByTime();
         this.bianpaoSprite = new NewYearFirecracker();
         this.bianpaoSprite.x = startX + 200;
         this.bianpaoSprite.outsideDoFunction = showBianpao;
         gc.gameInfo.addChild(this.bianpaoSprite);
         if(gc.isBlack)
         {
            this.bianpaoSprite.visible = false;
         }
         this.yanhuaSprite = new NewYearFireworks();
         this.yanhuaSprite.x = startX + 300;
         this.yanhuaSprite.outsideDoFunction = showYanhua;
         gc.gameInfo.addChild(this.yanhuaSprite);
         if(gc.isBlack)
         {
            this.yanhuaSprite.visible = false;
         }
         this.denglongSrptei = new NewYearLantern();
         this.denglongSrptei.x = startX + 400;
         this.denglongSrptei.y = 10;
         gc.gameInfo.addChild(this.denglongSrptei);
         if(gc.isBlack)
         {
            this.denglongSrptei.visible = false;
         }
         this.transferDoor = new TransfromInterface();
         this.transferDoor.x = startX + 100;
         this.transferDoor.y = 0;
         gc.gameInfo.addChild(this.transferDoor);
         this.childDayAss = AUtils.getNewObj("childrenbutton") as SimpleButton;
         this.childDayAss.x = startX + 390;
         this.childDayAss.y = 95;
         gc.gameInfo.addChild(this.childDayAss);
         this.childDayAss.tabEnabled = false;
         this.childDayAss.addEventListener("click",childDayClick);
         this.childDayAss.visible = false;
         this.footballbtn = AUtils.getNewObj("footballbutton") as SimpleButton;
         this.footballbtn.x = startX + 490;
         this.footballbtn.y = 90;
         gc.gameInfo.addChild(this.footballbtn);
         this.footballbtn.tabEnabled = false;
         this.footballbtn.addEventListener("click",footballClick);
         this.baxianBtn = AUtils.getNewObj("baxianBtn") as SimpleButton;
         this.baxianBtn.x = startX + 390;
         this.baxianBtn.y = 91;
         gc.gameInfo.addChild(this.baxianBtn);
         this.baxianBtn.tabEnabled = false;
         this.baxianBtn.addEventListener("click",baxianClick);
         this.liuyimc = AUtils.getNewObj("childrenbutton__temp") as MovieClip;
         this.liuyimc.x = startX + 590;
         this.liuyimc.y = 10;
         gc.gameInfo.addChild(this.liuyimc);
         this.liuyimc.tabEnabled = false;
         this.liuyimc.buttonMode = true;
         this.liuyimc.addEventListener("click",childDayClick);
         this.inviteBtn = AUtils.getNewObj("inviteBtn") as SimpleButton;
         gc.gameInfo.addChild(this.inviteBtn);
         this.inviteBtn.x = startX;
         this.inviteBtn.y = 90;
         this.inviteBtn.addEventListener("click",__invite);
         this.inviteBtn.tabEnabled = false;
         this.inviteGlow = new GlowFilter(16776960,1,8,8,5);
         this.tjjmbtn = AUtils.getNewObj("tjjmbutton") as SimpleButton;
         this.tjjmbtn.x = startX + 90;
         this.tjjmbtn.y = 90;
         gc.gameInfo.addChild(this.tjjmbtn);
         this.tjjmbtn.tabEnabled = false;
         this.tjjmbtn.visible = false;
         this.tjjmbtn.addEventListener("click",tjjmClick);
         this.yjmbbtn = AUtils.getNewObj("yjmbbutton") as SimpleButton;
         this.yjmbbtn.x = startX + 90;
         this.yjmbbtn.y = 90;
         gc.gameInfo.addChild(this.yjmbbtn);
         this.yjmbbtn.tabEnabled = false;
         this.yjmbbtn.addEventListener("click",yjmbClick);
         this.newbtn12_3 = AUtils.getNewObj("newbtn12_3") as SimpleButton;
         this.newbtn12_3.x = startX + 190;
         this.newbtn12_3.y = 100;
         gc.gameInfo.addChild(this.newbtn12_3);
         this.newbtn12_3.tabEnabled = false;
         this.newbtn12_3.addEventListener("click",newbtn12_3Click);
         this.wangwang = AUtils.getNewObj("wangwang") as MovieClip;
         this.wangwang.x = startX + 800;
         this.wangwang.y = 500;
         gc.gameSence.addChildAt(this.wangwang,gc.gameSence.getChildIndex(gc.hero1));
         this.wangwang.tabEnabled = false;
         this.wangwang.buttonMode = true;
         this.wangwang.addEventListener("click",wangwangClick);
         this.doubuBtn = AUtils.getNewObj("doubuBtn") as SimpleButton;
         this.doubuBtn.x = startX + 270;
         this.doubuBtn.y = 90;
         gc.gameInfo.addChild(this.doubuBtn);
         this.doubuBtn.tabEnabled = false;
         this.doubuBtn.addEventListener("click",doubuClick);
         this.sheridunc = AUtils.getNewObj("sheridunc") as MovieClip;
         if(gc.isBlack)
         {
            this.sheridunc.x = startX + 200;
         }
         else
         {
            this.sheridunc.x = startX + 490;
         }
         this.sheridunc.y = 0;
         this.sheridunc.play();
         gc.gameInfo.addChild(this.sheridunc);
         this.sheridunc.buttonMode = true;
         this.sheridunc.addEventListener("click",sheriFuBen);
         gc.eventManger.addEventListener("SECOND_GET_DATA_COMPLETE",__autoInvite);
         gc.eventManger.addEventListener("SECOND_QUIT_COMPLETE",__autoInvite);
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
      }
      
      protected function __autoInvite(evt:Event) : void
      {
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function __invite(e:MouseEvent) : void
      {
         var ia:InvitationAssets = null;
         if(gc.playNum >= 2)
         {
            gc.ts.setTxt("双人存档不可再继续读取存档");
            gc.stage.addChild(gc.ts);
            return;
         }
         var obj:Object = GMain.serviceHold.isSecondaryLog;
         if(!obj)
         {
            GMain.serviceHold.showSecondaryLogPanel();
         }
         else
         {
            if(gc.gameInfo.getChildByName("InvitationAssets"))
            {
               return;
            }
            ia = new InvitationAssets();
            ia.name = "InvitationAssets";
            gc.gameInfo.addChild(ia);
         }
      }
      
      private function footballClick(e:MouseEvent) : void
      {
         if(gc.dataObject.chanllengeFootBall == false || gc.dataObject.chanllengeFootBall == "false")
         {
            gc.dataObject.chanllengeFootBall = true;
            gc.curStageAndCurLevel.curStage = 60;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            this.lastPay = "football";
            this.addRenewalseMask("您确定要花费200点券再进一次?");
         }
      }
      
      private function qljfbClick(e:MouseEvent) : void
      {
         if(gc.dataObject.chanllengeQLJFuBen == false || gc.dataObject.chanllengeQLJFuBen == "false")
         {
            gc.dataObject.chanllengeQLJFuBen = true;
            gc.curStageAndCurLevel.curStage = 15;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            this.lastPay = "qljfb";
            this.addRenewalseMask("您确定要花费200点券再进一次?");
         }
      }
      
      private function shybClick(e:MouseEvent) : void
      {
         if(gc.dataObject.chanllengeShouHuYueBing2 == false || gc.dataObject.chanllengeShouHuYueBing2 == "false")
         {
            gc.dataObject.chanllengeShouHuYueBing2 = true;
            gc.curStageAndCurLevel.curStage = 63;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            this.lastPay = "saveyuebing";
            this.addRenewalseMask("您确定要花费200点券再进一次?");
         }
      }
      
      private function yjmbClick(e:MouseEvent) : void
      {
         if(gc.dataObject.chanllengeYJMB == false || gc.dataObject.chanllengeYJMB == "false")
         {
            gc.dataObject.chanllengeYJMB = true;
            gc.curStageAndCurLevel.curStage = 61;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            this.lastPay = "yjmb";
            this.addRenewalseMask("您确定要花费200点券再进一次?");
         }
      }
      
      private function wangwangClick(e:MouseEvent) : void
      {
         if(!this.wangwangPanel)
         {
            this.wangwangPanel = AUtils.getNewObj("wangwangPanel") as MovieClip;
            gc.gameInfo.addChild(this.wangwangPanel);
            this.wangwangPanel.x = 50;
            this.wangwangPanel.y = 200;
            this.wangwangPanel["okbtn"].addEventListener("click",this.wangwangPanelClick);
            this.wangwangPanel["nobtn"].addEventListener("click",this.wangwangPanelClick);
         }
      }
      
      private function wangwangPanelClick(evt:MouseEvent) : void
      {
         if(evt.target.name == "okbtn")
         {
            gc.openUrl("https://www.4399.com/flash/210650.htm");
         }
         else
         {
            this.wangwangPanel["okbtn"].removeEventListener("click",this.wangwangPanelClick);
            this.wangwangPanel["nobtn"].removeEventListener("click",this.wangwangPanelClick);
            if(this.wangwangPanel && gc.gameInfo.contains(this.wangwangPanel))
            {
               gc.gameInfo.removeChild(this.wangwangPanel);
               this.wangwangPanel = null;
            }
         }
      }
      
      private function newbtn12_3Click(e:MouseEvent) : void
      {
         this.toShierShengxiaoGame(e);
      }
      
      private function toShierShengxiaoGame(evt:MouseEvent) : void
      {
         if(shiershengxiao && gc.gameInfo.contains(shiershengxiao))
         {
            gc.gameInfo.removeChild(shiershengxiao);
         }
         gc.monsterIdforStage641 = 221;
         if(gc.dataObject.chanllengenew12_3 == false || gc.dataObject.chanllengenew12_3 == "false")
         {
            gc.dataObject.chanllengenew12_3 = true;
            gc.curStageAndCurLevel.curStage = 64;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         else
         {
            this.lastPay = "newbtn12_3";
            this.addRenewalseMask("您确定要花费200点券再进一次?");
         }
      }
      
      private function tjjmClick(e:MouseEvent) : void
      {
         var yyl:YaYaLeBitTurntableInterface = new YaYaLeBitTurntableInterface();
         gc.gameInfo.addChild(yyl);
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         gc.gameInfo.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         gc.lastPaymentString = "StageListener411";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         this.lastPay = "";
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      private function childDayClick(e:MouseEvent) : void
      {
         if(gc.gameInfo.getChildByName("ChildrenDayAssets"))
         {
            return;
         }
         var cd:ChildrenDayAssets = new ChildrenDayAssets();
         cd.name = "ChildrenDayAssets";
         gc.gameInfo.addChild(cd);
      }
      
      private function baxianClick(e:MouseEvent) : void
      {
         var eiia:EightImmortalsInterfaceAssets = new EightImmortalsInterfaceAssets();
         gc.gameInfo.addChild(eiia);
      }
      
      private function doubuClick(e:MouseEvent) : void
      {
         var ssia:SevenStarInteraceAssets = new SevenStarInteraceAssets();
         gc.gameInfo.addChild(ssia);
      }
      
      private function qixiClick(e:MouseEvent) : void
      {
         var vdi:ValentinesInterfaceAssets = new ValentinesInterfaceAssets();
         gc.gameInfo.addChild(vdi);
      }
      
      private function aaaa() : void
      {
         this.gotoPK();
      }
      
      private function refreshSnowBoss() : void
      {
         var door:MovieClip = null;
         var www:MovieClip = null;
         if(this.snowBoss.currentFrame < gc.dataObject.snowBossTimes)
         {
            this.snowBoss.play();
         }
         if(gc.dataObject.snowBossTimes >= 100)
         {
            door = AUtils.getNewObj("TranfserDoorLight") as MovieClip;
            door.y = 60;
            this.snowBoss.addChild(door);
            www = AUtils.getNewObj("rankDoorW") as MovieClip;
            this.snowBoss.addChild(www);
         }
      }
      
      private function showMaskByTime() : void
      {
         var hour:uint = uint((gc.dataObjectInstance.curTime as String).split(":")[0]);
         this.bgMask.alpha = Math.abs(12 - hour) / 12;
         this.floorMask.alpha = this.bgMask.alpha;
      }
      
      private function turnAroundTime() : void
      {
      }
      
      private function bgMaskToHide() : void
      {
         if(this.bgMask)
         {
            TweenMax.to(this.bgMask,10,{
               "alpha":0,
               "onComplete":function(_self:StageListener411):*
               {
                  _self.bgMaskToShow();
               },
               "onCompleteParams":[this]
            });
         }
         if(this.floorMask)
         {
            TweenMax.to(this.floorMask,10,{"alpha":0});
         }
      }
      
      private function bgMaskToShow() : void
      {
         if(this.bgMask)
         {
            TweenMax.to(this.bgMask,10,{
               "alpha":1,
               "onComplete":function(_self:StageListener411):*
               {
                  _self.bgMaskToHide();
               },
               "onCompleteParams":[this]
            });
         }
         if(this.floorMask)
         {
            TweenMax.to(this.floorMask,10,{"alpha":1});
         }
      }
      
      private function showBianpao() : void
      {
         var point:Point = null;
         point = null;
         if(!this.bianpao)
         {
            this.bianpao = new Bianpao();
         }
         if(!this.bianpao.isStarting())
         {
            gc.dataObject.snowBossTimes += 10;
            gc.ts.setTxt("年兽灵珠经验增加");
            gc.stage.addChild(gc.ts);
            this.refreshSnowBoss();
            point = gc.gameSence.globalToLocal(new Point(470,295));
            this.bianpao.x = point.x;
            this.bianpao.y = point.y;
            this.bianpao.start();
            gc.gameSence.addChild(this.bianpao);
         }
      }
      
      private function showYanhua() : void
      {
         var point:Point = null;
         if(!this.yanhua)
         {
            this.yanhua = new Yanhua();
         }
         if(!this.yanhua.isStarting())
         {
            gc.dataObject.snowBossTimes += 15;
            gc.ts.setTxt("年兽灵珠经验增加");
            gc.stage.addChild(gc.ts);
            this.refreshSnowBoss();
            point = gc.gameSence.globalToLocal(new Point(470,295));
            this.yanhua.x = point.x;
            this.yanhua.y = point.y + 160;
            this.yanhua.start();
            gc.gameSence.addChild(this.yanhua);
         }
      }
      
      override public function keyBoardDownForWAtCommon(hero:BaseHero) : void
      {
         if(!this.curShowSprite)
         {
            if(this.xiannv)
            {
               if(AUtils.GetDisBetweenTwoObj(hero,this.xiannv) <= 40)
               {
                  if(gc.getAverageLevel() < 15)
                  {
                     gc.ts.setTxt("等级不足15级");
                     gc.stage.addChild(gc.ts);
                     return;
                  }
                  this.gotoKunlunShanDefence();
                  return;
               }
            }
            if(this.wangmu)
            {
               if(AUtils.GetDisBetweenTwoObj(hero,this.wangmu) <= 40)
               {
                  this.gotoWangmu();
                  return;
               }
            }
            if(this.xiaolongnvNpc)
            {
               if(AUtils.GetDisBetweenTwoObj(hero,this.xiaolongnvNpc) <= 40)
               {
                  this.gotoXiaoLongNv();
                  return;
               }
            }
            if(this.paihangbang)
            {
               if(AUtils.GetDisBetweenTwoObj(hero,this.paihangbang) <= 40)
               {
                  this.gotoRank();
                  return;
               }
            }
            if(this.rwDoor)
            {
               if(Math.abs(hero.x - (this.rwDoor.x + this.rwDoor.width / 2)) <= 60 && hero.y > this.rwDoor.y)
               {
                  this.gotoRW();
                  return;
               }
            }
            if(this.snowBoss)
            {
               if(gc.dataObject.snowBossTimes >= 100)
               {
                  if(Math.abs(hero.x - this.snowBoss.x) <= 60 && Math.abs(hero.y - this.snowBoss.y) <= 200)
                  {
                     this.gotoSnowBoss();
                     return;
                  }
               }
            }
            if(this.alliacnceNpc)
            {
               if(Math.abs(hero.x - this.alliacnceNpc.x) <= 60 && Math.abs(hero.y - this.alliacnceNpc.y) <= 80)
               {
                  this.gotoAlliance();
                  return;
               }
            }
         }
      }
      
      private function gotoWangmu() : void
      {
         var wangmu:QueenMotherInterface = new QueenMotherInterface();
         wangmu.addEventListener("removedFromStage",__klmRemoveFromStage,false,0,true);
         GMain.getInstance().getMainSence().addChild(wangmu);
         this.curShowSprite = wangmu;
      }
      
      private function gotoXiaoLongNv() : void
      {
         var wangmu:XiaoLongNvInterface = new XiaoLongNvInterface();
         wangmu.addEventListener("removedFromStage",__klmRemoveFromStage,false,0,true);
         GMain.getInstance().getMainSence().addChild(wangmu);
         this.curShowSprite = wangmu;
      }
      
      private function gotoAlliance() : void
      {
         var allianceShow:AllianceInterfaceShow = AUtils.getNewObj("export.alliance.AllianceInterfaceShow") as AllianceInterfaceShow;
         GMain.getInstance().getMainSence().addChild(allianceShow);
         allianceShow.addEventListener("removedFromStage",__retiRemoveFromStage,false,0,true);
         this.curShowSprite = allianceShow;
      }
      
      private function gotoPK() : void
      {
         if(gc.isPkOk == -1)
         {
            gc.isPkOk = 1;
            this.pkCheckOk();
         }
         else if(gc.isPkOk == 0)
         {
            this.pkCheckFail();
         }
         else
         {
            this.pkCheckOk();
         }
      }
      
      private function pkCheckComplete(data:*) : void
      {
         if(data == 1)
         {
            gc.isPkOk = 1;
            this.pkCheckOk();
         }
         else
         {
            gc.isPkOk = 0;
            this.pkCheckFail();
         }
      }
      
      private function pkCheckFail() : void
      {
         gc.ts.setTxt("PK场维护中，请到群组查看最新消息!");
         gc.stage.addChild(gc.ts);
      }
      
      private function pkCheckOk() : void
      {
         if(!gc.checkWebUid())
         {
            gc.ts.setTxt("当前游戏帐号不是最新登录的帐号！请刷新游戏");
            gc.stage.addChild(gc.ts);
            return;
         }
         GameConst.GATE_IP = "121.14.45.180";
         GameConst.GATE_PORT = 4001;
         ControlFactory.getIns().initControl(SocketsSendControl);
         ControlFactory.getIns().initControl(ProtocalControl);
         gc.curStageAndCurLevel.curStage = 0;
         gc.curStageAndCurLevel.curLevel = 1;
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function gotoSnowBoss() : void
      {
         gc.dataObject.snowBossTimes = 0;
         gc.curStageAndCurLevel.curStage = 57;
         gc.curStageAndCurLevel.curLevel = 1;
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function gotoRW() : void
      {
         var rti:RewardTaskInterface = new RewardTaskInterface();
         GMain.getInstance().getMainSence().addChild(rti);
         rti.addEventListener("removedFromStage",__retiRemoveFromStage,false,0,true);
         this.curShowSprite = rti;
      }
      
      private function __retiRemoveFromStage(evt:Event) : void
      {
         this.curShowSprite = null;
      }
      
      private function gotoKunlunShanDefence() : void
      {
         var klm:KunlunMountains = new KunlunMountains();
         klm.addEventListener("removedFromStage",__klmRemoveFromStage,false,0,true);
         GMain.getInstance().getMainSence().addChild(klm);
         this.curShowSprite = klm;
      }
      
      private function __klmRemoveFromStage(evt:Event) : void
      {
         this.curShowSprite = null;
      }
      
      private function gotoRank() : void
      {
         var rti:RankTopAssets = new RankTopAssets();
         rti.addEventListener("removedFromStage",__rtiRemoveFromStage,false,0,true);
         GMain.getInstance().getMainSence().addChild(rti);
         this.curShowSprite = rti;
      }
      
      private function __rtiRemoveFromStage(evt:Event) : void
      {
         trace("======__rtiRemoveFromStage=====");
         this.curShowSprite = null;
      }
      
      private function __gotoPKSystem(e:CommonEvent) : void
      {
         trace("===================__gotoPKSystem=====================");
         gc.isDirectGoToRoomChoose = true;
         this.gotoPK();
      }
      
      private function sheriFuBen(e:MouseEvent) : void
      {
         if(int(gc.dataObject.houyifb2) <= 0)
         {
            this.lastPay = "sherifb";
            this.addRenewalseMask("您确定花200点券再进一次吗？");
            return;
         }
         this.goIntoHouYiSheRi();
      }
      
      private function goIntoHouYiSheRi() : void
      {
         gc.dataObject.houyifb2--;
         gc.stage531Type = 1;
         gc.curStageAndCurLevel.curStage = 53;
         gc.curStageAndCurLevel.curLevel = 1;
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      override public function destroy() : void
      {
         this.dl = null;
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         gc.eventManger.removeEventListener("GoToPKSystem",__gotoPKSystem);
         gc.eventManger.removeEventListener("stagelistener481denglongappear",__showDenglong);
         gc.eventManger.removeEventListener("SECOND_GET_DATA_COMPLETE",__autoInvite);
         gc.eventManger.removeEventListener("SECOND_QUIT_COMPLETE",__autoInvite);
         if(this.alliacnceNpc)
         {
            if(this.alliacnceNpc.parent)
            {
               this.alliacnceNpc.parent.removeChild(this.alliacnceNpc);
            }
         }
         if(this.curShowSprite)
         {
            if(this.curShowSprite.parent)
            {
               this.curShowSprite.parent.removeChild(this.curShowSprite);
            }
         }
         if(bgMask)
         {
            if(bgMask.parent)
            {
               bgMask.parent.removeChild(bgMask);
            }
            bgMask.bitmapData.dispose();
            bgMask = null;
         }
         if(this.floorMask)
         {
            if(this.floorMask.parent)
            {
               this.floorMask.parent.removeChild(floorMask);
            }
            this.floorMask.bitmapData.dispose();
            this.floorMask = null;
         }
         if(this.clock)
         {
            this.clock.destroy();
            this.clock = null;
         }
         if(this.inviteBtn)
         {
            this.inviteBtn.removeEventListener("click",__invite);
            if(this.inviteBtn.parent)
            {
               this.inviteBtn.parent.removeChild(this.inviteBtn);
            }
            this.inviteBtn = null;
         }
         if(this.zhaoyaojing)
         {
            if(this.zhaoyaojing.parent)
            {
               this.zhaoyaojing.parent.removeChild(this.zhaoyaojing);
            }
            this.zhaoyaojing = null;
         }
         if(this.bianpaoSprite)
         {
            if(this.bianpaoSprite.parent)
            {
               this.bianpaoSprite.parent.removeChild(this.bianpaoSprite);
            }
            this.bianpaoSprite = null;
         }
         if(this.yanhuaSprite)
         {
            if(this.yanhuaSprite.parent)
            {
               this.yanhuaSprite.parent.removeChild(this.yanhuaSprite);
            }
            this.yanhuaSprite = null;
         }
         if(this.denglongSrptei)
         {
            if(this.denglongSrptei.parent)
            {
               this.denglongSrptei.parent.removeChild(this.denglongSrptei);
            }
            this.denglongSrptei = null;
         }
         if(this.transferDoor)
         {
            if(this.transferDoor.parent)
            {
               this.transferDoor.parent.removeChild(this.transferDoor);
            }
            this.transferDoor = null;
         }
         if(this.bianpao)
         {
            this.bianpao.destroy();
            this.bianpao = null;
         }
         if(this.snowBoss)
         {
            if(this.snowBoss.parent)
            {
               this.snowBoss.parent.removeChild(this.snowBoss);
            }
            this.snowBoss.stop();
            this.snowBoss = null;
         }
         if(this.pkTransferDoor)
         {
            if(this.pkTransferDoor.parent)
            {
               this.pkTransferDoor.parent.removeChild(this.pkTransferDoor);
            }
            this.pkTransferDoor.stop();
            this.pkTransferDoor = null;
         }
         if(this.wangmu)
         {
            if(this.wangmu.parent)
            {
               this.wangmu.parent.removeChild(this.wangmu);
            }
            this.wangmu.stop();
            this.wangmu = null;
         }
         if(this.yanhua)
         {
            this.yanhua.destroy();
            this.yanhua = null;
         }
         if(this.httpsLoader)
         {
            this.httpsLoader.destroy();
         }
         if(this.footballbtn)
         {
            this.footballbtn.removeEventListener("click",footballClick);
            if(this.footballbtn.parent)
            {
               this.footballbtn.parent.removeChild(this.footballbtn);
            }
            this.footballbtn = null;
         }
         if(this.yjmbbtn)
         {
            this.yjmbbtn.removeEventListener("click",yjmbClick);
            if(this.yjmbbtn.parent)
            {
               this.yjmbbtn.parent.removeChild(this.yjmbbtn);
            }
            this.yjmbbtn = null;
         }
         if(this.saveyuebingbutton)
         {
            this.saveyuebingbutton.removeEventListener("click",shybClick);
            if(this.saveyuebingbutton.parent)
            {
               this.saveyuebingbutton.parent.removeChild(this.saveyuebingbutton);
            }
            this.saveyuebingbutton = null;
         }
         if(this.qljbtn)
         {
            this.qljbtn.removeEventListener("click",qljfbClick);
            if(this.qljbtn.parent)
            {
               this.qljbtn.parent.removeChild(this.qljbtn);
            }
            this.qljbtn = null;
         }
         if(this.newbtn12_3)
         {
            this.newbtn12_3.removeEventListener("click",newbtn12_3Click);
            if(this.newbtn12_3.parent)
            {
               this.newbtn12_3.parent.removeChild(this.newbtn12_3);
            }
            this.newbtn12_3 = null;
         }
         if(this.wangwang)
         {
            this.wangwang.removeEventListener("click",wangwangClick);
            this.newbtn12_3 = null;
         }
         if(this.childDayAss)
         {
            this.childDayAss.removeEventListener("click",childDayClick);
            if(this.childDayAss.parent)
            {
               this.childDayAss.parent.removeChild(this.childDayAss);
            }
            this.childDayAss = null;
         }
         if(this.baxianBtn)
         {
            this.baxianBtn.removeEventListener("click",baxianClick);
         }
         if(this.qixiBtn)
         {
            this.qixiBtn.removeEventListener("click",qixiClick);
         }
         if(this.doubuBtn)
         {
            this.doubuBtn.removeEventListener("click",doubuClick);
         }
         if(this.tjjmbtn)
         {
            this.tjjmbtn.removeEventListener("click",tjjmClick);
            if(this.tjjmbtn.parent)
            {
               this.tjjmbtn.parent.removeChild(this.tjjmbtn);
            }
            this.tjjmbtn = null;
         }
         if(this.sheridunc)
         {
            this.sheridunc.removeEventListener("click",sheriFuBen);
            if(this.sheridunc.parent)
            {
               this.sheridunc.parent.removeChild(this.sheridunc);
            }
            this.sheridunc = null;
         }
         super.destroy();
      }
   }
}
