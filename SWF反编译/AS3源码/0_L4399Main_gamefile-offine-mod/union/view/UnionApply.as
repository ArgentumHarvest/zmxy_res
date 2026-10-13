package union.view
{
   import union.model.EventManager;
   import union.model.Unify;
   import union.model.UnionManager;
   
   public class UnionApply extends BasicView
   {
       
      
      public function UnionApply(name:String)
      {
         this.assetName = name;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("applyPanel");
         EventManager.on("UNION_APPLY_LIST",onUpdate);
         EventManager.on("UNION_APPLY_UPDATE",sendPage);
         this.initListItem();
         this.sendPage();
         this.hide("btnQbjj");
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
         UnionManager.getIns().getApplyList(pageCurr);
      }
      
      protected function onUpdate(data:Object) : void
      {
         var i:int = 0;
         var arr:Array = data.applyList || [];
         pageTotal = Math.ceil(data.rowCount / onePageNum);
         pageTotal = pageTotal < 1 ? 1 : pageTotal;
         Unify.arraySortByParam(arr,"experience");
         for(i = 0; i < arr.length; )
         {
            arr[i]["rank"] = pageCurr - 1 + i + 1;
            i++;
         }
         this.updatePage(arr);
      }
      
      override public function dispose() : void
      {
         EventManager.off("UNION_APPLY_LIST",onUpdate);
         EventManager.off("UNION_APPLY_UPDATE",onUpdate);
      }
   }
}

import flash.display.MovieClip;
import union.model.Unify;
import union.model.UnionManager;
import union.model.vo.MemberVo;
import union.utils.UnionConfig;
import union.view.BasicView;

class Item extends BasicView
{
    
   
   public var vo:MemberVo;
   
   function Item(mainPanel:MovieClip)
   {
      super();
      this.mainPanel = mainPanel;
      this.addBtnEvent("btnTg","btnJj");
   }
   
   public function setData(data:Object) : void
   {
      vo = new MemberVo();
      vo.updateFromObject(data);
      Unify.log(vo);
      text("txtName").text = vo.name;
      text("txtFightPower").text = vo.fightPower + "";
      if(!UnionManager.getIns().unionInfo.isLeader)
      {
         this.hide("btnTg","btnJj");
      }
      if(UnionManager.getIns().unionInfo.memberVo.roleId == UnionConfig.ZW_FMZ)
      {
         this.show("btnTg","btnJj");
      }
   }
   
   override protected function onBtnName(name:String) : void
   {
      var type:int = name == "btnTg" ? 1 : 0;
      UnionManager.getIns().auditMember(vo.uId,vo.index,type);
      if(type == 1)
      {
         UnionManager.getIns().pushMember(vo);
      }
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
