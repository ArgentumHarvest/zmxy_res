package export.level.StageListener461Children
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import my.HitTest;
   
   public class StageListener461Guihua extends Sprite
   {
       
      
      private var gc:Config;
      
      private var state:uint = 0;
      
      public var isDestroy:Boolean = false;
      
      public function StageListener461Guihua()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",__added,false,0,true);
      }
      
      private function __added(evt:Event) : void
      {
         this.addChild(AUtils.getImageObj("sl461Guihua"));
      }
      
      public function step() : void
      {
         this.y += 5;
         if(state == 0)
         {
            for each(var bh in gc.getPlayerArray())
            {
               if(HitTest.complexHitTestObject(this,bh))
               {
                  gc.dataObject.guiHuaNumber += 1;
                  this.destroy();
                  this.state = 1;
                  break;
               }
            }
         }
         if(this.y >= 600)
         {
            this.destroy();
         }
      }
      
      public function destroy() : void
      {
         this.isDestroy = true;
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":function(_self:StageListener461Guihua):*
            {
               if(_self.parent)
               {
                  _self.parent.removeChild(_self);
               }
            },
            "onCompleteParams":[this]
         });
      }
   }
}
