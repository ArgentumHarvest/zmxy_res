package export.anewworldhascome
{
   import AssetsClass.BackToThePastAssets;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.FinancialInfo;
   
   public class ANewWorldDoor extends Sprite
   {
       
      
      private var gc:Config;
      
      public var dupbtn:SimpleButton;
      
      public var worbtn:SimpleButton;
      
      public var xbtn:SimpleButton;
      
      public var pastbtn:SimpleButton;
      
      public var rebtn1:SimpleButton;
      
      public var rebtn2:SimpleButton;
      
      public var csmc:MovieClip;
      
      private var renewalse:RenewalseThisSZ;
      
      private var curHuiHu:String = "";
      
      public function ANewWorldDoor()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         dupbtn.addEventListener("click",intoDefendDuplicate);
         worbtn.addEventListener("click",intoNewWorld);
         pastbtn.addEventListener("click",pastClick);
         xbtn.addEventListener("click",xClick);
         if(gc.player1.roleid > 0)
         {
            rebtn1.addEventListener("click",costClick);
         }
         else
         {
            rebtn1.visible = false;
         }
         if(gc.player2.roleid > 0)
         {
            rebtn2.addEventListener("click",costClick);
         }
         else
         {
            rebtn2.visible = false;
         }
         if(gc.dataObject.whichlastworld == 0)
         {
            csmc.gotoAndStop(1);
         }
         else
         {
            csmc.gotoAndStop(2);
         }
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function removed(e:Event) : void
      {
         dupbtn.removeEventListener("click",intoDefendDuplicate);
         worbtn.removeEventListener("click",intoNewWorld);
         pastbtn.addEventListener("click",pastClick);
         xbtn.removeEventListener("click",xClick);
         rebtn1.removeEventListener("click",costClick);
         rebtn2.removeEventListener("click",costClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function pastClick(e:MouseEvent) : void
      {
         var bttp:BackToThePastAssets = new BackToThePastAssets();
         if(this.parent)
         {
            if(this.parent.parent)
            {
               this.parent.parent.addChild(bttp);
            }
            this.parent.removeChild(this);
         }
      }
      
      private function intoDefendDuplicate(e:MouseEvent) : void
      {
         if(gc.isHideDebug)
         {
            if(gc.playNum == 2)
            {
               if(gc.player1.getCurLevel() < 50 || gc.player2.getCurLevel() < 50)
               {
                  gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
                  gc.stage.addChild(gc.ts);
                  return;
               }
            }
            else if(gc.player1.getCurLevel() < 50)
            {
               gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         gc.curStageAndCurLevel.curStage = 16;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         this.destory();
      }
      
      private function intoNewWorld(e:MouseEvent) : void
      {
         if(gc.isHideDebug)
         {
            if(gc.dataObject.whichlastworld == 0)
            {
               if(gc.player1.getSomeOneEquipNumberByName("ttlp") < 1)
               {
                  gc.ts.setTxt("需要通天令牌");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               if(gc.playNum == 2)
               {
                  if(gc.player1.getCurLevel() < 50 || gc.player2.getCurLevel() < 50)
                  {
                     gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
                     gc.stage.addChild(gc.ts);
                     return;
                  }
               }
               else if(gc.player1.getCurLevel() < 50)
               {
                  gc.ts.setTxt("玩家的等级必须都大于50级才可以进入");
                  gc.stage.addChild(gc.ts);
                  return;
               }
            }
         }
         if(gc.dataObject.whichlastworld == 0)
         {
            GMain.getInstance().switchSence("showNewStageMap");
         }
         else
         {
            GMain.getInstance().switchSence("showStageMap");
         }
         this.destory();
      }
      
      private function costClick(e:MouseEvent) : void
      {
         this.curHuiHu = e.currentTarget.name;
         if(this.curHuiHu == "rebtn1")
         {
            if(gc.player1.getSomeWeaponInPackBackByName("psdclj") != null)
            {
               this.addRenewalseMask("您确定要花费300点券复原1P玩家的苍龙戒?");
            }
            else
            {
               gc.ts.setTxt("玩家1没有需要复原的苍龙戒");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(this.curHuiHu == "rebtn2")
         {
            if(gc.player2.getSomeWeaponInPackBackByName("psdclj") != null)
            {
               this.addRenewalseMask("您确定要花费300点券复原2P玩家的苍龙戒?");
            }
            else
            {
               gc.ts.setTxt("玩家2没有需要复原的苍龙戒");
               gc.stage.addChild(gc.ts);
            }
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
         gc.lastPaymentString = "ANewWorldDoor";
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
         if(gc.lastPaymentString != "ANewWorldDoor")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10420,
            "ename":"custom"
         },1,1],[{
            "id":10420,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         gc.gameVip.dataObject.lastMoney = e.data[0];
         if(this.curHuiHu == "rebtn1")
         {
            gc.player1.doWhenCljReduction();
         }
         else if(this.curHuiHu == "rebtn2")
         {
            gc.player2.doWhenCljReduction();
         }
         gc.ts.setTxt("修复成功");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
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
         this.destory();
      }
      
      private function destory() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
