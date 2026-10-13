package export.magicWeapon
{
   import base.BaseBullet;
   import base.BaseHero;
   import export.bullet.EnemyMoveBullet;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class MagicFootballInStage60 extends MagicFootball
   {
      
      public static const SCORE:String = "score";
      
      public static const DESTROY:String = "destroy";
       
      
      private var isScore:Boolean = false;
      
      public function MagicFootballInStage60(bo:BaseHero)
      {
         super(bo);
         this.mp = 0;
      }
      
      override public function showSkill() : void
      {
         this.isScore = false;
         this.b = new EnemyMoveBullet("Football1");
         if(this.sourceRole.getBBDC().getDirect() == 0)
         {
            b.x = this.sourceRole.x - 55;
            b.setSpeed(-9,0);
         }
         else
         {
            b.x = this.sourceRole.x + 55;
            b.setSpeed(9,0);
         }
         b.setDestroyWhenLastFrame(false);
         b.setFuncWhenEnterFrame(function(bb:BaseBullet):*
         {
            var p:Point = gc.gameSence.localToGlobal(new Point(bb.x,bb.y));
            trace("p:" + p);
            if(p.x > 930)
            {
               bb.x -= bb.x - 930;
            }
            else if(p.x < 10)
            {
               bb.x -= p.x;
            }
         });
         b.setDestroyInCount(gc.frameClips * 2);
         b.setDistance(9999);
         b.setFuncWhenHit(function(bb:EnemyMoveBullet):*
         {
            bb.setSpeed(0,0);
         });
         b.setFuncWhenDestroy(destroyfunc);
         b.y = this.sourceRole.y + 40;
         b.setRole(this.sourceRole);
         b.setDirect(0);
         b.setAction("football1");
         var parentIdx:int = gc.gameSence.getChildIndex(this.sourceRole);
         if(parentIdx != -1)
         {
            gc.gameSence.addChildAt(b,parentIdx);
         }
         this.sourceRole.magicBulletArray.push(b);
         this.b.setFuncWhenEnterFrame(enterFrame);
      }
      
      private function destroyfunc(bb:BaseBullet) : void
      {
         this.dispatchEvent(new Event("destroy"));
      }
      
      private function enterFrame(bb:BaseBullet) : void
      {
         var p:* = null;
         if(!this.isScore)
         {
            p = gc.gameSence.localToGlobal(new Point(bb.x,bb.y));
            if(p.x <= 940 && p.x > 843 && p.y > 350 && p.y < 500)
            {
               this.isScore = true;
               this.dispatchEvent(new Event("score"));
               this.dispatchEvent(new Event("destroy"));
            }
         }
      }
   }
}
