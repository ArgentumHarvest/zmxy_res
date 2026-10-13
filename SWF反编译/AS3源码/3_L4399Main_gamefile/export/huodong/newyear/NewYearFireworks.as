package export.huodong.newyear
{
   import base.BaseIconInKunLun;
   import event.CommonEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   
   public class NewYearFireworks extends BaseIconInKunLun
   {
       
      
      public var txt:TextField;
      
      public function NewYearFireworks()
      {
         super();
         this.myName = "NewYearFireworks";
         this._anti.needtopay = 15;
      }
      
      override protected function onClick(e:MouseEvent) : void
      {
         if(gc.dataObject.snowBossTimes >= 100)
         {
            gc.ts.setTxt("年兽灵珠经验已满");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.getNewYearThreeTreasure("yh") >= 1)
         {
            this.doFunction();
            gc.setNewYearThreeTreasure("yh",-1);
            this.setTxt();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            this.addRenewalseMask("您的免费次数已用完，您确定要花费" + this._anti.needtopay + "点券使用烟花，来增加年兽灵珠经验?");
         }
      }
      
      override protected function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != this.myName)
         {
            return;
         }
         super.paymentSuccess(e);
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10740,
            "ename":"custom"
         },1,1],[{
            "id":10740,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      override protected function doFunction() : void
      {
         super.doFunction();
      }
      
      override protected function setTxt() : void
      {
         this.txt.text = gc.getNewYearThreeTreasure("yh") + "";
      }
   }
}
