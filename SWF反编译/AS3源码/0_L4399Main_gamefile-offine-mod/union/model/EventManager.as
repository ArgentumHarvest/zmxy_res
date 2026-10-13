package union.model
{
   public class EventManager
   {
      
      private static var content:Object = {};
       
      
      public function EventManager()
      {
         super();
      }
      
      public static function on(eventName:String, callBack:Function) : void
      {
         if(!content[eventName])
         {
            content[eventName] = [];
         }
         content[eventName].push(callBack);
      }
      
      public static function emit(eventName:String, data:Object = null) : void
      {
         var i:int = 0;
         var a:Array = content[eventName];
         if(a)
         {
            for(i = 0; i < a.length; )
            {
               if(data)
               {
                  a[i](data);
               }
               else
               {
                  a[i]();
               }
               i++;
            }
         }
      }
      
      public static function off(eventName:String, callBack:Function) : void
      {
         var i:int = 0;
         var a:Array = content[eventName];
         if(a)
         {
            i = a.indexOf(callBack);
            if(i >= 0)
            {
               a.splice(i,1);
            }
         }
      }
      
      public static function offSameEventName(eventName:String) : void
      {
         content[eventName] = null;
      }
   }
}
