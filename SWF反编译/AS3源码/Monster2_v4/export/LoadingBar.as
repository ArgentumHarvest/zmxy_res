package export
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class LoadingBar extends MovieClip
   {
       
      
      public var bar:MovieClip;
      
      public var fileIdx:TextField;
      
      public function LoadingBar()
      {
         super();
      }
      
      public function setProcess(param1:int, param2:int) : void
      {
         this.fileIdx.text = String(param2);
         this.bar.gotoAndStop(param1);
      }
   }
}
