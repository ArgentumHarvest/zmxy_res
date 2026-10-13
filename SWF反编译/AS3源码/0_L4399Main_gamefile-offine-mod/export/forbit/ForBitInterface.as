package export.forbit
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ForBitInterface extends Sprite
   {
       
      
      private var gc:Config;
      
      private var iscanappeal:Boolean;
      
      public var appealBtn:SimpleButton;
      
      public var changleBtn:SimpleButton;
      
      public var txt:TextField;
      
      public function ForBitInterface(status:uint)
      {
         super();
         gc = Config.getInstance();
         if(status == 1)
         {
            iscanappeal = true;
         }
         else
         {
            iscanappeal = false;
         }
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         appealBtn.visible = true;
         if(iscanappeal)
         {
            this.txt.text = "您的该存档由于修改已经被暂时封存";
            appealBtn.addEventListener("click",appealClick);
         }
         else
         {
            this.txt.text = "您的该存档由于修改次数过多，已经被永久封存";
            appealBtn.removeEventListener("click",appealClick);
            appealBtn.visible = false;
         }
         changleBtn.addEventListener("click",changleClick);
      }
      
      private function removed(e:Event) : void
      {
         appealBtn.removeEventListener("click",appealClick);
         changleBtn.removeEventListener("click",changleClick);
      }
      
      private function appealClick(e:MouseEvent) : void
      {
         trace("申诉");
         gc.openUrl("https://app.my.4399.com/r.php?app=feedback");
         if(gc.stage.getChildByName("ReadingWareHouseMask"))
         {
            gc.stage.removeChild(gc.stage.getChildByName("ReadingWareHouseMask"));
         }
         if(gc.stage.getChildByName("ReadSaveDataMask"))
         {
            gc.stage.removeChild(gc.stage.getChildByName("ReadSaveDataMask"));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function changleClick(e:MouseEvent) : void
      {
         if(gc.stage.getChildByName("ReadingWareHouseMask"))
         {
            gc.stage.removeChild(gc.stage.getChildByName("ReadingWareHouseMask"));
         }
         if(gc.stage.getChildByName("ReadSaveDataMask"))
         {
            gc.stage.removeChild(gc.stage.getChildByName("ReadSaveDataMask"));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
