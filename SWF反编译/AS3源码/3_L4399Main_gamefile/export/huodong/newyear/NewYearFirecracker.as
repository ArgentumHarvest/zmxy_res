package export.huodong.newyear
{
   import base.BaseIconInKunLun;
   import event.CommonEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   
   public class NewYearFirecracker extends BaseIconInKunLun
   {
       
      
      public var txt:TextField;
      
      public function NewYearFirecracker()
      {
         super();
         this.myName = "NewYearFirecracker";
      }
      
      override protected function onClick(e:MouseEvent) : void
      {
         if(gc.dataObject.snowBossTimes >= 100)
         {
            gc.ts.setTxt("年兽灵珠经验已满");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.getNewYearThreeTreasure("bz") >= 1)
         {
            this.doFunction();
            gc.setNewYearThreeTreasure("bz",-1);
            this.setTxt();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            this.addRenewalseMask("您的免费次数已用完，您确定要花费" + this._anti.needtopay + "点券使用爆竹，来增加年兽灵珠经验?");
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
            "id":10730,
            "ename":"custom"
         },1,1],[{
            "id":10730,
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
         this.txt.text = gc.getNewYearThreeTreasure("bz") + "";
      }
   }
}
