package export.level.StageListener171Children
{
   import base.BaseHero;
   import base.BaseMonster;
   import export.aura.auraGreen;
   import flash.geom.Point;
   
   public class Monster105Aura extends auraGreen
   {
       
      
      private var val:int = 0;
      
      public function Monster105Aura(sm:BaseMonster, sh:BaseHero, value:uint)
      {
         this.val = value;
         super(sm,sh);
      }
      
      override public function step() : void
      {
         var p:* = null;
         if(this.correntState == 3)
         {
            return;
         }
         if(this.correntState == 1)
         {
            if(this.startCount > 0)
            {
               this.startCount--;
            }
            else
            {
               this.startUp();
            }
         }
         else if(this.correntState == 2)
         {
            p = AUtils.GetNextPointByTwoObj(this,this.sourceMonster);
            this.x += p.x * this.speed;
            this.y += p.y * this.speed;
            this.speed += 2;
            if(this.speed > 20)
            {
               this.speed = 20;
            }
            if(AUtils.GetDisBetweenTwoObj(this,this.sourceMonster) <= 10)
            {
               this.destroy();
            }
         }
         count++;
         if(count > gc.frameClips * 15)
         {
            this.destroy();
         }
      }
      
      override public function destroy() : void
      {
         this.sourceMonster.cureHp(this.val);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.isReadyToDestroy = true;
         this.sourceMonster = null;
         this.sourceHero = null;
      }
   }
}
