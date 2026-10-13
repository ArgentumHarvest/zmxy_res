package export.monster
{
   import base.BaseMonster;
   
   public class Monster2 extends BaseMonster
   {
       
      
      public function Monster2()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 100;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 110;
         this.def = 1;
         this.exp = 6;
         this.gxp = 2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[6,-5],
            "AttackInterval":4,
            "power":12,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.fallList = [{
            "name":"ccxzf",
            "bigtype":"zb"
         },{
            "name":"ccxzg",
            "bigtype":"zb"
         },{
            "name":"ccjs",
            "bigtype":"zb"
         },{
            "name":"ccsmz",
            "bigtype":"zb"
         }];
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
   }
}
