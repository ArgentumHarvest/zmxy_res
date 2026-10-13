package my
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SaveResult extends Sprite
   {
      
      public static var SAVE_OK:uint = 0;
      
      public static var SAVE_NO:uint = 1;
       
      
      private var type:uint;
      
      private var count:uint = 0;
      
      public function SaveResult(type:uint)
      {
         var bm:* = null;
         super();
         this.type = type;
         if(this.type == SAVE_OK)
         {
            bm = AUtils.getImageObj("SaveOK") as Bitmap;
         }
         else
         {
            bm = AUtils.getImageObj("SaveNO") as Bitmap;
         }
         bm.x = -bm.width / 2;
         this.addChild(bm);
         this.addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(evt:Event) : void
      {
         this.count++;
         if(this.count > 48)
         {
            this.alpha--;
            if(this.alpha < 0.1)
            {
               this.destroy();
            }
         }
      }
      
      private function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.removeEventListener("enterFrame",__enterFrame);
      }
   }
}
