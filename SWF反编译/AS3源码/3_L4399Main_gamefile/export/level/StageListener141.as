package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import export.hero.Role2;
   import export.hero.Role4;
   import flash.display.MovieClip;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener141 extends BaseLevelListenering
   {
       
      
      private var monsterAppearCount:uint = 72;
      
      private var isCallBoss:Boolean = false;
      
      public function StageListener141()
      {
         super();
         waitForRegisterDataArray = ["Monster61"];
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
            if(gc.getPlayerArray().length == 2)
            {
               if(gc.hero1 && gc.hero2)
               {
                  if(gc.hero1.y <= -2100 && gc.hero2.y <= -2100)
                  {
                     flag = true;
                  }
               }
            }
            else
            {
               if(gc.hero1)
               {
                  if(gc.hero1.y <= -2100)
                  {
                     flag = true;
                  }
               }
               if(gc.hero2)
               {
                  if(gc.hero2.y <= -2100)
                  {
                     flag = true;
                  }
               }
            }
            if(flag)
            {
               TweenMax.to(gc.gameSence,1,{
                  "y":2450,
                  "onComplete":function(_self:StageListener141):*
                  {
                     _self.callBoss();
                  },
                  "onCompleteParams":[this]
               });
               for each(bh in gc.getPlayerArray())
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
                     maxNums = 3;
                  }
                  else
                  {
                     maxNums = 2;
                  }
                  for(var i:uint = 0; i < maxNums; )
                  {
                     MainGame.getInstance().createMonster(61,randHero.x + (RandomControllor.getIns().getRandom() - 0.5) * 300,randHero.y - (100 + RandomControllor.getIns().getRandom() * 200));
                     i++;
                  }
               }
               this.monsterAppearCount = gc.frameClips * 6;
            }
         }
         else
         {
            for each(bh in gc.getPlayerArray())
            {
               if(bh.y > -1800)
               {
                  if(bh.roleProperies)
                  {
                     bh.reduceHp(bh.roleProperies.getSHHP());
                  }
               }
            }
         }
         if(this.isCallBoss)
         {
            if(gc.pWorld.monsterArray.length == 0)
            {
               this.showTransferDoor();
            }
         }
      }
      
      private function showTransferDoor() : void
      {
         var f:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(f = 0; f < ta.length; )
         {
            mc = ta[f];
            mc.visible = true;
            f++;
         }
      }
      
      public function callBoss() : void
      {
         this.isCallBoss = true;
         MainGame.getInstance().createMonster(61,100,-2300);
         MainGame.getInstance().createMonster(61,200,-2350);
         MainGame.getInstance().createMonster(61,300,-2400);
         MainGame.getInstance().createMonster(61,400,-2450);
         MainGame.getInstance().createMonster(61,500,-2400);
         MainGame.getInstance().createMonster(61,600,-2350);
         MainGame.getInstance().createMonster(61,700,-2300);
         MainGame.getInstance().createMonster(61,150,-2325);
         MainGame.getInstance().createMonster(61,250,-2375);
         MainGame.getInstance().createMonster(61,350,-2425);
         MainGame.getInstance().createMonster(61,450,-2375);
         MainGame.getInstance().createMonster(61,550,-2325);
         MainGame.getInstance().createMonster(61,650,-2300);
         MainGame.getInstance().createMonster(61,700,-2250);
         MainGame.getInstance().createMonster(61,750,-2200);
      }
   }
}
