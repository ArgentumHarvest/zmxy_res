package export
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class ComeBackAlert extends MovieClip
   {
       
      
      public var userName:TextField;
      
      private var count:int = 0;
      
      public function ComeBackAlert()
      {
         super();
      }
      
      public function setUsername(param1:*) : void
      {
         this.userName.text = param1;
      }
   }
}
