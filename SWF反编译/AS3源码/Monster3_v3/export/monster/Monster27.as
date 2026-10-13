package export.monster
{
   import base.BaseMonster;
   
   public class Monster27 extends BaseMonster
   {
       
      
      private var totalStage:uint;
      
      public function Monster27()
      {
         super();
         this.monsterName = "宝箱";
         this.horizenSpeed = 0;
         if(gc.curStage < 4)
         {
            this.totalStage = (gc.curStage - 1) * 3 + gc.curLevel;
         }
         else
         {
            this.totalStage = 10;
         }
         this.Hp = sHp = 20 * this.totalStage * this.totalStage * this.totalStage + 20 * this.totalStage * this.totalStage + 100;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 25;
         this.exp = 0;
         this.gxp = 0;
         this.probability = 0.75;
         this.fallList = [{
            "name":"tndbthl",
            "bigtype":"zb"
         },{
            "name":"tndblg",
            "bigtype":"zb"
         },{
            "name":"zcld",
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
         gc.allEquip.initHouDong(this.totalStage);
         if(this.Hp <= 0)
         {
            this.dropAura();
         }
         super.destroy();
      }
      
      override protected function move() : void
      {
         this.speed.x = 0;
         super.move();
      }
   }
}
