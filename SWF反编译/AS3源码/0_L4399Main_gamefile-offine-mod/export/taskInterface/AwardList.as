package export.taskInterface
{
   import config.Config;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class AwardList extends Sprite
   {
       
      
      public var txtname:TextField;
      
      private var img;
      
      public function AwardList()
      {
         super();
      }
      
      public function addImage(bname:String) : void
      {
         try
         {
            img = AUtils.getImageObj(bname);
            img.name = bname;
            img.x = 3.5;
            img.y = 3.5;
            this.addChild(img);
         }
         catch(e:*)
         {
            Config.getInstance().ts.setTxt("addImage====bname:" + bname);
            Config.getInstance().stage.addChild(Config.getInstance().ts);
         }
      }
      
      public function removeImage() : void
      {
         if(img && contains(img))
         {
            this.removeChild(img);
            this.txtname.text = "";
         }
      }
   }
}
