package export.eightimmortals
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.PayManager;
   import my.FinancialInfo;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class EightImmortals extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var bossmc:MovieClip;
      
      public var intobtn:SimpleButton;
      
      public var mc_yyzlj:MovieClip;
      
      public var mc_ywhl:MovieClip;
      
      public var mc_zhyx:MovieClip;
      
      public var mc_bjs:MovieClip;
      
      public var mc_sxyg:MovieClip;
      
      public var mc_dkhl:MovieClip;
      
      public var mc_yyb:MovieClip;
      
      public var mc_hehua:MovieClip;
      
      public var hcmc:MovieClip;
      
      private var renewalse:RenewalseThisSZ;
      
      public function EightImmortals()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         var j:* = 0;
         var len:* = 0;
         var i:* = 0;
         var equip:* = null;
         this.removeEventListener("addedToStage",added);
         if(gc.dataObject.bbbbTimes <= 0)
         {
            if(!gc.hasGetMoney)
            {
               if(GMain.serviceHold)
               {
                  GMain.serviceHold.getBalance();
               }
            }
         }
         var label:String = gc.baxianMonsterId.toString();
         for(j = uint(1),len = uint(bossmc.totalFrames); j <= len; )
         {
            bossmc.gotoAndStop(j);
            if(bossmc.currentLabel == label)
            {
               break;
            }
            j++;
         }
         xbtn.addEventListener("click",xClick);
         intobtn.addEventListener("click",intoClick);
         var fbAry:Array = ["yyzlj","ywhl","zhyx","bjs","sxyg","dkhl","yyb","hehua"];
         var flen:uint = fbAry.length;
         var _bool:Boolean = true;
         for(i = uint(0); i < flen; )
         {
            equip = gc.player1.getSomeEquipInPackBackByName(fbAry[i]);
            if(equip)
            {
               if(this["mc_" + fbAry[i]])
               {
                  this["mc_" + fbAry[i]].gotoAndStop(2);
               }
            }
            else
            {
               _bool = false;
            }
            i++;
         }
         hcmc.useHandCursor = true;
         if(_bool)
         {
            hcmc.gotoAndStop(1);
         }
         else
         {
            hcmc.gotoAndStop(2);
         }
         hcmc.addEventListener("click",hcHandler);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         hcmc.removeEventListener("click",hcHandler);
         xbtn.removeEventListener("click",xClick);
         intobtn.addEventListener("click",intoClick);
         renewalse = null;
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
      }
      
      private function hcHandler(e:MouseEvent) : void
      {
         var _sei:* = null;
         if(this.parent)
         {
            _sei = new SutraEightImmortal();
            _sei.addEventListener("removedFromStage",sRemove);
            this.parent.addChild(_sei);
            this.visible = false;
         }
      }
      
      private function sRemove(e:Event) : void
      {
         e.currentTarget.removeEventListener("removedFromStage",sRemove);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function intoClick(e:MouseEvent) : void
      {
         if(gc.dataObject.bbbbTimes >= 1)
         {
            gc.dataObject.bbbbTimes--;
            this.intoBxghFB();
         }
         else
         {
            this.addRenewalseMask("您确定花100点券再进一次吗？");
         }
      }
      
      private function intoBxghFB() : void
      {
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.curStageAndCurLevel.curStage = 50;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
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
         var enough:Boolean = true;
         if(gc.gameVip.dataObject.lastMoney < 100)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = 100;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(11,"道具11",gc.pay.money,1);
               gc.lastPaymentString = "EightImmortals";
               gc.addActionMask("renewalse");
            }
         }
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
         if(gc.lastPaymentString != "EightImmortals")
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
         this.intoBxghFB();
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":11140,
            "ename":"custom"
         },1,1],[{
            "id":11140,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
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
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
