package
{
   import base.BaseBullet;
   import flash.display.MovieClip;
   
   public dynamic class Boss2Bullet1 extends MovieClip
   {
       
      
      public function Boss2Bullet1()
      {
         super();
         addFrameScript(38,this.frame39,49,this.frame50);
      }
      
      function frame39() : *
      {
         BaseBullet(this.parent).newAttackId();
      }
      
      function frame50() : *
      {
         if(this.parent)
         {
            BaseBullet(this.parent).destroy();
         }
         stop();
      }
   }
}
