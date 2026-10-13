package export.bullet
{
   import base.BaseBullet;
   
   public class SpecialEffectBullet extends BaseBullet
   {
       
      
      public var followObject:ThroughWallBullet;
      
      public function SpecialEffectBullet(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         if(!this.isReadyToDestroy)
         {
            if(this.followObject)
            {
               this.x = this.followObject.x;
               this.y = this.followObject.y;
               if(this.followObject.getUserData())
               {
                  if(this.transform.matrix.a != this.followObject.getUserData().transform.matrix.a)
                  {
                     this.newAttackId();
                     AUtils.flipHorizontal(this,this.followObject.getUserData().transform.matrix.a);
                  }
               }
            }
         }
      }
      
      override public function setScale(xx:Number, yy:Number) : void
      {
         super.setScale(xx,yy);
      }
      
      public function setFollowObj(f:ThroughWallBullet) : void
      {
         this.followObject = f;
         f.setSwordEffect(this);
      }
      
      override public function destroy() : void
      {
         this.followObject = null;
         super.destroy();
      }
   }
}
