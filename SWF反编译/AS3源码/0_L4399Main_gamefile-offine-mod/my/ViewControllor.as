package my
{
   import base.BaseHero;
   import config.Config;
   import export.StopPoint;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ViewControllor
   {
       
      
      private var gc:Config;
      
      private var role1:BaseHero;
      
      private var role2:BaseHero;
      
      private var maxRightX:Number;
      
      private var maxBGRightX:Number;
      
      private var canBackward:Number = 0;
      
      private var thisStopX:Number = 0;
      
      private var lastPointX:Number = 0;
      
      private var isAutoCamera:Boolean = false;
      
      private var shakeVal:Number = 0;
      
      private var stopStep:Boolean = false;
      
      private var minGameSenceY:Number = 0;
      
      var count:int = 0;
      
      public function ViewControllor()
      {
         var i:* = 0;
         var dio:* = null;
         super();
         gc = Config.getInstance();
         var maxRX:Number = 0;
         for(i = uint(0); i < gc.gameSence.numChildren; )
         {
            dio = gc.gameSence.getChildAt(i);
            if(dio.x > maxRX)
            {
               maxRX = dio.x;
            }
            i++;
         }
         maxRightX = 940 - maxRX;
         maxBGRightX = 940 - gc.bg1.width;
         this.minGameSenceY = gc.gameSence.getBounds(gc.gameSence.parent).y;
      }
      
      public function shake(s:int) : void
      {
         if(this.shakeVal == 0)
         {
            this.shakeVal = s;
         }
      }
      
      public function step() : void
      {
         var role1Rect:* = null;
         var role2Rect:* = null;
         var stopPoint:* = null;
         var stopPointX:Number = NaN;
         var stopBGPointX:Number = NaN;
         var stopLeftPointX:Number = NaN;
         var lastPoint:* = null;
         var gameSenceMove:Number = NaN;
         var bgMove:Number = NaN;
         var stopPointXXX:Number = NaN;
         var averageY:Number = NaN;
         var lowestY:Number = NaN;
         var minLeft:Number = NaN;
         var minLeftGlobal:Number = NaN;
         var spd1:int = 0;
         var spd2:int = 0;
         if(this.shakeVal > 0)
         {
            gc.gameSence.x += this.shakeVal;
            this.shakeVal *= -1;
         }
         else if(this.shakeVal < 0)
         {
            gc.gameSence.x += this.shakeVal;
            this.shakeVal = 0;
         }
         if(this.stopStep)
         {
            return;
         }
         if(!(gc.curStageAndCurLevel.curStage == 0 && gc.curStageAndCurLevel.curLevel == 2 || gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 4 && gc.curStageAndCurLevel.curLevel < 6 || gc.curStageAndCurLevel.curStage == 14 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 22 && gc.curStageAndCurLevel.curLevel == 3 || gc.curStageAndCurLevel.curStage == 47 || gc.curStageAndCurLevel.curStage == 48 || gc.curStageAndCurLevel.curStage == 49 || gc.curStageAndCurLevel.curStage == 50 || gc.curStageAndCurLevel.curStage == 51 || gc.curStageAndCurLevel.curStage == 52 || gc.curStageAndCurLevel.curStage == 53 || gc.curStageAndCurLevel.curStage == 54 || gc.curStageAndCurLevel.curStage == 55 || gc.curStageAndCurLevel.curStage == 56 || gc.curStageAndCurLevel.curStage == 57 || gc.curStageAndCurLevel.curStage == 58 || gc.curStageAndCurLevel.curStage == 59 || gc.curStageAndCurLevel.curStage == 60 || gc.curStageAndCurLevel.curStage == 63 || gc.curStageAndCurLevel.curStage == 64 || gc.curStageAndCurLevel.curStage == 65 || gc.curStageAndCurLevel.curStage == 25 && gc.curStageAndCurLevel.curLevel == 4))
         {
            if(this.role1 && !this.role1.isDead())
            {
               role1Rect = this.role1.colipse.getBounds(gc.gameSence.parent);
               role2Rect = role1Rect;
               if(this.role2 && !this.role2.isDead())
               {
                  role2Rect = this.role2.colipse.getBounds(gc.gameSence.parent);
               }
            }
            else
            {
               if(!(this.role2 && !this.role2.isDead()))
               {
                  return;
               }
               role1Rect = this.role2.colipse.getBounds(gc.gameSence.parent);
               role2Rect = role1Rect;
            }
            stopPointX = maxRightX;
            stopBGPointX = maxBGRightX;
            stopLeftPointX = 0;
            if((gc.pWorld.getStopPointArray() as Array).length > 0)
            {
               stopPoint = gc.pWorld.getStopPointArray()[0] as StopPoint;
               if(lastPointX == 0)
               {
                  lastPoint = (gc.pWorld.getStopPointArray() as Array)[(gc.pWorld.getStopPointArray() as Array).length - 1] as StopPoint;
                  lastPointX = lastPoint.getDataX();
               }
            }
            gameSenceMove = 0;
            if(stopPoint)
            {
               stopPointXXX = gc.gameSence.localToGlobal(new Point(stopPoint.getDataX(),stopPoint.y)).x;
            }
            else
            {
               thisStopX = -lastPointX + 870;
            }
            count++;
            if(role1Rect.x >= 626.6666666666666 && role2Rect.x >= 188)
            {
               gameSenceMove = Math.max(this.getMaxSpeedBetweenToPlayer(),0);
               bgMove = gameSenceMove * (gc.bg1.width - 940) / (gc.gameSence.width - 940);
               if(thisStopX != 0 && gc.gameSence.x > thisStopX)
               {
                  if(gc.gameSence.x - gameSenceMove > this.maxRightX)
                  {
                     gc.gameSence.x -= gameSenceMove;
                     gc.bg1.x -= bgMove;
                  }
                  else
                  {
                     gc.gameSence.x = this.maxRightX;
                     gc.bg1.x = this.maxBGRightX;
                  }
                  if(canBackward != -99)
                  {
                     canBackward += gameSenceMove;
                  }
               }
               else if(stopPoint && !stopPoint.isSendMonster)
               {
                  gc.gameSence.x -= gameSenceMove;
                  gc.bg1.x -= bgMove;
                  canBackward += gameSenceMove;
                  if(stopPointXXX <= 980 && stopPointXXX >= 900)
                  {
                     if(stopPoint)
                     {
                        canBackward = stopPoint.getLeftDataX();
                        thisStopX = gc.gameSence.x;
                        stopPoint.touch();
                     }
                  }
                  else
                  {
                     canBackward = -99;
                     thisStopX = 0;
                  }
               }
            }
            else if(role1Rect.x >= 188 && role2Rect.x >= 626.6666666666666)
            {
               gameSenceMove = Math.max(this.getMaxSpeedBetweenToPlayer(),0);
               bgMove = gameSenceMove * (gc.bg1.width - 940) / (gc.gameSence.width - 940);
               if(thisStopX != 0 && gc.gameSence.x > thisStopX)
               {
                  if(gc.gameSence.x - gameSenceMove > this.maxRightX)
                  {
                     gc.gameSence.x -= gameSenceMove;
                     gc.bg1.x -= bgMove;
                  }
                  else
                  {
                     gc.gameSence.x = this.maxRightX;
                     gc.bg1.x = this.maxBGRightX;
                  }
                  if(canBackward != -99)
                  {
                     canBackward += gameSenceMove;
                  }
               }
               else if(stopPoint && !stopPoint.isSendMonster)
               {
                  gc.gameSence.x -= gameSenceMove;
                  gc.bg1.x -= bgMove;
                  canBackward += gameSenceMove;
                  if(stopPointXXX <= 980 && stopPointXXX >= 900)
                  {
                     if(stopPoint)
                     {
                        canBackward = stopPoint.getLeftDataX();
                        thisStopX = gc.gameSence.x;
                        stopPoint.touch();
                     }
                  }
                  else
                  {
                     canBackward = -99;
                     thisStopX = 0;
                  }
               }
            }
            else if(role1Rect.x <= 626.6666666666666 && role2Rect.x <= 188 && (canBackward > 0 || canBackward == -99))
            {
               if(this.isCanBackWardAll())
               {
                  canBackward = -99;
               }
               if(canBackward > 0 || canBackward == -99)
               {
                  gameSenceMove = Math.min(this.getMinSpeedBetweenToPlayer(),0);
                  bgMove = gameSenceMove * (gc.bg1.width - 940) / (gc.gameSence.width - 940);
                  if(gc.gameSence.x - gameSenceMove <= 0)
                  {
                     gc.gameSence.x -= gameSenceMove;
                     gc.bg1.x -= bgMove;
                     if(gc.bg1.x > 0)
                     {
                        gc.bg1.x = 0;
                     }
                     if(canBackward > 0)
                     {
                        canBackward -= -gameSenceMove;
                     }
                  }
               }
            }
            else if(role1Rect.x <= 188 && role2Rect.x <= 626.6666666666666 && (canBackward > 0 || canBackward == -99))
            {
               if(this.isCanBackWardAll())
               {
                  canBackward = -99;
               }
               if(canBackward > 0 || canBackward == -99)
               {
                  gameSenceMove = Math.min(this.getMinSpeedBetweenToPlayer(),0);
                  bgMove = gameSenceMove * (gc.bg1.width - 940) / (gc.gameSence.width - 940);
                  if(gc.gameSence.x - gameSenceMove <= 0)
                  {
                     gc.gameSence.x -= gameSenceMove;
                     gc.bg1.x -= bgMove;
                     if(gc.bg1.x > 0)
                     {
                        gc.bg1.x = 0;
                     }
                     if(canBackward > 0)
                     {
                        canBackward -= -gameSenceMove;
                     }
                  }
               }
            }
         }
         if(gc.isInHost() || gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 7 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 11 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 14 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 16 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 41 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 22 && gc.curStageAndCurLevel.curLevel == 3)
         {
            averageY = 0;
            lowestY = 99;
            for each(var bh in gc.getPlayerArray())
            {
               averageY += bh.y;
            }
            averageY /= gc.getPlayerArray().length;
            if(averageY < 245)
            {
               gc.gameSence.y = 245 - averageY;
            }
            else if(averageY > 580)
            {
            }
            if(this.minGameSenceY < 0)
            {
               if(gc.gameSence.y > -this.minGameSenceY)
               {
                  gc.gameSence.y = -this.minGameSenceY;
               }
            }
         }
         if(this.shakeVal == 0)
         {
            if(this.isAutoCamera && stopPoint)
            {
               minLeft = Math.min(!!gc.hero1 ? gc.hero1.x : 99999,!!gc.hero2 ? gc.hero2.x : 99999);
               minLeftGlobal = gc.gameSence.localToGlobal(new Point(minLeft,0)).x;
               if(minLeftGlobal > 450)
               {
                  spd1 = !!gc.hero1 ? Math.abs(gc.hero1.speed.x) : 0;
                  spd2 = !!gc.hero2 ? Math.abs(gc.hero2.speed.x) : 0;
                  if(Math.max(spd1,spd2) + 10 <= 30)
                  {
                     gameSenceMove = Math.max(spd1,spd2) + 10;
                  }
                  else
                  {
                     gameSenceMove = 30;
                  }
                  gc.gameSence.x -= gameSenceMove;
                  bgMove = gameSenceMove * (gc.bg1.width - 940) / (gc.gameSence.width - 940);
                  gc.bg1.x -= bgMove;
               }
               else
               {
                  this.isAutoCamera = false;
               }
               if(stopPointXXX <= 1000 && stopPointXXX >= 880)
               {
                  this.isAutoCamera = false;
               }
            }
         }
      }
      
      private function isCanBackWardAll() : Boolean
      {
         if(gc.isInHost() || gc.isInWeiPkHost() || gc.curStageAndCurLevel.curStage == 24 && gc.curStageAndCurLevel.curLevel == 2)
         {
            return true;
         }
         return false;
      }
      
      public function getFarrestDistance() : Number
      {
         return this.thisStopX;
      }
      
      public function setAutoCamera() : void
      {
         this.isAutoCamera = true;
      }
      
      private function getMaxSpeedBetweenToPlayer() : Number
      {
         var maxSpeed:Number = -99;
         if(this.role1 && !this.role1.isDead())
         {
            maxSpeed = this.role1.speed.x;
         }
         if(this.role2 && !this.role2.isDead())
         {
            maxSpeed = maxSpeed > this.role2.speed.x ? maxSpeed : this.role2.speed.x;
         }
         if(gc.isInSea())
         {
            maxSpeed /= 2;
         }
         return maxSpeed;
      }
      
      private function getMinSpeedBetweenToPlayer() : Number
      {
         var minSpeed:Number = 99;
         if(this.role1 && !this.role1.isDead())
         {
            minSpeed = this.role1.speed.x;
         }
         if(this.role2 && !this.role2.isDead())
         {
            minSpeed = minSpeed < this.role2.speed.x ? minSpeed : this.role2.speed.x;
         }
         if(minSpeed > 10)
         {
            minSpeed = 10;
         }
         if(gc.isInSea())
         {
            minSpeed /= 2;
         }
         return minSpeed;
      }
      
      public function setStopStep() : void
      {
         this.stopStep = true;
      }
      
      public function getStepState() : Boolean
      {
         return this.stopStep;
      }
      
      public function getCurrentStopPoint() : StopPoint
      {
         return gc.pWorld.getStopPointArray()[0] as StopPoint;
      }
      
      public function destroy() : void
      {
         this.role1 = null;
         this.role2 = null;
         this.isAutoCamera = false;
      }
      
      public function setRole1(r:BaseHero) : void
      {
         this.role1 = r;
      }
      
      public function setRole2(r:BaseHero) : void
      {
         this.role2 = r;
      }
   }
}
