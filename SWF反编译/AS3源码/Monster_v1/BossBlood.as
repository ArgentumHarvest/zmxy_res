package
{
   import flash.display.MovieClip;
   
   public dynamic class BossBlood extends MovieClip
   {
       
      
      public var namemc:MovieClip;
      
      public function BossBlood()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
