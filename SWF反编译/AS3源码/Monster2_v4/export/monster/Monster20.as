package export.monster
{
   import base.BaseMonster;
   
   public class Monster20 extends BaseMonster
   {
       
      
      public function Monster20()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 1400;
         this.mysee = 400;
         this.isattback = 50;
         this.attackRange = 200;
         this.def = 30;
         this.exp = 65;
         this.gxp = 30;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[10,-2],
            "AttackInterval":4,
            "power":100,
            "attackKind":"physics"
         };
         this.fallList = [{
            "name":"yxxzf",
            "bigtype":"zb"
         },{
            "name":"yxxzg",
            "bigtype":"zb"
         },{
            "name":"yxjs",
            "bigtype":"zb"
         },{
            "name":"yxsmz",
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
