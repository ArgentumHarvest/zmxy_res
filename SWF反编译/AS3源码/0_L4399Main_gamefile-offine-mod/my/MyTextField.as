package my
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MyTextField extends TextField
   {
      
      public static const FZCYJT:String = "FZCuYuan-M03S";
       
      
      private var ttf:TextFormat;
      
      public function MyTextField(color:uint, fontType:String, fontSize:uint)
      {
         ttf = new TextFormat();
         super();
         var txtname:TextField = new TextField();
         this.embedFonts = true;
         ttf.font = fontType;
         ttf.color = color;
         ttf.size = fontSize;
         this.defaultTextFormat = this.ttf;
         this.selectable = false;
      }
      
      public function setText(text:String) : void
      {
         this.text = text;
         this.width = this.textWidth + 10;
      }
      
      public function setFontSize(fontSize:uint) : void
      {
         this.ttf.size = fontSize;
         this.setTextFormat(this.ttf);
      }
   }
}
