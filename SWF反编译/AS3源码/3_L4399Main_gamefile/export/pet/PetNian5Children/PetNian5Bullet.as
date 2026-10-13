package export.pet.PetNian5Children
{
   import base.BaseMonster;
   import base.BaseObject;
   import base.BasePet;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class PetNian5Bullet extends EnemyMoveBullet
   {
       
      
      private var tw:TweenMax;
      
      private var _offsetPoint:Point;
      
      private var tweenIntervalCount:int;
      
      public function PetNian5Bullet(imgMcName:String)
      {
         _offsetPoint = new Point();
         tweenIntervalCount = 12 + RandomControllor.getIns().getRandom() * 12;
         super(imgMcName);
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
      }
      
      override public function setRole(bo:BaseObject) : void
      {
         super.setRole(bo);
         if(this.sourceRole)
         {
            this.x = this.sourceRole.x + _offsetPoint.x;
            this.y = this.sourceRole.y + _offsetPoint.y;
         }
      }
      
      public function gogo() : void
      {
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         if(this.sourceRole)
         {
            if(this.x > this.sourceRole.x)
            {
               this.setSpeed(-3,3);
               this.setAddSpeed(-0.5,0.5);
            }
            else
            {
               this.setSpeed(3,3);
               this.setAddSpeed(0.5,0.5);
            }
            this.moveTarget = this.sourceRole;
         }
      }
      
      override public function step2() : void
      {
         var dis:Number = NaN;
         super.step2();
         if(this.moveTarget)
         {
            if(!this.tw)
            {
               dis = AUtils.GetDisBetweenTwoObj(this,this.moveTarget);
               if(dis <= 20)
               {
                  this.destroy();
                  if(this.moveTarget is BasePet)
                  {
                     (this.moveTarget as BasePet).cureHp((this.moveTarget as BasePet).petInfo.getSHp() * 0.5);
                  }
                  else if(this.moveTarget is BaseMonster)
                  {
                     (this.moveTarget as BaseMonster).cureHp((this.moveTarget as BaseMonster).getSHp() * 0.5);
                  }
               }
            }
         }
         else if(this.sourceRole)
         {
            if(tweenIntervalCount > 0)
            {
               tweenIntervalCount--;
               if(tweenIntervalCount == 0)
               {
                  if(tw)
                  {
                     tw.kill();
                  }
                  tw = TweenMax.to(this,1 + (RandomControllor.getIns().getRandom() - 0.5),{
                     "x":this.sourceRole.x + _offsetPoint.x,
                     "y":this.sourceRole.y + _offsetPoint.y
                  });
                  tweenIntervalCount = 12 + RandomControllor.getIns().getRandom() * 12;
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
      }
      
      public function get offsetPoint() : Point
      {
         return _offsetPoint;
      }
      
      public function set offsetPoint(value:Point) : void
      {
         _offsetPoint = value;
      }
   }
}
