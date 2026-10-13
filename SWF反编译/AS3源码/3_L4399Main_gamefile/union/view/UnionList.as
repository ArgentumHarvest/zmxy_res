package union.view
{
   import union.model.EventManager;
   import union.model.Unify;
   import union.model.UnionManager;
   
   public class UnionList extends BasicView
   {
       
      
      public function UnionList(name:String)
      {
         this.assetName = name;
         this.isCloseMain = true;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("unionListPanel");
         this.addBtnEvent("btnClose");
         EventManager.on("UNION_LIST",onUpdate);
         this.initListItem();
         this.sendPage();
      }
      
      override public function initListItem() : void
      {
         var i:int = 0;
         var item:* = null;
         super.initListItem();
         for(i = 1; i <= onePageNum; )
         {
            item = new Item(mainPanel["item" + i]);
            item.visible = false;
            items.push(item);
            i++;
         }
      }
      
      override protected function sendPage() : void
      {
         super.sendPage();
         UnionManager.getIns().getUnionList(pageCurr);
      }
      
      protected function onUpdate(data:Object) : void
      {
         var i:int = 0;
         var arr:Array = data.unionList || [];
         pageTotal = Math.ceil(data.rowCount / onePageNum);
         pageTotal = pageTotal < 1 ? 1 : pageTotal;
         Unify.arraySortByParam(arr,"experience",true);
         for(i = 0; i < arr.length; )
         {
            arr[i]["rank"] = (pageCurr - 1) * onePageNum + (i + 1);
            i++;
         }
         this.updatePage(arr);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         EventManager.off("UNION_LIST",onUpdate);
      }
   }
}

import flash.display.MovieClip;
import union.model.Unify;
import union.model.UnionManager;
import union.view.BasicView;

class Item extends BasicView
{
    
   
   public var unionId:int;
   
   function Item(mainPanel:MovieClip)
   {
      super();
      this.mainPanel = mainPanel;
      this.addBtnEvent("btnSqjr");
   }
   
   public function setData(data:Object) : void
   {
      unionId = data.unionId;
      Unify.log(data);
      text("txtRank").text = data.rank;
      text("txtTeam").text = Unify.getTeam(data.extra);
      text("txtUnionName").text = data.title;
      text("txtLevel").text = data.level;
      text("txtHostName").text = data.username;
      text("txtExp").text = data.experience;
      text("txtCount").text = Unify.showUnionNum(data.count,data.level);
      text("txtCount").width = 120;
   }
   
   override protected function onBtnName(name:String) : void
   {
      UnionManager.getIns().applyUnion(unionId);
   }
   
   override public function set visible(val:Boolean) : void
   {
      this.mainPanel.visible = val;
   }
   
   override public function get visible() : Boolean
   {
      return this.mainPanel.visible;
   }
}
