package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.CommonEvent;
   
   public class auraWhile extends BaseAura
   {
       
      
      public function auraWhile(sm:BaseMonster, sh:BaseHero)
      {
         super(sm,sh);
         this.power = 5;
      }
      
      override public function destroy() : void
      {
         if(this.sourceHero)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,0,0,0,this.power]));
         }
         super.destroy();
      }
   }
}
