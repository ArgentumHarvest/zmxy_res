package export.huodong.newyear
{
   import base.BaseIconInKunLun;
   import event.CommonEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class NewYearLantern extends BaseIconInKunLun
   {
       
      
      public var txt:TextField;
      
      public function NewYearLantern()
      {
         super();
         this.myName = "NewYearLantern";
      }
      
      override protected function onClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("stagelistener481denglongappear"));
      }
      
      override protected function paymentSuccess(e:CommonEvent) : void
      {
      }
      
      override protected function doFunction() : void
      {
         super.doFunction();
      }
      
      override protected function setTxt() : void
      {
         super.setTxt();
         this.txt.text = gc.getNewYearThreeTreasure("dl") + "";
      }
   }
}
