package my
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class SavedBuffInfoSprite extends Sprite
   {
       
      
      private var tf:TextField;
      
      private var ttf:TextFormat;
      
      public function SavedBuffInfoSprite(ssb:SingleSavedBuff)
      {
         super();
         this.ttf = new TextFormat();
         this.ttf.size = 18;
         this.tf = new TextField();
         this.tf.defaultTextFormat = this.ttf;
         if(ssb.type == SingleSavedBuff.BUFF_DROPRATE_ADD)
         {
            this.tf.text = "增加掉宝率" + ssb.value + "%";
         }
         else if(ssb.type == SingleSavedBuff.BUFF_EXP_ADD)
         {
            this.tf.text = "双倍经验";
         }
         else
         {
            this.tf.text = "...";
         }
         this.tf.height = this.tf.textHeight + 10;
         this.tf.width = this.tf.textWidth + 20;
         this.tf.selectable = false;
         this.addChild(this.tf);
      }
   }
}
