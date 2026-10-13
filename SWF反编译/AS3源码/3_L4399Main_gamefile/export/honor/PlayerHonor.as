package export.honor
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class PlayerHonor
   {
      
      static var tf:TextField = new TextField();
      
      static var ttf:TextFormat = new TextFormat();
       
      
      public function PlayerHonor()
      {
         super();
      }
      
      public static function getHonorBitmap(hd:AllianceData) : Bitmap
      {
         ttf.size = 16;
         ttf.bold = true;
         tf.defaultTextFormat = ttf;
         if(hd.jobName != "")
         {
            tf.htmlText = "<font color=\'#FFFF00\'>" + hd.honorName + "</font><font color=\'#00ff00\'>（" + hd.jobName + "）</font>";
         }
         else
         {
            tf.htmlText = "<font color=\'#FFFF00\'>" + hd.honorName + "</font>";
         }
         tf.width = tf.textWidth + 10;
         tf.filters = [new GlowFilter(0,1,8,8,5)];
         var bmd:BitmapData = new BitmapData(tf.textWidth + 10,tf.textHeight + 5,true,16777215);
         bmd.draw(tf);
         return new Bitmap(bmd);
      }
   }
}
