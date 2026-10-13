package export.alliance
{
   import AssetsClass.ShaiziAssets;
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import union.model.EventManager;
   import union.model.UnionManager;
   
   public class AllianceInterfaceShow extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var buffbtn:SimpleButton;
      
      public var txbtn:SimpleButton;
      
      public var csbtn:SimpleButton;
      
      public var fbbtn:SimpleButton;
      
      public var btnCreate:SimpleButton;
      
      public var btnJoin:SimpleButton;
      
      public var btnMyUnion:SimpleButton;
      
      public var btnUnionList:SimpleButton;
      
      public var tipmc:MovieClip;
      
      public var lmszbtn:SimpleButton;
      
      private var unionBtns:Array;
      
      private var gc:Config;
      
      public function AllianceInterfaceShow()
      {
         unionBtns = [];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         var i:int = 0;
         this.removeEventListener("addedToStage",added);
         this.xbtn.addEventListener("click",xClick);
         this.buffbtn.addEventListener("click",buffClick);
         this.txbtn.addEventListener("click",txClick);
         this.csbtn.addEventListener("click",csClick);
         this.fbbtn.addEventListener("click",fbClick);
         this.lmszbtn.addEventListener("click",lmszClick);
         var random:uint = Math.round(RandomControllor.getIns().getRandom() * 2) + 1;
         tipmc.gotoAndStop(random);
         this.lmszbtn.visible = false;
         this.csbtn.visible = false;
         this.fbbtn.visible = false;
         this.buffbtn.visible = this.txbtn.visible = false;
         if(btnCreate)
         {
            btnCreate.y = csbtn.y;
            btnJoin.y = csbtn.y;
            unionBtns = [btnCreate,btnJoin,btnMyUnion,btnUnionList];
            for(i = 0; i < 4; unionBtns[i].visible = false,i++)
            {
            }
            this.addRemoveEvent(unionBtns,1);
            EventManager.on("UNION_CHECK",onUnionCheck);
            UnionManager.getIns().getOwnUnion();
         }
      }
      
      protected function updateButton(type:int) : void
      {
         var i:int = 0;
         btnMyUnion.y = csbtn.y;
         btnUnionList.y = csbtn.y;
         for(i = 0; i < unionBtns.length; unionBtns[i].visible = false,i++)
         {
         }
         if(type)
         {
            btnUnionList.visible = btnMyUnion.visible = true;
         }
         else
         {
            btnJoin.visible = btnCreate.visible = true;
         }
      }
      
      protected function onUnionCheck(data:Object) : void
      {
         if(!this.parent)
         {
            return;
         }
         var hasUnion:Boolean = data.unionInfo;
         this.buffbtn.visible = this.txbtn.visible = hasUnion;
         if(hasUnion)
         {
            this.updateButton(1);
         }
         else
         {
            this.updateButton(0);
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var type:int = 0;
         switch(e.currentTarget)
         {
            case btnCreate:
               type = 0;
               break;
            case btnJoin:
               type = 1;
               break;
            case btnMyUnion:
               type = 2;
               break;
            case btnUnionList:
               type = 3;
         }
         UnionManager.getIns().openUnion(type);
         this.xClick(null);
      }
      
      private function addRemoveEvent(btns:Array, type:int) : void
      {
         var i:int = 0;
         var btn:* = null;
         for(i = 0; i < btns.length; )
         {
            btn = btns[i];
            if(type)
            {
               btn.addEventListener("click",onClick);
            }
            else
            {
               btn.removeEventListener("click",onClick);
            }
            i++;
         }
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         this.xbtn.removeEventListener("click",xClick);
         this.buffbtn.removeEventListener("click",buffClick);
         this.txbtn.removeEventListener("click",txClick);
         this.csbtn.removeEventListener("click",csClick);
         this.fbbtn.removeEventListener("click",fbClick);
         this.lmszbtn.removeEventListener("click",lmszClick);
         this.addRemoveEvent(unionBtns,0);
         EventManager.off("UNION_CHECK",onUnionCheck);
      }
      
      private function lmszClick(e:MouseEvent) : void
      {
         var szAssets:ShaiziAssets = new ShaiziAssets();
         this.addChild(szAssets);
      }
      
      private function checkOpen() : Boolean
      {
         if(!gc.isHideDebug || gc.isTest)
         {
            return true;
         }
         if(gc.honorData.groupId != -1)
         {
            return true;
         }
         var hours:int = new Date().hours;
         if(hours < 19 || hours > 20)
         {
            gc.ts.setTxt("开放时间为每天19:00-21:00");
            gc.stage.addChild(gc.ts);
            return false;
         }
         return true;
      }
      
      private function fbClick(evt:MouseEvent) : void
      {
         if(this.checkOpen() == false)
         {
            return;
         }
         gc.nodeInfo.PK_OR_FB = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("GoToPKSystem"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function buffClick(e:MouseEvent) : void
      {
         var af:* = null;
         if(!this.parent)
         {
            return;
         }
         if(gc.dataObject.hasGetAlliance == true || gc.dataObject.hasGetAlliance == "true")
         {
            gc.ts.setTxt("您今天已经领取过联盟的战意");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            af = new AllianceFighting();
            af.x = this.x;
            af.y = this.y;
            this.parent.addChild(af);
            this.xClick(null);
         }
      }
      
      private function txClick(e:MouseEvent) : void
      {
         if(!this.parent)
         {
            return;
         }
         var ashop:AllianceShop = new AllianceShop();
         ashop.x = this.x;
         ashop.y = this.y;
         this.parent.addChild(ashop);
         this.xClick(null);
      }
      
      private function csClick(e:MouseEvent) : void
      {
         if(this.checkOpen() == false)
         {
            return;
         }
         gc.nodeInfo.PK_OR_FB = 0;
         gc.eventManger.dispatchEvent(new CommonEvent("GoToPKSystem"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
