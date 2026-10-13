package export.level.Stagelistener511Children
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Sprite;
   
   public class StageListener511Qiqiu extends Sprite
   {
       
      
      public var isDestroy:Boolean = false;
      
      private var isBeGeted:Boolean = false;
      
      public function StageListener511Qiqiu()
      {
         super();
         this.addChild(AUtils.getNewObj("Stage511Qiqiu"));
      }
      
      public function step() : void
      {
         if(!isDestroy && !isBeGeted)
         {
            this.y -= 3;
            if(this.y < 0)
            {
               this.destroy();
            }
            this.checkCollision();
         }
      }
      
      private function checkCollision() : void
      {
         for each(var bh in Config.getInstance().getPlayerArray())
         {
            if(bh.colipse.hitTestObject(this))
            {
               this.beGeted();
               break;
            }
         }
      }
      
      private function beGeted() : void
      {
         Config.getInstance().dataObject.whiteQiqiu++;
         this.isBeGeted = true;
         TweenMax.to(this,1,{"alpha":0});
         Config.getInstance().ts.setTxt("获得气球X1");
         Config.getInstance().stage.addChild(Config.getInstance().ts);
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         TweenMax.killChildTweensOf(this);
         this.isDestroy = true;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
   }
}
