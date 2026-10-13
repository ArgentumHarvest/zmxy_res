package manager
{
   import my.ANumber;
   
   public class ANumberManager
   {
      
      static var instance:ANumberManager;
       
      
      private var child:Vector.<ANumber>;
      
      public function ANumberManager()
      {
         child = new Vector.<ANumber>();
         super();
      }
      
      public static function getInstance() : ANumberManager
      {
         if(!instance)
         {
            instance = new ANumberManager();
         }
         return instance;
      }
      
      public function createANumber() : ANumber
      {
         var i:* = 0;
         var num:* = null;
         for(i = uint(0); i < child.length; )
         {
            num = child[i];
            if(!num.isUse)
            {
               return num;
            }
            i++;
         }
         var newNum:ANumber = new ANumber();
         child.push(newNum);
         return newNum;
      }
   }
}
