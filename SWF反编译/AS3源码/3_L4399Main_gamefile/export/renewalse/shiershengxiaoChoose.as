package export.renewalse
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class shiershengxiaoChoose extends Sprite
   {
       
      
      protected var renewalse:Sprite;
      
      public function shiershengxiaoChoose()
      {
         super();
         renewalse = AUtils.getNewObj("12shengxiaoChoose") as Sprite;
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16777215;
         txtformat.size = 14;
         var txt:TextField = new TextField();
         txt.embedFonts = true;
         txt.wordWrap = true;
         txt.defaultTextFormat = txtformat;
         txt.x = 370;
         txt.y = 262;
         txt.width = 168;
         txt.height = 59;
         txt.name = "12shengxiaoChooseTxt";
         renewalse.addChild(txt);
         this.addChild(renewalse);
      }
      
      public function get txt() : TextField
      {
         return renewalse.getChildByName("12shengxiaoChooseTxt") as TextField;
      }
      
      public function get okbtn() : SimpleButton
      {
         return renewalse["okbtn"];
      }
      
      public function get nobtn() : SimpleButton
      {
         return renewalse["nobtn"];
      }
      
      public function get xbtn() : SimpleButton
      {
         return renewalse["btn_x"];
      }
   }
}
