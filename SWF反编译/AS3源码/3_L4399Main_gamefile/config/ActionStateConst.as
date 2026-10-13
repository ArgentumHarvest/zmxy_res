package config
{
   import flash.utils.Dictionary;
   
   public class ActionStateConst
   {
      
      static var instance:ActionStateConst;
       
      
      private var dict:Dictionary;
      
      public function ActionStateConst()
      {
         super();
         dict = new Dictionary();
         this.init();
      }
      
      public static function getInstence() : ActionStateConst
      {
         if(!instance)
         {
            instance = new ActionStateConst();
         }
         return instance;
      }
      
      public function getStateByAction(action:String) : uint
      {
         if(dict[action] != undefined)
         {
            return dict[action];
         }
         trace("====================未找到这个操作=============action:" + action);
         return 0;
      }
      
      public function getActionByState(state:uint) : String
      {
         for(var key in dict)
         {
            if(dict[key] == state)
            {
               return key;
            }
         }
         trace("====================未找到这个状态=============state:" + state);
         return "none";
      }
      
      public function init() : void
      {
         dict["wait"] = 1;
         dict["wait2"] = 2;
         dict["walk"] = 3;
         dict["run"] = 4;
         dict["jump1"] = 5;
         dict["jump2"] = 6;
         dict["jump3"] = 7;
         dict["hit1"] = 8;
         dict["hit2"] = 9;
         dict["hit3"] = 10;
         dict["hit4"] = 11;
         dict["hit5"] = 12;
         dict["hit6"] = 13;
         dict["hit7"] = 14;
         dict["hit8"] = 15;
         dict["hit9"] = 16;
         dict["hit10"] = 17;
         dict["hit11"] = 18;
         dict["hit12"] = 19;
         dict["hit13"] = 20;
         dict["hit14"] = 21;
         dict["hurt"] = 22;
         dict["dead"] = 23;
         dict["hit10_1"] = 24;
         dict["hit10_2"] = 25;
         dict["hit10_3"] = 26;
         dict["hit10_4"] = 27;
         dict["hit13Check"] = 28;
         dict["hit14_1"] = 29;
         dict["hit14_2"] = 30;
         dict["otherShowHit12"] = 31;
         dict["createShallow"] = 32;
         dict["hit11_1"] = 33;
         dict["hit11_2"] = 34;
         dict["hit4_1"] = 35;
         dict["hit4_2"] = 36;
         dict["hit9_1"] = 37;
         dict["hit9_2"] = 38;
         dict["Role2Hit7"] = 39;
         dict["hit11Frame2"] = 40;
         dict["Role3Hit6"] = 41;
         dict["hit7_1"] = 42;
         dict["hit7_2"] = 43;
         dict["hit8_1"] = 44;
         dict["hit8_2"] = 45;
         dict["hit12_1"] = 46;
         dict["hit12_2"] = 47;
         dict["doHit1Arrow"] = 48;
         dict["doHit2Arrow"] = 49;
         dict["doHit4Arrow"] = 50;
         dict["hit5_2"] = 51;
         dict["hit7_2"] = 52;
         dict["doHit8Arrow_2"] = 53;
         dict["hit9_2"] = 54;
         dict["doHit9Arrow_2"] = 55;
         dict["doHit10Arrow_2"] = 56;
         dict["doHit12Arrow_2"] = 57;
         dict["doHit12Arrow_3"] = 58;
         dict["hit6_2"] = 59;
         dict["hit11_2"] = 60;
      }
   }
}
