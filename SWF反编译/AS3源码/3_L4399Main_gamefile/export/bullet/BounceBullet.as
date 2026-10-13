package export.bullet
{
   import base.BaseBullet;
   import base.Wall;
   import flash.geom.Point;
   import my.HitTest;
   
   public class BounceBullet extends BaseBullet
   {
       
      
      private var needToMovePoint:Point;
      
      private var divideSpeed:Point;
      
      private var simulateCount:int;
      
      private var count:int = 0;
      
      private var nextVector:Point;
      
      private const simulatePerFrame:int = 10;
      
      public function BounceBullet(imgMcName:String, spd:Point)
      {
         super(imgMcName);
         this.speed = spd;
      }
      
      override protected function step() : void
      {
         super.step();
         this.divideSpeed = new Point(this.speed.x / 10,this.speed.y / 10);
         this.simulateCount = 0;
         this.checkColipse();
         count++;
      }
      
      public function setSpeedValue(xx:int, yy:int) : void
      {
         this.speed.x = xx;
         this.speed.y = yy;
      }
      
      private function checkColipse() : void
      {
         var i:int = 0;
         var wall:* = null;
         if(!this.imgMc)
         {
            return;
         }
         var wallArray:Array = gc.pWorld.getWallArray();
         for(i = 0; i < wallArray.length; )
         {
            wall = wallArray[i];
            if(!HitTest.complexHitTestObject(wall,this.imgMc))
            {
               wall.x += wall.speedX;
               wall.y += wall.speedY;
               this.x += this.speed.x;
               this.y += this.speed.y;
               if(HitTest.complexHitTestObject(wall,this.imgMc))
               {
                  wall.x -= wall.speedX;
                  wall.y -= wall.speedY;
                  this.x -= this.speed.x;
                  this.y -= this.speed.y;
                  this.nextVector = this.getNextSimulateModuleVector(wall);
                  this.move(this.nextVector);
                  this.divideSpeed = this.nextVector;
                  if(this.simulateCount < 9)
                  {
                     this.simulateCount++;
                     this.checkColipse();
                  }
                  else
                  {
                     this.speed = new Point(this.divideSpeed.x * 10,this.divideSpeed.y * 10);
                  }
               }
               else
               {
                  wall.x -= wall.speedX;
                  wall.y -= wall.speedY;
                  this.x -= this.speed.x;
                  this.y -= this.speed.y;
                  if(this.simulateCount != 0)
                  {
                     if(this.simulateCount < 9)
                     {
                        this.move(this.divideSpeed);
                        this.simulateCount++;
                        this.checkColipse();
                     }
                     else
                     {
                        this.speed = new Point(this.divideSpeed.x * 10,this.divideSpeed.y * 10);
                     }
                  }
               }
            }
            else
            {
               this.nextVector = this.getNextSimulateModuleVector(wall);
               this.move(this.nextVector);
               this.divideSpeed = this.nextVector;
               if(this.simulateCount < 9)
               {
                  this.simulateCount++;
                  this.checkColipse();
               }
               else
               {
                  this.speed = new Point(this.divideSpeed.x * 10,this.divideSpeed.y * 10);
               }
            }
            i++;
         }
         if(this.simulateCount == 0)
         {
            this.move(this.speed);
         }
      }
      
      private function getNextSimulateModuleVector(wall:Wall) : Point
      {
         var mirrorVector:Point = wall.getMirrorVector();
         var selfVector:Point = new Point(this.divideSpeed.x,this.divideSpeed.y);
         var M:Number = Math.sqrt(mirrorVector.x * mirrorVector.x + mirrorVector.y * mirrorVector.y);
         var D:Number = -mirrorVector.y * this.speed.x / M + mirrorVector.x * this.speed.y / M;
         var speed:Number = this.getSpeedValue();
         var nextSpeedX:Number = this.speed.x + 2 * mirrorVector.y * D / M;
         var nextSpeedY:Number = this.speed.y - 2 * mirrorVector.x * D / M;
         var nextSpeed:Number = Math.sqrt(nextSpeedX * nextSpeedX + nextSpeedY * nextSpeedY);
         nextSpeedX = nextSpeedX * speed / nextSpeed;
         nextSpeedY = nextSpeedY * speed / nextSpeed;
         return new Point(nextSpeedX,nextSpeedY);
      }
      
      private function getSpeedValue() : Number
      {
         return Math.sqrt(this.divideSpeed.x * this.divideSpeed.x + this.divideSpeed.y * this.divideSpeed.y);
      }
      
      private function move(nextVector:Point) : void
      {
         this.x += nextVector.x;
         this.y += nextVector.y;
      }
   }
}
