package export.aura
{
   import base.BaseAura;
   import base.BaseHero;
   import base.BaseMonster;
   import event.*;
   
   public class auraWhile extends BaseAura
   {
       
      
      public function auraWhile(param1:BaseMonster, param2:BaseHero)
      {
         super(param1,param2);
         this.power = 5;
      }
      
      override protected function destroy() : void
      {
         super.destroy();
         gc.eventManger.dispatchEvent(new CommonEvent("AuraEvent",[this.sourceHero,0,0,0,this.power]));
      }
   }
}
