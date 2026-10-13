package export
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class Infomation extends Sprite
   {
       
      
      private var txtformat:TextFormat;
      
      private var txtname:TextField;
      
      private var timer:Timer;
      
      private var continueTime:Number = 3;
      
      public function Infomation()
      {
         txtformat = new TextFormat();
         txtname = new TextField();
         timer = new Timer(1000);
         super();
         txtname.selectable = false;
         txtformat.color = "0x000000";
         txtformat.bold = true;
         txtformat.size = 28;
         txtformat.align = "center";
         txtname.filters = [this.GlowEffect()];
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         timer.addEventListener("timer",__timer);
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         if(timer.currentCount == this.continueTime + 3)
         {
            this.remove();
            this.timer.stop();
            this.timer.reset();
         }
         else if(timer.currentCount == this.continueTime)
         {
            TweenMax.to(this,2.5,{
               "y":170,
               "alpha":0
            });
         }
      }
      
      private function added(e:Event) : void
      {
         this.x = 0;
         this.y = 270;
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function setTxt(str:String, time:int = 2, fontSize:int = 28) : void
      {
         this.continueTime = time;
         txtname.text = str;
         txtformat.size = fontSize;
         txtname.setTextFormat(txtformat);
         this.alpha = 1;
         this.y = 270;
         this.timer.stop();
         this.timer.reset();
         this.timer.start();
         TweenLite.killTweensOf(this);
         if(!this.contains(this.txtname))
         {
            this.txtname.height = 40;
            this.txtname.width = 940;
            this.addChild(this.txtname);
         }
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
         return new GlowFilter(16777215,1,2,2,5.3,3,false,false);
      }
   }
}
