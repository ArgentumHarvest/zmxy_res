package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.*;
   
   public class auraGreen extends BaseAura
   {
       
      
      public function auraGreen(param1:BaseMonster, param2:BaseHero)
      {
         super(param1,param2);
         this.power = param2.roleProperies.getSHHP() / 20 < 10 ? 10 : int(param2.roleProperies.getSHHP() / 20);
      }
      
      override protected function destroy() : void
      {
         super.destroy();
         gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,this.power,0,0,0]));
      }
   }
}
