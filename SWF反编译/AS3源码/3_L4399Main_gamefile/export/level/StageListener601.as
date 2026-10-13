package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.level.StageListener601Children.FallBall;
   import export.level.StageListener601Children.ScoreBar;
   import export.magicWeapon.MagicFootballInStage60;
   import flash.display.Bitmap;
   import flash.events.Event;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   import user.User;
   
   public class StageListener601 extends BaseLevelListenering
   {
       
      
      private var mg:MagicFootballInStage60;
      
      private var bhArr:Array;
      
      private var fallBall:FallBall;
      
      private var scorebar:ScoreBar;
      
      private var door:Bitmap;
      
      public function StageListener601()
      {
         bhArr = [];
         super();
         this.waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         var arr:* = null;
         super.step();
         if(this.fallBall)
         {
            if(this.fallBall.y > 600)
            {
               this.fallBall.destroy();
               this.fallBall = null;
            }
            else
            {
               this.fallBall.x += this.fallBall.speed.x;
               this.fallBall.y += this.fallBall.speed.y;
               this.fallBall.speed.y += 0.2;
               if(this.fallBall.speed.y > 6)
               {
                  this.fallBall.speed.y = 6;
               }
               arr = gc.getPlayerArray();
               for each(var bh in arr)
               {
                  if(AUtils.GetDisBetweenTwoObj(bh,this.fallBall) <= 100)
                  {
                     this.addMagicTo(bh);
                     this.fallBall.destroy();
                     this.fallBall = null;
                     break;
                  }
               }
            }
         }
         if(this.mg)
         {
            this.mg.step();
         }
         if(this.scorebar)
         {
            this.scorebar.step();
         }
      }
      
      override public function start() : void
      {
         super.start();
         this.scorebar = new ScoreBar();
         this.scorebar.x = 470 - this.scorebar.width / 2;
         this.scorebar.y = 35;
         gc.gameInfo.addChild(this.scorebar);
         this.scorebar.addEventListener("over",__over);
         this.scorebar.addEventListener("ball",__ball);
         var bm:Bitmap = AUtils.getImageObj("scoretip");
         bm.x = 470 - bm.width / 2;
         bm.y = this.scorebar.y + 90;
         gc.gameInfo.addChild(bm);
         var bm1:BaseMonster = MainGame.getInstance().createMonster(33,400,200);
         var bm2:BaseMonster = MainGame.getInstance().createMonster(34,600,200);
         bm1.setFallList([]);
         bm2.setFallList([]);
         for each(var bh in gc.getPlayerArray())
         {
            bh.addEventListener("use_magicweapon",__useMagicWeapon);
            bhArr.push(bh);
         }
         door = AUtils.getImageObj("footballdoor");
         door.x = 816;
         door.y = 295;
         gc.gameSence.addChild(door);
      }
      
      protected function __ball(evt:Event) : void
      {
         if(this.mg)
         {
            return;
         }
         this.fallBall = new FallBall();
         this.fallBall.speed.x = 5 + RandomControllor.getIns().getRandom() * 5;
         this.fallBall.speed.y = -3 - RandomControllor.getIns().getRandom() * 3;
         this.fallBall.x = -60;
         this.fallBall.y = 150;
         var index:int = gc.gameSence.getChildIndex(door);
         gc.gameSence.addChildAt(this.fallBall,index - 1);
      }
      
      private function addMagicTo(bh:BaseHero) : void
      {
         if(bh.isDead())
         {
            return;
         }
         var mg:MagicFootballInStage60 = new MagicFootballInStage60(bh);
         mg.addEventListener("score",__score);
         mg.addEventListener("destroy",__destroyMg);
         var index:int = gc.gameSence.getChildIndex(door);
         gc.gameSence.addChildAt(mg,index - 1);
         this.mg = mg;
      }
      
      protected function __destroyMg(evt:Event) : void
      {
         if(this.mg)
         {
            this.mg.removeEventListener("score",__score);
            this.mg.removeEventListener("destroy",__destroyMg);
            this.mg = null;
         }
      }
      
      protected function __over(evt:Event) : void
      {
         evt = evt;
         MainGame.getInstance().stopGame();
         var rate:Number = 1;
         rate += this.scorebar.getRateAdd();
         if(rate > 2.4)
         {
            rate = 2.4;
         }
         gc.ts.setTxt("恭喜你获得法宝 足球(" + rate + ") X1");
         gc.stage.addChild(gc.ts);
         var users:Array = gc.getUsersArray();
         for each(player in users)
         {
            if(player != gc.player3)
            {
               var equip:MyEquipObj = gc.allEquip.findByName("bxzq");
               equip.setEupdata(rate);
               player.zblist.push(equip);
            }
         }
         TweenMax.delayedCall(4,function():*
         {
            MainGame.getInstance().continueGame();
            MainGame.getInstance().destroyGameAndSaveGame();
            GMain.getInstance().switchSence("showStageMap");
         });
      }
      
      protected function __useMagicWeapon(evt:Event) : void
      {
         var bh:BaseHero = evt.currentTarget as BaseHero;
         if(this.mg)
         {
            if(this.mg.getSourceHero() == bh)
            {
               this.mg.useSkill();
            }
         }
      }
      
      protected function __score(event:Event) : void
      {
         trace("得分！");
         this.scorebar.addScore();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.scorebar)
         {
            this.scorebar.removeEventListener("over",__over);
            this.scorebar.removeEventListener("ball",__ball);
            this.scorebar = null;
         }
         for each(var bh in bhArr)
         {
            bh.removeEventListener("use_magicweapon",__useMagicWeapon);
         }
         bhArr = null;
         door = null;
         if(this.mg)
         {
            this.mg.removeEventListener("score",__score);
            this.mg.removeEventListener("destroy",__destroyMg);
            this.mg = null;
         }
      }
   }
}
