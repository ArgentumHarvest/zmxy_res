package export.monster.Monster150Children
{
   import base.BaseLevelListenering;
   import base.BaseObject;
   import export.bullet.EnemyMoveBullet;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.ILightForBlackBG;
   
   public class YinghuochongBullet extends EnemyMoveBullet implements ILightForBlackBG
   {
       
      
      private var isFirstHit:Boolean = false;
      
      private var _raidus:int = 10;
      
      private var _posX:Number;
      
      private var _posY:Number;
      
      private var offsetPoint:Point;
      
      public function YinghuochongBullet(imgMcName:String)
      {
         offsetPoint = new Point(0,0);
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         var bl:* = null;
         if(this.isFirstHit)
         {
            this.setDistance(500);
            bl = gc.pWorld.getBaseLevelListener();
            if(!bl.isInBlack())
            {
               this.destroy();
               return;
            }
         }
         super.step2();
         if(this.followDisplayObject)
         {
            this.x += offsetPoint.x;
            this.y += offsetPoint.y;
         }
      }
      
      public function tieToObj(bo:BaseObject) : void
      {
         if(!this.isFirstHit)
         {
            this.setFollowDisplayObj(bo);
            offsetPoint.x = (RandomControllor.getIns().getRandom() - 0.5) * 40;
            offsetPoint.y = (RandomControllor.getIns().getRandom() - 0.5) * 70;
            this.setMoveTarget(null);
            this.isFirstHit = true;
         }
      }
      
      override public function destroy() : void
      {
         var bl:BaseLevelListenering = gc.pWorld.getBaseLevelListener();
         bl.removeLightForBlackBG(this);
         super.destroy();
      }
      
      public function get raidus() : int
      {
         return _raidus;
      }
      
      public function set raidus(value:int) : void
      {
         _raidus = value;
      }
      
      public function get posX() : Number
      {
         return this.x;
      }
      
      public function set posX(value:Number) : void
      {
         _posX = value;
      }
      
      public function get posY() : Number
      {
         return this.y;
      }
      
      public function set posY(value:Number) : void
      {
         _posY = value;
      }
   }
}
