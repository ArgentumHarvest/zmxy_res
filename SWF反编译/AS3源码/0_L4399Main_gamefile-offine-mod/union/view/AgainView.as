package union.view
{
   import union.model.EventManager;
   
   public class AgainView extends BasicView
   {
       
      
      public var callBack:Function;
      
      public var message:String = "";
      
      public function AgainView(name:String)
      {
         this.assetName = name;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("againPanel");
         this.addBtnEvent("btnSure","btnCancel");
         setMessage(message);
      }
      
      override protected function onBtnName(name:String) : void
      {
         if(name == "btnSure")
         {
            EventManager.emit("CLICK_SURE");
            callBack && callBack();
         }
         this.removeFromParent(true);
      }
      
      private function setMessage(value:String) : void
      {
         text("txtMessage").text = value;
      }
   }
}
