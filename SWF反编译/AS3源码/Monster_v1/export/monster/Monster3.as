package export.monster
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public class Monster3 extends BaseMonster
   {
       
      
      public function Monster3()
      {
         addFrameScript(0,this.frame1);
         super();
         this.monsterName = "大猩猩";
         if(gc.curLevel == 1 && gc.curStage == 1)
         {
            this.isBoss = true;
         }
         else
         {
            this.isBoss = false;
         }
         this.horizenSpeed = 3;
         if(gc.curLevel == 1 && gc.curStage == 1)
         {
            this.Hp = sHp = 900;
         }
         else
         {
            this.Hp = sHp = 300;
         }
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 5;
         if(this.isBoss)
         {
            this.exp = 25;
            this.gxp = 3;
         }
         else
         {
            this.exp = 7;
            this.gxp = 3;
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
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":20,
            "attackKind":"physics"
         };
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1";
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
      
      function frame1() : *
      {
         stop();
      }
   }
}
