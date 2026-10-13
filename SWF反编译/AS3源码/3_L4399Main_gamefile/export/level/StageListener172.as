package export.level
{
   import base.BaseLevelListenering;
   import base.Wall;
   import com.greensock.TweenMax;
   import export.ThroughWall;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import my.MainGame;
   
   public class StageListener172 extends BaseLevelListenering
   {
       
      
      private var movingFloorArray:Array;
      
      private var positionArray:Array;
      
      private var tw:TweenMax;
      
      public function StageListener172()
      {
         movingFloorArray = [];
         positionArray = [[300,340],[810,180]];
         super();
         waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         var i:int = 0;
         var wall:* = null;
         var p:* = null;
         super.step();
         for(i = 0; i < this.movingFloorArray.length; )
         {
            wall = this.movingFloorArray[i] as Wall;
            p = gc.gameSence.localToGlobal(new Point(wall.x,wall.y));
            if(p.x < -wall.width / 2)
            {
               wall.x += 1400;
            }
            else if(p.x > 940 + wall.width / 2)
            {
               wall.x -= 1400;
            }
            i++;
         }
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().doSaveGame();
         tw = TweenMax.delayedCall(2,function(_self:StageListener172):*
         {
            _self.tw = null;
            MainGame.getInstance().createMonster(106,600,200);
         },[this]);
      }
      
      public function showMovingFloor() : void
      {
         var i:int = 0;
         var wall:* = null;
         for(i = 0; i < 2; )
         {
            wall = new ThroughWall();
            if(i == 0)
            {
               wall.speedX = 2;
            }
            else
            {
               wall.speedX = -2;
            }
            wall.x = this.positionArray[0][0];
            wall.y = this.positionArray[0][1];
            wall.width = 235;
            wall.height = 57;
            this.positionArray.shift();
            wall.userDataName = "StageListener172Floor";
            wall.visible = false;
            this.movingFloorArray.push(wall);
            gc.pWorld.getWallArray().push(wall);
            gc.gameSence.addChild(wall);
            i++;
         }
      }
      
      public function showStandingFloor() : void
      {
         var floor:Bitmap = AUtils.getImageObj("StageListener172StandFloor") as Bitmap;
         floor.x = -30;
         floor.y = 500;
         gc.gameSence.addChild(floor);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         this.movingFloorArray.length = 0;
         this.positionArray.length = 0;
      }
   }
}
