package export
{
   import com.greensock.*;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   
   public class Infomation extends Sprite
   {
       
      
      private var txtformat:TextFormat;
      
      private var txtname:TextField;
      
      public function Infomation()
      {
         this.txtformat = new TextFormat();
         this.txtname = new TextField();
         super();
         this.txtname.selectable = false;
         this.txtformat.color = "0x000000";
         this.txtformat.size = 32;
         this.txtformat.align = TextFormatAlign.CENTER;
         this.txtname.filters = [this.GlowEffect()];
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         this.x = 0;
         this.y = 270;
      }
      
      private function removed(param1:Event) : void
      {
      }
      
      public function setTxt(param1:String) : void
      {
         var _loc2_:int = 170;
         if(param1 == "存档成功" || param1 == "存档失败")
         {
            _loc2_ = 240;
         }
         this.txtname.text = param1;
         this.txtname.setTextFormat(this.txtformat);
         this.alpha = 1;
         TweenMax.killChildTweensOf(this);
         TweenMax.to(this,1.5,{
            "y":_loc2_,
            "onComplete":this.wait
         });
         this.y = 270;
         if(!this.contains(this.txtname))
         {
            this.txtname.height = 40;
            this.txtname.width = 940;
            this.addChild(this.txtname);
         }
      }
      
      private function wait() : void
      {
         TweenMax.killChildTweensOf(this);
         TweenMax.to(this,0.5,{"onComplete":this.disappear});
      }
      
      private function disappear() : void
      {
         TweenMax.killChildTweensOf(this);
         TweenMax.to(this,0.5,{
            "alpha":0,
            "onComplete":this.remove
         });
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.alpha = 1;
            this.y = 270;
            this.parent.removeChild(this);
         }
      }
      
      private function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,2,2,5.3,BitmapFilterQuality.HIGH,false,false);
      }
   }
}
