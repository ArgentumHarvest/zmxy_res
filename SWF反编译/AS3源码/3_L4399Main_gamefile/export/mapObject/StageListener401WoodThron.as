package export.mapObject
{
   import base.BaseAddEffect;
   import base.BaseHero;
   import flash.geom.Point;
   import my.HitTest;
   
   public class StageListener401WoodThron extends WoodThron
   {
       
      
      public function StageListener401WoodThron()
      {
         super();
      }
      
      override public function step() : void
      {
         var obj:* = null;
         if(this.intervalCount == 0)
         {
            this.newAttackId();
            this.intervalCount = gc.frameClips * 2;
         }
         if(this.intervalCount >= 0)
         {
            this.intervalCount--;
         }
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.beAttackIdArray.indexOf(this.getAttackId()) == -1)
            {
               if(!bh.isYourFather())
               {
                  if(HitTest.complexHitTestObject(this,bh.colipse))
                  {
                     bh.reduceHp(2000,true);
                     if(bh.curAddEffect)
                     {
                        obj = bh.curAddEffect.getBuffByName(BaseAddEffect.MONSTER114FEAR);
                        if(obj)
                        {
                           obj.time = 1;
                        }
                     }
                     if(bh.getBBDC().getDirect() == 0)
                     {
                        bh.setAttackBack(new Point(10,0));
                     }
                     else
                     {
                        bh.setAttackBack(new Point(-10,0));
                     }
                     bh.beAttackIdArray.push(this.getAttackId());
                     bh.beAttackDoing();
                  }
               }
            }
         }
      }
   }
}
