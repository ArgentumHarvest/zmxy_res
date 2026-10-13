package AssetsClass
{
   import event.CommonEvent;
   import export.microshop.Micropayment;
   
   public class MicropaymentInterfaceAssets extends BaseAssets
   {
       
      
      public function MicropaymentInterfaceAssets()
      {
         super(Micropayment);
         this.loadAssets(["MicropaymentInterfacev1420.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
      }
   }
}
