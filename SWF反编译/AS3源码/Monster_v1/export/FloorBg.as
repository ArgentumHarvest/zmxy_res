package export
{
   import flash.display.MovieClip;
   
   public class FloorBg extends MovieClip
   {
       
      
      public function FloorBg()
      {
         super();
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
