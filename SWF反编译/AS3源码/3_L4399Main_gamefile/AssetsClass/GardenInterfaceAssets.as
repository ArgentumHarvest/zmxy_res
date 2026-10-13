package AssetsClass
{
   import event.CommonEvent;
   import export.garden.GardenInterface;
   
   public class GardenInterfaceAssets extends BaseAssets
   {
       
      
      public function GardenInterfaceAssets()
      {
         super(GardenInterface);
         this.loadAssets(["GardenInterfacev3500.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
      }
   }
}
