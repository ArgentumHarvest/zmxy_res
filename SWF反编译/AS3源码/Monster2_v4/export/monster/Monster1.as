package export.monster
{
   import base.BaseMonster;
   
   public class Monster1 extends BaseMonster
   {
       
      
      public function Monster1()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 50;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 80;
         this.def = 0;
         this.exp = 5;
         this.gxp = 1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[2,-5],
            "AttackInterval":4,
            "power":5,
            "attackKind":"physics"
         };
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
