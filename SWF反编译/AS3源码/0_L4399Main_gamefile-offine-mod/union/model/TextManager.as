package union.model
{
   import flash.filters.GlowFilter;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class TextManager
   {
      
      public static var fontName:String = "Font1";
      
      public static var fonts:Dictionary = new Dictionary();
       
      
      public function TextManager()
      {
         super();
      }
      
      public static function basicValue(str:String) : String
      {
         return "<font color=\'##5F1E05\'>" + str + "</font>";
      }
      
      public static function addValue(str:String) : String
      {
         return "<font color=\'#FF3300\'>" + str + "</font>";
      }
      
      public static function white(str:String) : String
      {
         return "<font color=\'#ffffff\'>" + str + "</font>";
      }
      
      public static function red(str:String) : String
      {
         return "<font color=\'#ff0000\'>" + str + "</font>";
      }
      
      public static function green(str:String) : String
      {
         return "<font color=\'#00ff00\'>" + str + "</font>";
      }
      
      public static function bule(str:String) : String
      {
         return "<font color=\'#000ff\'>" + str + "</font>";
      }
      
      public static function yellow(str:String) : String
      {
         return "<font color=\'#ffff00\'>" + str + "</font>";
      }
      
      public static function line(str:String, size:Number = 0) : String
      {
         return "<textformat leading=\'" + size + "\'>" + str + "</textformat>";
      }
      
      public static function size(str:String, size:int = 10) : String
      {
         return "<font size=\'" + size + "\'>" + str + "</font>";
      }
      
      public static function setColor(str:String, color:String) : String
      {
         return "<font color=\'" + color + "\'>" + str + "</font>";
      }
      
      public static function align(str:String, param:Object = "center") : String
      {
         return "<p align=\'" + param + "\'>" + str + "</p>";
      }
      
      public static function createInputTextField(x:int, y:int, w:int, h:int, auto:String = "none", size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0, isUseFont:Boolean = true) : TextField
      {
         var text:TextField = createTextField(x,y,w,h,auto,size,color,isGlowFilter,glowColor,4,isUseFont);
         text.selectable = true;
         text.mouseEnabled = true;
         text.type = "input";
         return text;
      }
      
      public static function createInputTextMultiline(x:int, y:int, w:int, h:int, size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0) : TextField
      {
         var text:TextField = createInputTextField(x,y,w,h,"none",size,color,isGlowFilter,glowColor);
         text.wordWrap = true;
         return text;
      }
      
      public static function setFont(fontClass:Class, fontLinkName:String, fontName:String) : void
      {
         Font.registerFont(fontClass);
         fonts[fontLinkName] = fontName;
      }
      
      public static function getFontName(fontLinkName:String) : String
      {
         return fonts[fontLinkName];
      }
      
      public static function createTextField(x:Number, y:Number, w:int, h:int, auto:String = "center", size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0, leading:int = 4, isUseFont:Boolean = true) : TextField
      {
         var filer:* = null;
         var _textField:TextField = new TextField();
         _textField.selectable = false;
         _textField.mouseEnabled = false;
         _textField.autoSize = auto;
         _textField.x = x;
         _textField.y = y;
         _textField.width = w;
         _textField.height = h;
         var tf:TextFormat = new TextFormat();
         if(isUseFont && TextManager.fonts[fontName])
         {
            _textField.embedFonts = true;
            tf.font = TextManager.fonts[fontName];
         }
         tf.letterSpacing = 0.5;
         tf.leading = leading;
         tf.size = size;
         tf.color = color;
         _textField.defaultTextFormat = tf;
         if(isGlowFilter)
         {
            filer = new GlowFilter(glowColor,1,3,3,4);
            _textField.filters = [filer];
         }
         if(size > 50)
         {
            throw new Error(size + "号字体太大了");
         }
         return _textField;
      }
      
      public static function createTextMultiline(x:int, y:int, w:int, h:int, size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0, leading:int = 4) : TextField
      {
         var _textField:TextField = createTextField(x,y,w,h,"none",size,color,isGlowFilter,glowColor,leading);
         _textField.autoSize = "none";
         _textField.multiline = true;
         _textField.wordWrap = true;
         return _textField;
      }
      
      public static function createTextFieldBossName(x:int, y:int, w:int, h:int, auto:String = "center", size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0, leading:int = 4) : TextField
      {
         var _textField:TextField = createTextField(x,y,w,h,auto,size,color,isGlowFilter,glowColor,leading);
         var tf:TextFormat = new TextFormat();
         _textField.embedFonts = true;
         tf.font = "FZPangWa-M18S";
         tf.letterSpacing = 0.5;
         tf.leading = leading;
         tf.size = size;
         tf.color = color;
         _textField.defaultTextFormat = tf;
         return _textField;
      }
      
      public static function createTextFieldByFontName(x:int, y:int, w:int, h:int, auto:String = "center", size:int = 14, color:uint = 6233605, isGlowFilter:Boolean = false, glowColor:uint = 0, leading:int = 4, fontName:String = "FZY4JW--GB1-0") : TextField
      {
         var _textField:TextField = createTextField(x,y,w,h,auto,size,color,isGlowFilter,glowColor,leading);
         var tf:TextFormat = new TextFormat();
         _textField.embedFonts = true;
         tf.font = fontName;
         tf.letterSpacing = 0.5;
         tf.leading = leading;
         tf.size = size;
         tf.color = color;
         _textField.defaultTextFormat = tf;
         return _textField;
      }
   }
}
