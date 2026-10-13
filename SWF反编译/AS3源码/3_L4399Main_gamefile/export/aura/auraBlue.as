package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.CommonEvent;
   
   public class auraBlue extends BaseAura
   {
       
      
      public function auraBlue(sm:BaseMonster, sh:BaseHero)
      {
         super(sm,sh);
         this.power = sh.roleProperies.getSMMP() / 20 < 10 ? 10 : sh.roleProperies.getSMMP() / 20;
      }
      
      override public function destroy() : void
      {
         if(this.sourceHero)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,0,this.power,0,0]));
         }
         super.destroy();
      }
   }
}
