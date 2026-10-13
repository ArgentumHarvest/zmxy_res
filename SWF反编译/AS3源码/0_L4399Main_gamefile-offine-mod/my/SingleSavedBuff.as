package my
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class SingleSavedBuff extends Sprite
   {
      
      public static var BUFF_DROPRATE_ADD:uint = 0;
      
      public static var BUFF_EXP_ADD:uint = 1;
      
      public static var BUFF_CRIT_ADD:uint = 2;
      
      public static var BUFF_ATK_ADD:uint = 3;
      
      public static var BUFF_HP_CURE:uint = 4;
      
      public static var BUFF_HP_ADD_28_BUFF:uint = 5;
      
      public static var BUFF_DEF_ADD_28_BUFF:uint = 6;
      
      public static var BUFF_ALLIANCE_ATK:uint = 7;
      
      public static var BUFF_MID_BUFF:uint = 8;
       
      
      private var _time:int;
      
      private var imgBm:Bitmap;
      
      private var timeTf:TextField;
      
      private var timeTtf:TextFormat;
      
      private var gc:Config;
      
      private var anti:Antiwear;
      
      public var isDestroyed:Boolean = false;
      
      public function SingleSavedBuff(type:uint, value:int, time:int, idx:uint)
      {
         var imgType:int = 0;
         anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.anti._type = type;
         this.anti._value = value;
         this._time = time;
         this.anti._idx = idx;
         try
         {
            imgType = type;
            this.imgBm = AUtils.getImageObj("SAVEBUFF_" + imgType) as Bitmap;
            this.addChild(this.imgBm);
            this.timeTf = new TextField();
            this.timeTtf = new TextFormat();
            this.timeTtf.font = "FZCuYuan-M03S";
            this.timeTtf.size = 18;
            this.timeTf.width = 120;
            this.timeTf.height = 30;
            this.timeTf.x = 40;
            this.timeTf.embedFonts = true;
            this.timeTf.defaultTextFormat = this.timeTtf;
            this.timeTf.selectable = false;
            this.addChild(this.timeTf);
         }
         catch(e:*)
         {
            throw new Error("全局buff图标有误-->类型：" + type);
         }
      }
      
      public function step() : void
      {
         this.y = 30 * this.anti._idx;
         this.display();
         if(this._time > 0)
         {
            this._time--;
            if(this._time == 0)
            {
               this.destroy();
            }
         }
      }
      
      private function display() : void
      {
         var second:* = 0;
         var hour:* = 0;
         var min:* = 0;
         var sec:* = 0;
         if(this.timeTf)
         {
            second = uint(this.time / gc.frameClips);
            hour = uint(second / 3600);
            min = uint((second - hour * 3600) / 60);
            sec = uint(second - hour * 3600 - min * 60);
            this.timeTf.text = (hour > 0 ? hour + ":" : "") + min + ":" + sec;
         }
         if(this.type == SingleSavedBuff.BUFF_DROPRATE_ADD)
         {
            this.timeTf.text += "(" + this.anti._value + "%)";
         }
         else if(this.type == SingleSavedBuff.BUFF_EXP_ADD)
         {
            this.timeTf.text += "(" + this.anti._value + "倍)";
         }
         else if(this.type == SingleSavedBuff.BUFF_CRIT_ADD)
         {
            this.timeTf.text += "(" + this.anti._value + "%)";
         }
         else if(this.type == SingleSavedBuff.BUFF_ATK_ADD)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         else if(this.type == SingleSavedBuff.BUFF_HP_CURE)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         else if(this.type == SingleSavedBuff.BUFF_HP_ADD_28_BUFF)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         else if(this.type == SingleSavedBuff.BUFF_DEF_ADD_28_BUFF)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         else if(this.type == SingleSavedBuff.BUFF_ALLIANCE_ATK)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         else if(this.type == SingleSavedBuff.BUFF_MID_BUFF)
         {
            this.timeTf.text += "(" + this.anti._value + "点)";
         }
         this.timeTf.width = this.timeTf.textWidth + 10;
      }
      
      public function destroy() : void
      {
         this.isDestroyed = true;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get idx() : uint
      {
         return this.anti._idx;
      }
      
      public function set idx(value:uint) : void
      {
         this.anti._idx = value;
      }
      
      public function get time() : int
      {
         return this._time;
      }
      
      public function set time(value:int) : void
      {
         this._time = value;
      }
      
      public function get value() : int
      {
         return this.anti._value;
      }
      
      public function set value(value:int) : void
      {
         this.anti._value = value;
      }
      
      public function get type() : uint
      {
         return this.anti._type;
      }
      
      public function set type(value:uint) : void
      {
         this.anti._type = value;
      }
   }
}
