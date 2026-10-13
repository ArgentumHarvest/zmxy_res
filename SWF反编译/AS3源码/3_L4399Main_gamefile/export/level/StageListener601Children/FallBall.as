package export.level.StageListener601Children
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class FallBall extends Sprite
   {
      
      public static const DESTROY:String = "destroy";
       
      
      public var speed:Point;
      
      public function FallBall()
      {
         speed = new Point();
         super();
         var bg:Bitmap = AUtils.getImageObj("MagicFootballBmd");
         this.addChild(bg);
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.dispatchEvent(new Event("destroy"));
      }
   }
}
