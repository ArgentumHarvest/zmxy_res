package export.huodong.worldtransfrom
{
   import AssetsClass.WorldTransfromAssets;
   import base.BaseIconInKunLun;
   import event.CommonEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   
   public class TransfromInterface extends BaseIconInKunLun
   {
       
      
      public var txt:TextField;
      
      public function TransfromInterface()
      {
         super();
         this.myName = "TransfromInterface";
         this._anti.needtopay = 100;
      }
      
      override protected function onClick(e:MouseEvent) : void
      {
         if(gc.dataObject.worldtransfromTimes >= 1)
         {
            this.doFunction();
            this.setTxt();
         }
         else
         {
            this.addRenewalseMask("您的免费次数已用完，您确定要花费" + this._anti.needtopay + "点券使用世界传送?");
         }
      }
      
      override protected function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != this.myName)
         {
            return;
         }
         super.paymentSuccess(e);
         gc.dataObject.worldtransfromTimes++;
         this.setTxt();
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10750,
            "ename":"custom"
         },1,1],[{
            "id":10750,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      override protected function doFunction() : void
      {
         var wta:WorldTransfromAssets = new WorldTransfromAssets();
         if(gc.gameInfo)
         {
            gc.gameInfo.addChild(wta);
         }
      }
      
      override protected function setTxt() : void
      {
         this.txt.text = gc.dataObject.worldtransfromTimes + "";
      }
   }
}
