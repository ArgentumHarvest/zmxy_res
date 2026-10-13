package export.anewworldhascome.thepast
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   
   public class BackToThePast extends Sprite
   {
       
      
      public var throughbtn:SimpleButton;
      
      public var xbtn:SimpleButton;
      
      public var nmwmc:MovieClip;
      
      public var zlwmc:MovieClip;
      
      public var qlmc:MovieClip;
      
      public var atbtn:SimpleButton;
      
      public var timetxt:TextField;
      
      public var saytxt:TextField;
      
      private var renewalse:RenewalseThisSZ;
      
      private var gc:Config;
      
      private var tid:String = "";
      
      public function BackToThePast()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         nmwmc.buttonMode = true;
         zlwmc.buttonMode = true;
         qlmc.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         throughbtn.addEventListener("click",throughClick);
         xbtn.addEventListener("click",xClick);
         nmwmc.addEventListener("click",mcClick);
         zlwmc.addEventListener("click",mcClick);
         qlmc.addEventListener("click",mcClick);
         atbtn.addEventListener("click",costClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         throughbtn.removeEventListener("click",throughClick);
         xbtn.removeEventListener("click",xClick);
         nmwmc.removeEventListener("click",mcClick);
         zlwmc.removeEventListener("click",mcClick);
         qlmc.removeEventListener("click",mcClick);
         atbtn.removeEventListener("click",costClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function setTxt() : void
      {
         this.timetxt.text = gc.dataObject.throughPastTimes + "";
         this.saytxt.text = this.findIntroduceByTid(this.tid);
      }
      
      private function costClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定要花费100点券增加一次?");
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
         gc.lastPaymentString = "BackToThePast";
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
         if(gc.lastPaymentString != "BackToThePast")
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
         gc.dataObject.throughPastTimes++;
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10430,
            "ename":"custom"
         },1,1,gc.dataObject.throughPastTimes],[{
            "id":10430,
            "ename":"custom"
         },0,1,gc.dataObject.throughPastTimes]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         this.setTxt();
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
      
      private function mcClick(e:MouseEvent) : void
      {
         nmwmc.gotoAndStop(1);
         zlwmc.gotoAndStop(1);
         qlmc.gotoAndStop(1);
         tid = e.currentTarget.name;
         e.currentTarget.gotoAndStop(2);
         this.setTxt();
      }
      
      private function throughClick(e:MouseEvent) : void
      {
         if(tid == "")
         {
            return;
         }
         if(gc.dataObject.throughPastTimes > 0)
         {
            if(tid == "nmwmc")
            {
               gc.dataObject.throughPastTimes--;
               gc.curStageAndCurLevel.curStage = 17;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else if(tid == "zlwmc")
            {
               gc.dataObject.throughPastTimes--;
               gc.curStageAndCurLevel.curStage = 17;
               gc.curStageAndCurLevel.curLevel = 2;
            }
            else if(tid == "qlmc")
            {
               gc.dataObject.throughPastTimes--;
               gc.curStageAndCurLevel.curStage = 17;
               gc.curStageAndCurLevel.curLevel = 3;
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("您的回到过去次数已经用完");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function findIntroduceByTid(tname:String) : String
      {
         if(tid == "nmwmc")
         {
            return "通过混沌之门穿越回到造一时代的牛魔谷，夺取牛魔王的通天令牌。与此同时被黑白无常救下的牛魔王也穿越回造一时代，以第四形态出现。牛魔王第三形态掉落通天令牌碎片一，牛魔王第四形态掉落邪灵法宝牛魔王的怒吼。";
         }
         if(tid == "zlwmc")
         {
            return "通过混沌之门穿越回到造二时代的转轮殿，夺取转轮王的通天令牌。与此同时六道轮回后的转轮王也穿越回造二时代，以第四形态出现。转轮王第三形态掉落通天令牌碎片二，转轮王第四形态掉落邪灵法宝转轮王的哀嚎";
         }
         if(tid == "qlmc")
         {
            return "通过混沌之门穿越回到饕餮刚吞噬青龙时候的青龙之森。击败饕餮，拯救神兽青龙。倘若遇到二郎神一定要让他交出暗藏在山河社稷图中的通天令牌碎片三";
         }
         return "搜遍了整个天庭，都找不到玉帝。唯一的可能就是玉帝被人挟持，通过混沌之门传送到另一个世界里了。而要进入那个世界必须拥有通天令牌。而通天令牌在历代造梦BOSS手中";
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
