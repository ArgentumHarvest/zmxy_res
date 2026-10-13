package export.bullet
{
   import base.BaseObject;
   
   public class NetBullet extends SpecialEffectBullet
   {
       
      
      public var controlArray:Array;
      
      private var leftPointX:int = 0;
      
      private var rightPointX:int = 0;
      
      private var topPointY:int = 0;
      
      public function NetBullet(imgMcName:String)
      {
         controlArray = [];
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         if(this.getImgMc().currentFrame == 1)
         {
            this.leftPointX = this.x - this.getImgMc().width / 2;
            this.rightPointX = this.x + this.getImgMc().width / 2;
            this.topPointY = this.y - this.getImgMc().height / 2;
         }
         for each(var bo in gc.getPlayerAndPetArray())
         {
            if(this.controlArray.indexOf(bo) == -1)
            {
               if(bo.x > leftPointX && bo.x < rightPointX && bo.y > topPointY)
               {
                  this.controlArray.push(bo);
               }
            }
         }
         for each(bo in this.controlArray)
         {
            if(bo.x < leftPointX)
            {
               bo.x = leftPointX;
            }
            else if(bo.x > rightPointX)
            {
               bo.x = rightPointX;
            }
            if(bo.y < topPointY)
            {
               bo.y = topPointY;
            }
         }
         super.step2();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.controlArray.length = 0;
      }
   }
}
