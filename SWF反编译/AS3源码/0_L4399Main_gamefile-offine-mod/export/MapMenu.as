package export
{
   import AssetsClass.ActivityInterfaceAssets;
   import AssetsClass.EightImmortalsInterfaceAssets;
   import AssetsClass.GameVipInterfaceAssets;
   import AssetsClass.NewYear2014Assets;
   import AssetsClass.RegistrationActivityAssets;
   import AssetsClass.SevenStarInteraceAssets;
   import AssetsClass.ValentinesInterfaceAssets;
   import config.Config;
   import event.CommonEvent;
   import export.auth4399.Auth4399MainView;
   import export.bigzp.ErrorInfo;
   import export.honor.AllianceSprite;
   import export.huodong.ExchangeScore;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.DebugArea;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   import test.TestAddEquipment;
   
   public class MapMenu extends Sprite
   {
       
      
      private var gc:Config;
      
      public var showBuySkill:SimpleButton;
      
      public var ldl:SimpleButton;
      
      public var gradenbtn:SimpleButton;
      
      public var scgm:SimpleButton;
      
      public var savebtn:SimpleButton;
      
      public var saveInterval:TextField;
      
      public var btnback:SimpleButton;
      
      public var huodongbtn:SimpleButton;
      
      public var rwbtn:SimpleButton;
      
      public var vipicon:MovieClip;
      
      public var bxghbtn:SimpleButton;
      
      public var qrjbtn:SimpleButton;
      
      public var kaixuebtn:SimpleButton;
      
      public var changeNameBtn:SimpleButton;
      
      public var ldbtn:SimpleButton;
      
      public var sjwBtn:SimpleButton;
      
      public var qingmingbtn:MovieClip;
      
      public var qznbtn:MovieClip;
      
      private var renewalse:RenewalseThisSZ;
      
      public var dzbtn:SimpleButton;
      
      private var backSecBtn:SimpleButton;
      
      public var sjlbBtn:SimpleButton;
      
      public var rzmc:MovieClip;
      
      private var yktBtn:SimpleButton;
      
      public function MapMenu()
      {
         trace("mapmenu");
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
         gc.startSaveTimer();
         gc.saveTimer.addEventListener("timer",__timer);
         if(gc.saveIntervelCount != 0)
         {
            savebtn.enabled = false;
            savebtn.mouseEnabled = false;
         }
      }
      
      private function added(e:Event) : void
      {
         var tae:TestAddEquipment = null;
         trace("mapmenu-added");
         this.removeEventListener("addedToStage",added);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         showBuySkill.addEventListener("click",buySkill);
         savebtn.addEventListener("click",saveGame);
         if(gc.isnew)
         {
            savebtn.dispatchEvent(new MouseEvent("click"));
         }
         ldl.addEventListener("click",ldlClick);
         gradenbtn.addEventListener("click",gradenClick);
         scgm.addEventListener("click",scgmClick);
         btnback.addEventListener("click",backtomenu);
         huodongbtn.addEventListener("click",huodongClick);
         rwbtn.addEventListener("click",rwbtnClick);
         bxghbtn.addEventListener("click",bxghClick);
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = uint(int(dayAry1[0]));
         var month1:uint = uint(int(dayAry1[1]) - 1);
         var day1:uint = uint(int(dayAry1[2]));
         var date1:Date = new Date(year1,month1,day1);
         sjlbBtn.addEventListener("click",sjlbClick);
         dzbtn.addEventListener("click",dianzanPresent);
         qrjbtn.visible = false;
         kaixuebtn.addEventListener("click",kaixueClick);
         ldbtn.addEventListener("click",qdlbbtnClick);
         ldbtn.visible = false;
         sjwBtn.addEventListener("click",sjwBtnClick);
         sjwBtn.visible = false;
         changeNameBtn.addEventListener("click",cnBtnClick);
         trace("------gc.dataObject.whichlastworld----",gc.dataObject.whichlastworld);
         if(gc.dataObject.whichlastworld == 2)
         {
            kaixuebtn.visible = false;
            bxghbtn.visible = false;
            changeNameBtn.visible = false;
            if(!backSecBtn)
            {
               backSecBtn = AUtils.getNewObj("backjiejiaobutton") as SimpleButton;
               backSecBtn.x = 703;
               backSecBtn.y = 8;
               backSecBtn.addEventListener("click",backSecBtnHandler);
               this.addChild(backSecBtn);
            }
            backSecBtn.visible = true;
         }
         else
         {
            kaixuebtn.visible = false;
            bxghbtn.visible = true;
            changeNameBtn.visible = true;
            if(backSecBtn)
            {
               backSecBtn.visible = false;
            }
         }
         qingmingbtn.visible = false;
         qznbtn.addEventListener("click",qznClick);
         qznbtn.gotoAndStop(2);
         qznbtn.buttonMode = true;
         qznbtn.useHandCursor = true;
         rzmc.addEventListener("click",rzClick);
         rzmc.gotoAndStop(2);
         rzmc.buttonMode = true;
         rzmc.useHandCursor = true;
         if(gc.dataObject.hasGetAuth4399Present)
         {
            rzmc.visible = false;
         }
         gc.eventManger.addEventListener("VIPDATAREADING",achieveVipData);
         gc.eventManger.addEventListener("ACHIEVEVIPDATAOVER",vipDataOver);
         gc.eventManger.addEventListener("OPEN_HUODONG_INTERFACE",openHuoDongInterface);
         if(gc.isHideDebug)
         {
            trace("gc.isfirstinselectplace --->>" + gc.isfirstinselectplace);
            gc.gameVip.setAllMoney(100000);
            this.vipDataOver(null);
         }
         else
         {
            if(gc.isfirstinselectplace)
            {
               gc.isfirstinselectplace = false;
            }
            gc.gameVip.setAllMoney(100000);
            this.vipDataOver(null);
         }
         trace("gc.isfirstLogin-->" + gc.isfirstLogin);
         if(gc.isfirstLogin)
         {
            DebugArea.getIns().traceOut("gc.dataObjectInstance.loginUid:" + gc.dataObjectInstance.loginUid);
            AllianceSprite.getInstance().getKey();
            gc.isfirstLogin = false;
         }
         if(gc.isBeatBeidou && gc.dataObject.beidouqixing < 1 && gc.dataObject.guoqingFB >= 1)
         {
            kaixuebtn.dispatchEvent(new MouseEvent("click"));
         }
         this.gift();
         if(gc.isTest)
         {
            if(!gc.stage.getChildByName("TestAddEquipment"))
            {
               tae = new TestAddEquipment();
               tae.name = "TestAddEquipment";
               gc.stage.addChild(tae);
            }
         }
      }
      
      public function hideSomeBtn() : void
      {
         this.qrjbtn.visible = false;
         this.kaixuebtn.visible = false;
         this.bxghbtn.visible = false;
         changeNameBtn.visible = false;
      }
      
      private function backSecBtnHandler(e:MouseEvent) : void
      {
         GMain.getInstance().switchSence("showNewStageMap");
      }
      
      private function yktClick(e:MouseEvent) : void
      {
         if(gc.player1.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
         {
            gc.ts.setTxt("玩家一背包已满!");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player2.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
         {
            gc.ts.setTxt("玩家二背包已满!");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
         }
         gc.dataObject.worldtransfromTimes += 5;
         gc.ts.setTxt("成功领取 龙女的眼泪X3 昆仑山世界传送X5");
         gc.stage.addChild(gc.ts);
         yktBtn.removeEventListener("click",yktClick);
         this.removeChild(yktBtn);
         gc.isGetYikatong = true;
      }
      
      private function gift() : void
      {
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         if(yktBtn)
         {
            yktBtn.removeEventListener("click",yktClick);
         }
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         renewalse = null;
         showBuySkill.removeEventListener("click",buySkill);
         savebtn.removeEventListener("click",saveGame);
         ldl.removeEventListener("click",ldlClick);
         gradenbtn.removeEventListener("click",gradenClick);
         scgm.removeEventListener("click",scgmClick);
         huodongbtn.removeEventListener("click",huodongClick);
         rwbtn.removeEventListener("click",rwbtnClick);
         btnback.removeEventListener("click",backtomenu);
         bxghbtn.removeEventListener("click",bxghClick);
         sjlbBtn.removeEventListener("click",sjlbClick);
         dzbtn.removeEventListener("click",dianzanPresent);
         ldbtn.removeEventListener("click",qdlbbtnClick);
         sjwBtn.removeEventListener("click",sjwBtnClick);
         changeNameBtn.removeEventListener("click",cnBtnClick);
         kaixuebtn.removeEventListener("click",kaixueClick);
         qznbtn.removeEventListener("click",qznClick);
         rzmc.removeEventListener("click",rzClick);
         gc.eventManger.removeEventListener("VIPDATAREADING",achieveVipData);
         gc.eventManger.removeEventListener("ACHIEVEVIPDATAOVER",vipDataOver);
         this.vipicon.removeEventListener("click",vipIcomClick);
         gc.eventManger.removeEventListener("OPEN_HUODONG_INTERFACE",openHuoDongInterface);
         gc.saveTimer.removeEventListener("timer",__timer);
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         gc.lastPaymentString = "MapMenu";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "MapMenu")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.lastPaymentString = "";
         this.intoQingMingFB();
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
      
      private function bxghClick(e:MouseEvent) : void
      {
         var eiia:EightImmortalsInterfaceAssets = new EightImmortalsInterfaceAssets();
         this.addChild(eiia);
      }
      
      private function qdlbbtnClick(e:MouseEvent) : void
      {
         gc.openUrl("https://huodong2.4399.com/2025/zmwsldgq/");
      }
      
      private function sjwBtnClick(e:MouseEvent) : void
      {
         gc.openUrl("https://huodong.4399.com/yyx/zmxy.html");
      }
      
      private function cnBtnClick(e:MouseEvent) : void
      {
         if(gc.dataObject.hasGetChangeNamePresent == true || gc.dataObject.hasGetChangeNamePresent == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs2",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs2",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         gc.dataObject.hasGetChangeNamePresent = true;
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔x1、孟婆药剂x1、火灵珠x1、2级强化石x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function sjlbClick(e:MouseEvent) : void
      {
         var raa:RegistrationActivityAssets = new RegistrationActivityAssets();
         this.addChild(raa);
      }
      
      private function qingmingClick(e:MouseEvent) : void
      {
         if(gc.dataObject.qingmingFB >= 1)
         {
            this.intoQingMingFB();
         }
         else
         {
            this.addRenewalseMask("今天挑战次数已经用完，您确定花300点券再进一次吗？");
         }
      }
      
      private function rzClick(e:MouseEvent) : void
      {
         var authMain:Auth4399MainView = new Auth4399MainView();
         this.addChild(authMain);
      }
      
      private function qznClick(e:MouseEvent) : void
      {
         var gcxdyy:MyEquipObj = null;
         var gcxdyy2:MyEquipObj = null;
         if(gc.dataObject.hasQiZhouNianActivity == true || gc.dataObject.hasQiZhouNianActivity == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("shsjt");
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gcxdyy2 = gc.allEquip.findByName("yxnmwsz");
            gcxdyy2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(gcxdyy2);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gcxdyy = gc.allEquip.findByName("shsjt");
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gcxdyy2 = gc.allEquip.findByName("yxnmwsz");
            gcxdyy2.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(gcxdyy2);
         }
         gc.dataObject.hasQiZhouNianActivity = true;
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         gc.ts.setTxt("成功领取 大灵魂药水x1、周年头衔x1、优秀牛魔王装x1、山河社稷图x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function intoQingMingFB() : void
      {
         gc.curStageAndCurLevel.curStage = 59;
         gc.curStageAndCurLevel.curLevel = 1;
         var _loc1_:* = gc.dataObject;
         var _loc2_:* = Number(_loc1_.qingmingFB) - 1;
         _loc1_.qingmingFB = _loc2_;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function kaixueClick(e:MouseEvent) : void
      {
         var ssia:SevenStarInteraceAssets = new SevenStarInteraceAssets();
         this.addChild(ssia);
      }
      
      private function signInClick(e:MouseEvent) : void
      {
         var raa:RegistrationActivityAssets = new RegistrationActivityAssets();
         this.addChild(raa);
      }
      
      private function qrjClick(e:MouseEvent) : void
      {
         var vdi:ValentinesInterfaceAssets = new ValentinesInterfaceAssets();
         this.addChild(vdi);
      }
      
      private function zqClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/forums/thread-59767218");
      }
      
      private function intoBxghFB() : void
      {
         gc.curStageAndCurLevel.curStage = 50;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function achieveVipData(e:CommonEvent) : void
      {
         vipDataOver(null);
      }
      
      private function vipDataOver(e:CommonEvent) : void
      {
         trace("gc.gameVip.getVipLevel():" + gc.gameVip.getVipLevel());
         this.vipicon.buttonMode = true;
         if(gc.gameVip.getVipLevel() >= 1)
         {
            this.vipicon.gotoAndStop(3);
         }
         else
         {
            this.vipicon.gotoAndStop(2);
         }
         if(!this.vipicon.hasEventListener("click"))
         {
            this.vipicon.addEventListener("click",vipIcomClick);
         }
      }
      
      private function vipIcomClick(e:MouseEvent) : void
      {
         trace("--vipIcomClick--");
         var gvia:GameVipInterfaceAssets = new GameVipInterfaceAssets();
         this.addChild(gvia);
      }
      
      private function buySkill(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("showBuySkill",{"state":"maping"}));
      }
      
      private function saveGame(e:MouseEvent) : void
      {
         doSaveGame();
      }
      
      private function doSaveGame() : void
      {
         if(GMain.serviceHold)
         {
            gc.logInfo = GMain.serviceHold.isLog;
            if(gc.isHideDebug)
            {
               if(gc.saveIntervelCount <= 0)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
         }
         else
         {
            gc.ts.setTxt("保存失败，请先登录!");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function ldlClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("showStrengthEquip",{"state":"maping"}));
      }
      
      private function gradenClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("showGradenInterface"));
      }
      
      private function scgmClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("showShoping"));
      }
      
      private function backtomenu(e:MouseEvent) : void
      {
         GMain.getInstance().switchSence("GameMenu");
         gc.initData();
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
      }
      
      private function huodongClick(e:MouseEvent) : void
      {
         var aia:ActivityInterfaceAssets = null;
         if(gc.isBlack)
         {
            gc.ts.setTxt("活动暂时关闭");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            aia = new ActivityInterfaceAssets();
            this.addChild(aia);
         }
      }
      
      private function openHuoDongInterface(e:CommonEvent) : void
      {
         this.huodongClick(null);
      }
      
      private function rwbtnClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("ShowTaskInterface"));
      }
      
      private function scoreClick(e:MouseEvent) : void
      {
         var es:ExchangeScore = null;
         var ei:ErrorInfo = null;
         if(gc.isComeFrom4399)
         {
            es = new ExchangeScore();
            this.addChild(es);
         }
         else
         {
            ei = new ErrorInfo();
            this.addChild(ei);
         }
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         if(gc.saveIntervelCount > 0)
         {
            saveInterval.text = "(" + String(gc.saveIntervelCount) + ")";
            savebtn.enabled = false;
            savebtn.mouseEnabled = false;
         }
         else
         {
            savebtn.enabled = true;
            savebtn.mouseEnabled = true;
            saveInterval.text = "";
         }
      }
      
      private function nyClick(e:MouseEvent) : void
      {
         var cnya:NewYear2014Assets = null;
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = uint(int(dayAry1[0]));
         var month1:uint = uint(int(dayAry1[1]) - 1);
         var day1:uint = uint(int(dayAry1[2]));
         var timeAry1:Array = gc.dataObjectInstance.curTime.split(":");
         var hours:uint = uint(int(timeAry1[0]));
         var date1:Date = new Date(year1,month1,day1,hours);
         if(date1.getTime() >= 1454774460000)
         {
            cnya = new NewYear2014Assets(String(day1));
            this.addChild(cnya);
         }
         else
         {
            gc.ts.setTxt("拜年活动除夕开启，敬请期待");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function judgeBCbtn() : Boolean
      {
         var i:* = 0;
         var tary:Array = gc.dataObject.newyear_2016_mark.split("-");
         if(tary.indexOf("over") != -1)
         {
            return false;
         }
         i = 7;
         while(i <= 14)
         {
            if(tary.indexOf(i + "") == -1)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      private function readPackClick(e:MouseEvent) : void
      {
         var str:String = null;
         str = null;
         var i:* = 0;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
            return;
         }
         var tary:Array = gc.dataObject.newyear_2016_mark.split("-");
         if(tary.indexOf("over") != -1)
         {
            gc.ts.setTxt("您已经领取过大红包补偿");
            gc.stage.addChild(gc.ts);
            return;
         }
         i = 7;
         while(i <= 14)
         {
            if(tary.indexOf(i + "") == -1)
            {
               gc.ts.setTxt("您春节没有点亮所有灯笼，无法领取大红包补偿");
               gc.stage.addChild(gc.ts);
               return;
            }
            i++;
         }
         gc.dataObject.newyear_2016_mark += "-over";
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getroomhorsePet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getroomhorsePet());
         }
         gc.ts.setTxt("大红包补偿领取成功,获得 炎马");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getroomhorsePet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("roomhorse1",1);
         pif.setperception(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.setwarpower(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.one));
         pif.settechnique(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.one));
         pif.sethpQuality((700 + Math.round(RandomControllor.getIns().getRandom() * 500)) * 1.3);
         pif.setmpQuality((550 + Math.round(RandomControllor.getIns().getRandom() * 440)) * 1.3);
         pif.setatkQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
         pif.setHp(700);
         pif.setMp(800);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getNianPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(3);
         pif.setwarpower(3);
         pif.settechnique(3);
         pif.sethpQuality(1500);
         pif.setmpQuality(200);
         pif.setatkQuality(1300);
         pif.setdefQuality(300);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function dianzanPresent(e:MouseEvent) : void
      {
         if(gc.dataObject.hasGetDZPresent == false || gc.dataObject.hasGetDZPresent == "false")
         {
            gc.dataObject.hasGetDZPresent = true;
            if(gc.player1.roleid > 0)
            {
               gc.player1.petsAry.push(this.getNianPet());
               gc.player1.plist.push(gc.allEquip.findByName("p_cynsjl"));
               gc.putQhsInBackPack(gc.player1,"nianjhd",1);
               gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            }
            if(gc.player2.roleid > 0)
            {
               gc.player2.petsAry.push(this.getNianPet());
               gc.player2.plist.push(gc.allEquip.findByName("p_cynsjl"));
               gc.putQhsInBackPack(gc.player2,"nianjhd",1);
               gc.putQhsInBackPack(gc.player2,"wpcsd",1);
            }
            gc.ts.setTxt("成功领取 年兽宝宝x1、年兽进化丹x1、年兽精灵x1、长生丹x1");
            gc.stage.addChild(gc.ts);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("该存档已经领取过");
            gc.stage.addChild(gc.ts);
         }
      }
   }
}
