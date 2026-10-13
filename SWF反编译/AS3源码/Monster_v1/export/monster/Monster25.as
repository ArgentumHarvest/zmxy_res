package export.monster
{
   import base.BaseMonster;
   
   public class Monster25 extends BaseMonster
   {
       
      
      public function Monster25()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 5000;
         this.mysee = 300;
         this.isattback = 80;
         this.attackRange = 110;
         this.def = 120;
         this.exp = 45;
         this.gxp = 30;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[10,-3],
            "AttackInterval":4,
            "power":200,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.fallList = [{
            "name":"jlxzf",
            "bigtype":"zb"
         },{
            "name":"jlxzg",
            "bigtype":"zb"
         },{
            "name":"jljs",
            "bigtype":"zb"
         },{
            "name":"jlsmz",
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
