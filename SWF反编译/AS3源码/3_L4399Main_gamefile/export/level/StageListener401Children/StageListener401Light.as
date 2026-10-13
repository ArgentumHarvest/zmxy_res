package export.level.StageListener401Children
{
   import base.BaseBullet;
   import base.BaseHero;
   import flash.events.Event;
   import my.HitTest;
   import my.LightForBlackBG;
   
   public class StageListener401Light extends LightForBlackBG
   {
       
      
      public function StageListener401Light()
      {
         super();
         this.raidus = 500;
         this.gotoAndStop(1);
      }
      
      override public function step() : void
      {
         if(this.state == 0)
         {
            for each(var bh in gc.getPlayerArray())
            {
               for each(var bb in bh.magicBulletArray)
               {
                  if(!bb.isDisabled)
                  {
                     if(HitTest.complexHitTestObject(bb,this))
                     {
                        this.dispatchEvent(new Event("hurt"));
                        this.light(8);
                        this.gotoAndStop(2);
                        break;
                     }
                  }
               }
            }
         }
      }
      
      override public function dark() : void
      {
         this.gotoAndStop(1);
         super.dark();
      }
   }
}
