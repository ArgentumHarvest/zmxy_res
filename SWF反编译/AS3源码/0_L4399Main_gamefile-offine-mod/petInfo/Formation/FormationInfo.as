package petInfo.Formation
{
   public class FormationInfo
   {
       
      
      private var data:Array;
      
      private var _jie:uint = 0;
      
      private var _ji:uint = 0;
      
      public function FormationInfo()
      {
         data = [];
         super();
      }
      
      public function addObject(obj:Object) : void
      {
         for each(var o in this.data)
         {
            if(o.type == obj.type)
            {
               o.value += obj.value;
               return;
            }
         }
         var clone:Object = AUtils.clone(obj) as Object;
         this.data.push(clone);
      }
      
      public function getInfo() : String
      {
         var returnString:String = "";
         returnString += this.jie + "阶" + this.ji + "级";
         returnString += "\n";
         for each(var o in this.data)
         {
            if(o.value > 1)
            {
               returnString += o.info + " + " + o.value;
            }
            else
            {
               returnString += o.info + " + " + Math.round(o.value * 100) + "%";
            }
            returnString += "\n";
         }
         return returnString;
      }
      
      public function get jie() : uint
      {
         return _jie;
      }
      
      public function set jie(value:uint) : void
      {
         _jie = value;
      }
      
      public function get ji() : uint
      {
         return _ji;
      }
      
      public function set ji(value:uint) : void
      {
         _ji = value;
      }
   }
}
