package export
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Infomation extends Sprite
   {
       
      
      private var txtformat:TextFormat;
      
      private var txtname:TextField;
      
      public function Infomation()
      {
         this.txtformat = new TextFormat();
         this.txtname = new TextField();
         super();
         this.txtname.embedFonts = true;
         this.txtformat.font = "FZCuYuan-M03S";
         this.txtformat.color = "0x000000";
         this.txtformat.size = 32;
         this.txtname.filters = [this.GlowEffect()];
         this.txtname.x = 380;
         this.txtname.y = 270;
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         TweenMax.to(this,2.5,{
            "y":this.y - 100,
            "alpha":0,
            "onComplete":this.remove
         });
      }
      
      private function removed(param1:Event) : void
      {
      }
      
      public function setTxt(param1:String, param2:Point = null) : void
      {
         if(param2)
         {
            this.txtname.x = param2.x;
            this.txtname.y = param2.y;
         }
         this.txtname.text = param1;
         this.txtname.setTextFormat(this.txtformat);
         this.txtname.height = 40;
         this.txtname.width = this.txtname.textWidth + 10;
         this.addChild(this.txtname);
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.alpha = 1;
            this.y += 100;
            this.parent.removeChild(this);
         }
      }
      
      private function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,2,2,5.3,BitmapFilterQuality.HIGH,false,false);
      }
   }
}
