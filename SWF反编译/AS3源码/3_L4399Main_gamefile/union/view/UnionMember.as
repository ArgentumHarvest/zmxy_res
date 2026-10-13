package union.view
{
   import union.model.EventManager;
   import union.model.Unify;
   import union.model.UnionManager;
   
   public class UnionMember extends BasicView
   {
       
      
      private var array:Array;
      
      private var appoint:Appoint;
      
      private var item:Item;
      
      public function UnionMember(name:String)
      {
         this.assetName = name;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("memberPanel");
         this.addBtnEvent("btnClose");
         appoint = new Appoint(this.assetName);
         appoint.callBack = onAppoint;
         EventManager.on("UNION_MEMBER",onUpdate);
         EventManager.on("UNION_UPDATE_MEMBER",onUpdate);
         this.initListItem();
         this.sendMessage();
      }
      
      override public function initListItem() : void
      {
         var i:int = 0;
         var item:* = null;
         super.initListItem();
         for(i = 1; i <= onePageNum; )
         {
            item = new Item(mainPanel["item" + i]);
            item.callBack = onRmTc;
            item.visible = false;
            items.push(item);
            i++;
         }
      }
      
      protected function onRmTc(data:Object) : void
      {
         data = data;
         Unify.log(data.type,data.vo,data.x,data.y);
         if(data.type == 1)
         {
            item = data.item;
            this.addChild(appoint);
            appoint.x = data.x;
            appoint.y = data.y;
            appoint.setData(data.vo);
         }
         else
         {
            Unify.again(Unify.message("你确定踢出num吗？",data.vo.name),function():void
            {
               UnionManager.getIns().removeMember(data.vo.uId,data.vo.index);
               UnionManager.getIns().deleteMember(data.vo.uId);
            });
         }
      }
      
      protected function onAppoint(uid:Number, index:int, rodeId:int) : void
      {
         UnionManager.getIns().setRole(index,uid,rodeId);
         if(item)
         {
            item.setRodeId(rodeId);
         }
      }
      
      protected function sendMessage() : void
      {
         UnionManager.getIns().getUnionMembers(UnionManager.getIns().unionInfo.id);
      }
      
      override protected function sendPage() : void
      {
         this.updatePage(array);
      }
      
      protected function onUpdate() : void
      {
         var total:int = Number(UnionManager.getIns().unionInfo.count);
         pageTotal = Math.ceil(total / onePageNum);
         pageTotal = pageTotal < 1 ? 1 : pageTotal;
         array = UnionManager.getIns().unionInfo.allMembers;
         this.updatePage(array);
      }
      
      override protected function updatePage(array:Array) : void
      {
         var i:int = 0;
         var item:* = null;
         var arr:Array = Unify.arrayPart(array,pageCurr);
         Unify.hide(items);
         for(i = 0; i < arr.length; )
         {
            item = items[i];
            item.setData(arr[i]);
            item.visible = true;
            i++;
         }
         updateArrowButton();
      }
      
      override public function dispose() : void
      {
         EventManager.off("UNION_MEMBER",onUpdate);
         EventManager.off("UNION_UPDATE_MEMBER",onUpdate);
         super.dispose();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.MovieClip;
import union.model.Unify;
import union.model.UnionManager;
import union.model.vo.MemberVo;
import union.utils.UnionConfig;
import union.view.BasicView;

class Item extends BasicView
{
    
   
   public var callBack:Function;
   
   public var vo:MemberVo;
   
   function Item(mainPanel:MovieClip)
   {
      super();
      this.mainPanel = mainPanel;
   }
   
   public function setData(data:Object) : void
   {
      vo = data as MemberVo;
      Unify.log(data);
      text("txtName").text = vo.name;
      text("txtPos").text = vo.jobTitle;
      text("txtFightPower").text = vo.fightPower + "";
      text("txtTotal").text = vo.contribution + "";
      text("txtTime").text = Unify.dateToFormat(vo.active_time);
      this.addBtnEvent("btnRm","btnTc");
      this.showBtn();
   }
   
   public function setRodeId(roleId:int) : void
   {
      vo.roleId = roleId;
      text("txtPos").text = vo.jobTitle;
   }
   
   private function showBtn() : void
   {
      this.show("btnRm","btnTc");
      if(UnionManager.getIns().unionInfo.isLeader)
      {
         if(Unify.uidIsMySelf(vo.uId))
         {
            this.hide("btnRm","btnTc");
         }
      }
      else if(UnionManager.getIns().unionInfo.memberVo.roleId == UnionConfig.ZW_FMZ)
      {
         if(Unify.uidIsMySelf(vo.uId))
         {
            this.hide("btnRm","btnTc");
         }
         else if(vo.roleId == 9999 || vo.roleId == UnionConfig.ZW_FMZ)
         {
            this.hide("btnRm","btnTc");
         }
      }
      else
      {
         this.hide("btnRm","btnTc");
      }
   }
   
   override protected function onBtnName(name:String) : void
   {
      var mc:DisplayObject = mainPanel["btnRm"];
      var x:int = mainPanel.x + mc.x;
      var y:int = mainPanel.y + mc.y + mc.height;
      callBack({
         "item":this,
         "vo":vo,
         "x":x,
         "y":y,
         "type":(name == "btnRm" ? 1 : 0)
      });
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

import flash.events.MouseEvent;
import union.model.Unify;
import union.model.UnionManager;
import union.model.vo.MemberVo;
import union.utils.UnionConfig;
import union.view.BasicView;

class Appoint extends BasicView
{
    
   
   public var callBack:Function;
   
   private var vo:MemberVo;
   
   function Appoint(name:String)
   {
      super();
      this.assetName = name;
      this.addChild(Unify.getRect(3000,3000,0,-1500,-1500,0));
      this.mainPanel = this.addMovieClip("appointItem");
      this.addEventListener("click",onCloseSelf);
      this.addBtnEvent("btn_fmz","btn_hf","btn_jy","btn_cy");
   }
   
   protected function onCloseSelf(event:MouseEvent) : void
   {
      this.removeFromParent();
   }
   
   public function setData(vo:MemberVo) : void
   {
      this.vo = vo;
   }
   
   override protected function onBtnName(name:String) : void
   {
      var type:* = null;
      var max:int = 0;
      var curr:int = 0;
      this.removeFromParent();
      var roleId:int = 0;
      var jobName:String = "";
      switch(name)
      {
         case "btn_fmz":
            roleId = UnionConfig.ZW_FMZ;
            jobName = "副盟主";
            break;
         case "btn_hf":
            roleId = UnionConfig.ZW_HF;
            jobName = "护法";
            break;
         case "btn_jy":
            roleId = UnionConfig.ZW_JY;
            jobName = "精英";
            break;
         case "btn_cy":
            roleId = 0;
            jobName = "成员";
      }
      if(roleId > 0)
      {
         type = name.split("_")[1];
         max = UnionConfig.getMemberJob(type);
         curr = UnionManager.getIns().unionInfo.getMemberJob(roleId);
         Unify.log(curr,max);
         if(curr >= max)
         {
            Unify.alert(Unify.message("num职位人数已经满了",jobName));
            return;
         }
      }
      callBack(vo.uId,vo.index,roleId);
   }
}
