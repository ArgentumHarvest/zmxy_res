package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseObject;
   import base.Wall;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.hero.Role2;
   import export.hero.Role4;
   import export.level.StageListener11Children.Stage11LiftFloor;
   import export.monster.Monster3;
   import flash.display.MovieClip;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener11 extends BaseLevelListenering
   {
       
      
      private var monsterAppearCount:uint = 72;
      
      private var CHECKLIFTCOUNTCONST:uint = 120;
      
      private var checkLiftCount:uint;
      
      private var _boss:Monster3;
      
      private var secretBird:Number = 0;
      
      public function StageListener11()
      {
         checkLiftCount = CHECKLIFTCOUNTCONST;
         super();
         waitForRegisterDataArray = ["Monster8","Monster7"];
         gc.eventManger.addEventListener("closeSettingViewCmd",closeSettingView,false,0,true);
      }
      
      override public function start() : void
      {
         super.start();
      }
      
      override public function step() : void
      {
         super.step();
         if(!gc.vControllor.getStepState())
         {
            var flag:Boolean = false;
            var heros:Array = gc.getPlayerArray();
            for each(bh in heros)
            {
               if(bh.y <= -1900)
               {
                  flag = true;
               }
            }
            if(flag)
            {
               for each(bo in gc.getPlayerAndPetArray())
               {
                  if(bo.y >= -1862)
                  {
                     bo.y = -1950;
                  }
               }
               TweenMax.to(gc.gameSence,2,{
                  "y":2370,
                  "onComplete":function(_self:StageListener11):*
                  {
                     _self.callBoss();
                  },
                  "onCompleteParams":[this]
               });
               for each(bh in heros)
               {
                  if(bh is Role2)
                  {
                     if(Role2(bh).role2Shalldow)
                     {
                        Role2(bh).role2Shalldow.destroy();
                        Role2(bh).role2Shalldow = null;
                     }
                  }
                  else if(bh is Role4)
                  {
                     Role4(bh).clearBiaoJi();
                  }
               }
               gc.vControllor.setStopStep();
            }
         }
         if(this.monsterAppearCount > 0)
         {
            this.monsterAppearCount--;
         }
         if(this.monsterAppearCount == 0)
         {
            if(gc.hero1 && gc.hero2)
            {
               var randHero:BaseHero = RandomControllor.getIns().getRandom() < 0.5 ? gc.hero1 : gc.hero2;
            }
            else if(gc.hero1)
            {
               randHero = gc.hero1;
            }
            if(randHero)
            {
               var maxNums:uint = 0;
               if(gc.getPlayerArray().length == 2)
               {
                  maxNums = 2;
               }
               else
               {
                  maxNums = 1;
               }
               for(var i:uint = 0; i < maxNums; )
               {
                  MainGame.getInstance().createMonster(30,randHero.x + (RandomControllor.getIns().getRandom() - 0.5) * 300,randHero.y - (100 + RandomControllor.getIns().getRandom() * 200));
                  i++;
               }
            }
            this.monsterAppearCount = gc.frameClips * 6;
         }
         if(!this._boss)
         {
            if(this.checkLiftCount > 0)
            {
               this.checkLiftCount--;
               if(this.checkLiftCount == 0)
               {
                  this.showLift();
                  this.showArrow();
                  this.checkLiftCount = CHECKLIFTCOUNTCONST;
               }
            }
         }
         this.bornManyBird();
      }
      
      private function bornManyBird() : void
      {
         var randHero:* = null;
         var maxNums:* = 0;
         var i:* = 0;
         if(this.secretBird > 0)
         {
            if(gc.hero1 && gc.hero2)
            {
               randHero = RandomControllor.getIns().getRandom() < 0.5 ? gc.hero1 : gc.hero2;
            }
            else if(gc.hero1)
            {
               randHero = gc.hero1;
            }
            if(randHero)
            {
               maxNums = uint(2);
               for(i = uint(0); i < maxNums; )
               {
                  MainGame.getInstance().createMonster(30,randHero.x + (RandomControllor.getIns().getRandom() - 0.5) * 300,randHero.y - (100 + RandomControllor.getIns().getRandom() * 200));
                  i++;
               }
            }
            this.secretBird -= 2;
         }
      }
      
      private function showArrow() : void
      {
         var mc:MovieClip = AUtils.getNewObj("GOGOFORUP") as MovieClip;
         mc.x = 475;
         mc.y = 50;
         gc.gameInfo.addChild(mc);
         TweenMax.delayedCall(2,function(_mc:MovieClip):*
         {
            if(_mc.parent)
            {
               _mc.parent.removeChild(_mc);
            }
         },[mc]);
      }
      
      private function showLift() : void
      {
         var lift:Stage11LiftFloor = new Stage11LiftFloor();
         lift.x = gc.hero1.x;
         lift.y = 550;
         var wallArr:Array = gc.pWorld.getWallArray();
         var lastWall:Wall = wallArr[wallArr.length - 1];
         var idx:int = gc.gameSence.getChildIndex(lastWall);
         if(idx != -1)
         {
            gc.gameSence.addChildAt(lift,idx);
         }
         else
         {
            gc.gameSence.addChild(lift);
         }
         gc.pWorld.getWallArray().push(lift);
      }
      
      public function callBoss() : void
      {
         this._boss = MainGame.getInstance().createMonster(3,750,-2050) as Monster3;
      }
      
      public function closeSettingView(evt:CommonEvent) : void
      {
         var secret:String = evt.data.secret;
         if(secret == "caifumima")
         {
            this.secretBird = 50;
         }
      }
      
      override public function destroy() : void
      {
         _boss = null;
         super.destroy();
      }
   }
}
