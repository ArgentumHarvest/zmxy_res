package export.monster
{
   import base.BaseMonster;
   
   public class Monster7 extends BaseMonster
   {
       
      
      public function Monster7()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 600;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 110;
         this.def = 8;
         this.exp = 22;
         this.gxp = 10;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[5,-5],
            "AttackInterval":4,
            "power":35,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.fallList = [{
            "name":"ptxzf",
            "bigtype":"zb"
         },{
            "name":"ptxzg",
            "bigtype":"zb"
         },{
            "name":"ptjs",
            "bigtype":"zb"
         },{
            "name":"ptsmz",
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
