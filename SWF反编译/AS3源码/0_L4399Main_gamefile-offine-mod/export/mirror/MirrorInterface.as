package export.mirror
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   
   public class MirrorInterface extends Sprite
   {
       
      
      public var txt:TextField;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function MirrorInterface()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.buttonMode = true;
         this._anti.needtopay = 100;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.addEventListener("click",onClick);
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("click",onClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         renewalse = null;
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(gc.allTask && gc.allTask.hasAnyRewardTask())
         {
            if(gc.dataObject.zhaoyaojingTimes >= 1)
            {
               this.showBossPosition();
               gc.dataObject.zhaoyaojingTimes--;
               this.setTxt();
               gc.isUseZhaoyaojing = true;
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券使用照妖镜,找出通缉Boss下落?");
            }
         }
         else
         {
            gc.ts.setTxt("请检查是否已经接受或已经完成了通缉任务");
            gc.stage.addChild(gc.ts);
         }
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
         gc.lastPaymentString = "MirrorInterface";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "MirrorInterface")
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
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10710,
            "ename":"custom"
         },1,1],[{
            "id":10710,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         this.showBossPosition();
         gc.isUseZhaoyaojing = true;
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
      
      private function showBossPosition() : void
      {
         var sbpi:ShowBossPositionInterface = new ShowBossPositionInterface();
         if(gc.gameInfo)
         {
            gc.gameInfo.addChild(sbpi);
         }
      }
      
      private function setTxt() : void
      {
         this.txt.text = gc.dataObject.zhaoyaojingTimes + "";
      }
   }
}
