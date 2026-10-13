package union
{
   import flash.display.MovieClip;
   import flash.text.Font;
   import flash.utils.setTimeout;
   import union.model.EventManager;
   import union.model.LoadManager;
   import union.model.TextManager;
   import union.model.Unify;
   import union.utils.UnionConfig;
   import union.view.BasicView;
   import union.view.UnionCreate;
   import union.view.UnionList;
   import union.view.UnionMy;
   
   public class UnionMain extends BasicView
   {
       
      
      private var viewers:Array;
      
      private var progress:MovieClip;
      
      private var myUnion:UnionMy;
      
      private var createUnion:UnionCreate;
      
      private var listUnion:UnionList;
      
      private var type:int = 0;
      
      public function UnionMain()
      {
         viewers = [];
         super();
         progress = LoadManager.getProgress();
         this.addChild(progress);
         assetName = "Union.swf";
         LoadManager.load(assetName,onComplete,updateProgress);
         this.addEvent();
         this.setData(1);
         UnionConfig.isSave = false;
      }
      
      protected function addEvent() : void
      {
         Unify.log("增加主类的事件");
         EventManager.on("CLOSE_MAIN",onCloseMain);
         EventManager.on("UNION_CREATE",onUnionCreate);
         EventManager.on("UNION_EXIT",onCloseMain);
      }
      
      protected function onUnionCreate() : void
      {
         Unify.log("createUnion");
         if(createUnion)
         {
            createUnion.removeFromParent(true);
         }
         this.setData(2);
         this.initView();
      }
      
      public function setData(type:int = 0) : void
      {
         this.type = type;
      }
      
      protected function initView() : void
      {
         switch(int(type))
         {
            case 0:
               createUnion = new UnionCreate(assetName);
               this.addChild(createUnion);
               break;
            case 1:
               listUnion = new UnionList(assetName);
               this.addChild(listUnion);
               break;
            case 2:
               myUnion = new UnionMy(assetName);
               this.addChild(myUnion);
               break;
            case 3:
               listUnion = new UnionList(assetName);
               this.addChild(listUnion);
         }
      }
      
      protected function updateProgress(data:Object) : void
      {
         progress.sprite.rotation += 10;
         progress.text.text = Math.round(data.curr / data.total * 100);
         trace("load..." + progress.text.text);
      }
      
      protected function onComplete() : void
      {
         this.removeChild(progress);
         setTimeout(initView,100);
         this.setFont();
      }
      
      private function setFont() : void
      {
         var fontLinkName:String = TextManager.fontName;
         var FontClass:Class = this.getClass(fontLinkName);
         var font:Font = new FontClass();
         TextManager.setFont(FontClass,fontLinkName,font.fontName);
      }
      
      protected function onCloseMain() : void
      {
         this.dispose();
      }
      
      protected function onUnionCheck(data:Object) : void
      {
         var hasUnion:Boolean = data.unionInfo;
         if(!hasUnion)
         {
         }
      }
      
      override public function dispose() : void
      {
         EventManager.off("CLOSE_MAIN",onCloseMain);
         EventManager.off("UNION_CREATE",onUnionCreate);
         EventManager.off("UNION_EXIT",onCloseMain);
         if(myUnion)
         {
            myUnion.removeFromParent(true);
            myUnion = null;
         }
         if(createUnion)
         {
            createUnion.removeFromParent(true);
            createUnion = null;
         }
         if(listUnion)
         {
            listUnion.removeFromParent(true);
            listUnion = null;
         }
         UnionConfig.saveData();
         super.dispose();
         this.removeFromParent();
      }
   }
}
