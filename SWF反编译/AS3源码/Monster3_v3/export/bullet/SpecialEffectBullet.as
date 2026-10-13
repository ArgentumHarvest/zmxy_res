package export.bullet
{
   import base.BaseBullet;
   
   public class SpecialEffectBullet extends BaseBullet
   {
       
      
      public function SpecialEffectBullet(param1:String)
      {
         super(param1);
      }
      
      override protected function step() : void
      {
         super.step();
      }
      
      override public function setScale(param1:Number, param2:Number) : void
      {
         super.setScale(param1,param2);
         if(param1 > 1)
         {
            this.setScale(0.7,1);
         }
      }
   }
}
