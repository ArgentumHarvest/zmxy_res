package export.bullet
{
   import base.BaseBullet;
   import base.BaseObject;
   import flash.geom.Point;
   
   public class FollowBaseObjectBullet extends BaseBullet
   {
       
      
      private var initPoint:Point;
      
      private var curPoint:Point;
      
      private var initMatrixA:Number;
      
      private var curMatrixA:Number;
      
      public function FollowBaseObjectBullet(imgMcName:String)
      {
         initPoint = new Point();
         curPoint = new Point();
         super(imgMcName);
         this.setHurtCanCutDownEffect(true);
      }
      
      override public function step2() : void
      {
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         super.step2();
         if(!this.isReadyToDestroy)
         {
            if(this.sourceRole)
            {
               offsetX = this.curPoint.x - this.sourceRole.x;
               offsetY = this.curPoint.y - this.sourceRole.y;
               if(offsetX != 0)
               {
                  this.x -= offsetX;
                  this.curPoint.x = this.sourceRole.x;
               }
               if(offsetY != 0)
               {
                  this.y -= offsetY;
                  this.curPoint.y = this.sourceRole.y;
               }
               if(this.curMatrixA != this.sourceRole.transform.matrix.a)
               {
                  AUtils.flipHorizontal(this,this.sourceRole.transform.matrix.a);
                  this.curMatrixA = this.sourceRole.transform.matrix.a;
               }
            }
         }
      }
      
      override public function setScale(xx:Number, yy:Number) : void
      {
         super.setScale(xx,yy);
         if(xx > 1)
         {
            this.setScale(0.7,1);
         }
      }
      
      override public function setRole(bo:BaseObject) : void
      {
         super.setRole(bo);
         this.initPoint.x = bo.x;
         this.initPoint.y = bo.y;
         this.curPoint.x = bo.x;
         this.curPoint.y = bo.y;
         this.initMatrixA = bo.transform.matrix.a;
         this.curMatrixA = this.initMatrixA;
      }
   }
}
