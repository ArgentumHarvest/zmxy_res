package my
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class Singleton extends EventDispatcher
   {
      
      private static var _insDict:Dictionary = new Dictionary();
       
      
      public function Singleton()
      {
         super();
         var ca:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         if(_insDict[ca])
         {
            throw new Error("已实例化" + this);
         }
         _insDict[ca] = this;
      }
      
      public static function getIns(cla:Class) : *
      {
         if(_insDict[cla] == null)
         {
            _insDict[cla] = new cla();
            return _insDict[cla];
         }
         return _insDict[cla];
      }
   }
}
