package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.CommonEvent;
   
   public class auraRed extends BaseAura
   {
       
      
      public function auraRed(sm:BaseMonster, sh:BaseHero)
      {
         super(sm,sh);
      }
      
      override public function destroy() : void
      {
         if(this.sourceHero)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,0,0,this.power,0]));
         }
         super.destroy();
      }
   }
}
