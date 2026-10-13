package mvc.net.sm
{
   import com.superkaka.mvc.Control.net.SMessage;
   
   public class LoadingComplete extends SMessage
   {
       
      
      public function LoadingComplete()
      {
         super("RMGame.LoadingComplete");
      }
      
      override protected function writeBody() : void
      {
      }
   }
}
