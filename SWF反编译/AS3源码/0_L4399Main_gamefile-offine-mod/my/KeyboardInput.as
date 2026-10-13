package my
{
   import flash.utils.Dictionary;
   
   public class KeyboardInput extends Singleton
   {
      
      public static const KEYDOWN:uint = 0;
      
      public static const KEYUP:uint = 1;
      
      public static const JUST_KEYDOWN:uint = 2;
      
      public static const JUST_KEYUP:uint = 3;
      
      public static const DOUBLE_CLICK:uint = 4;
       
      
      private var keyDict:Dictionary;
      
      public function KeyboardInput()
      {
         super();
         this.keyDict = new Dictionary();
      }
      
      public static function getIns() : KeyboardInput
      {
         return Singleton.getIns(KeyboardInput);
      }
      
      public function step() : void
      {
         for each(var kv in this.keyDict)
         {
            if(kv.isJustKeyUp)
            {
               kv.isJustKeyUp = false;
            }
            if(kv.isJustKeyDown)
            {
               kv.isJustKeyDown = false;
            }
            if(kv.isDoubleClick)
            {
               kv.isDoubleClick = false;
            }
            if(kv.isKeyUp)
            {
               kv.time++;
            }
         }
      }
      
      public function keyDown(keycode:uint) : void
      {
         var kv:* = null;
         if(!this.keyDict[keycode])
         {
            kv = new KeyVo();
            kv.keyCode = keycode;
            this.keyDict[keycode] = kv;
         }
         else
         {
            kv = this.keyDict[keycode];
         }
         if(!kv.isKeyDown)
         {
            kv.isDoubleClick = false;
            if(kv.isKeyUp)
            {
               if(kv.time <= 12)
               {
                  kv.isDoubleClick = true;
               }
            }
            kv.time = 1;
            kv.isKeyDown = true;
            kv.isJustKeyDown = true;
            kv.isJustKeyUp = false;
            kv.isKeyUp = false;
         }
         else
         {
            kv.time++;
            kv.isKeyDown = true;
            kv.isJustKeyDown = false;
            kv.isJustKeyUp = false;
            kv.isDoubleClick = false;
            kv.isKeyUp = false;
         }
      }
      
      public function keyUp(keycode:uint) : void
      {
         var kv:KeyVo = this.keyDict[keycode];
         if(kv)
         {
            kv.time = 1;
            kv.isJustKeyUp = true;
            kv.isKeyDown = false;
            kv.isJustKeyDown = false;
            kv.isDoubleClick = false;
            kv.isKeyUp = true;
         }
      }
      
      public function isKeyDown(keycode:uint) : Boolean
      {
         var kv:KeyVo = this.keyDict[keycode];
         return kv && kv.isKeyDown;
      }
      
      public function isJustKeyDown(keycode:uint) : Boolean
      {
         var kv:KeyVo = this.keyDict[keycode];
         return kv && kv.isJustKeyDown;
      }
      
      public function isJustKeyUp(keycode:uint) : Boolean
      {
         var kv:KeyVo = this.keyDict[keycode];
         return kv && kv.isJustKeyUp;
      }
      
      public function isKeyUp(keycode:uint) : Boolean
      {
         var kv:KeyVo = this.keyDict[keycode];
         return !kv || kv && kv.isKeyUp;
      }
      
      public function isDoubleClick(keycode:uint) : Boolean
      {
         var kv:KeyVo = this.keyDict[keycode];
         return kv && kv.isDoubleClick;
      }
   }
}
