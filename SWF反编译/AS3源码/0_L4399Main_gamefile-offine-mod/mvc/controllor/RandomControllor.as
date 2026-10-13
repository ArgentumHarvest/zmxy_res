package mvc.controllor
{
   import my.Singleton;
   
   public class RandomControllor extends Singleton
   {
       
      
      public var randomIndex:int = 100;
      
      private var randomString:String = "";
      
      public function RandomControllor()
      {
         super();
      }
      
      public static function getIns() : RandomControllor
      {
         return Singleton.getIns(RandomControllor);
      }
      
      public function clearString() : void
      {
         this.randomString = "";
      }
      
      public function getRandom() : Number
      {
         return Math.random();
      }
   }
}
