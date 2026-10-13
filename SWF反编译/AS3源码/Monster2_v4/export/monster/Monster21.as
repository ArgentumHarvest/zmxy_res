package export.monster
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public class Monster21 extends BaseMonster
   {
       
      
      public function Monster21()
      {
         super();
         this.isBoss = true;
         this.monsterName = "蝙蝠洞";
         this.horizenSpeed = 0;
         this.Hp = sHp = 6000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 25;
         this.exp = 0;
         this.gxp = 0;
         this.probability = 0.25;
         this.fallList = [{
            "name":"jcsz",
            "bigtype":"zb"
         },{
            "name":"jcbj",
            "bigtype":"zb"
         },{
            "name":"jcys",
            "bigtype":"zb"
         }];
      }
      
      override protected function attackTarget() : void
      {
      }
      
      override protected function normalWalk() : void
      {
      }
      
      override public function destroy() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.destroy();
         if(this.isBoss)
         {
            _loc1_ = gc.pWorld.getTransferDoorArray();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc2_];
               _loc3_.visible = true;
               _loc2_++;
            }
         }
      }
      
      override protected function move() : void
      {
      }
   }
}
