package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.CommonEvent;
   
   public class auraGreen extends BaseAura
   {
       
      
      public function auraGreen(sm:BaseMonster, sh:BaseHero)
      {
         super(sm,sh);
         this.power = sh.roleProperies.getSHHP() / 20 < 10 ? 10 : sh.roleProperies.getSHHP() / 20;
      }
      
      override public function destroy() : void
      {
         if(this.sourceHero)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,this.power,0,0,0]));
         }
         super.destroy();
      }
   }
}
