package export.monster
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public class Monster17 extends BaseMonster
   {
       
      
      public function Monster17()
      {
         super();
         this.horizenSpeed = 3;
         this.monsterName = "龟丞相";
         this.mysee = 300;
         this.isattback = 60;
         this.attackRange = 400;
         this.def = 70;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[2,-5],
            "AttackInterval":999,
            "power":110,
            "attackKind":"magic"
         };
         if(gc.curStage == 3 && gc.curLevel == 1)
         {
            this.isBoss = true;
         }
         if(!this.isBoss)
         {
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
         if(gc.curStage == 3 && gc.curLevel == 1)
         {
            this.isBoss = true;
            this.exp = 200;
            this.gxp = 60;
            this.Hp = sHp = 4800;
         }
         else
         {
            this.isBoss = false;
            this.exp = 75;
            this.gxp = 30;
            this.Hp = sHp = 1600;
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
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
   }
}
