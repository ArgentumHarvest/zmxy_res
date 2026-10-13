package AssetsClass
{
   import export.huodong.mysterious.DragonMysteriousShop;
   import flash.events.Event;
   
   public class DragonMysteriousShopAssets extends BaseAssets
   {
       
      
      public function DragonMysteriousShopAssets()
      {
         super(DragonMysteriousShop);
         this.loadAssets(["DragonMysteriousShopv890.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         this.content.addEventListener("close",__close);
      }
      
      protected function __close(event:Event) : void
      {
         this.dispatchEvent(new Event("close"));
      }
      
      override public function destroy() : void
      {
         this.content.removeEventListener("close",__close);
         super.destroy();
      }
   }
}
