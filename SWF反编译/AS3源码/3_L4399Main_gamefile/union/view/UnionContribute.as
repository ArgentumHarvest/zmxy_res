package union.view
{
   import union.model.EventManager;
   import union.model.Unify;
   import union.model.UnionManager;
   import union.utils.UnionConfig;
   
   public class UnionContribute extends BasicView
   {
       
      
      private var items:Array;
      
      public function UnionContribute(name:String)
      {
         items = [];
         this.assetName = name;
         super();
      }
      
      override protected function render() : void
      {
         var i:int = 0;
         var item:* = null;
         mainPanel = this.addMovieClip("contributePanel");
         for(i = 0; i < 2; )
         {
            item = new Item(mainPanel["item" + i]);
            items.push(item);
            i++;
         }
         items[0].setData(UnionConfig.contribute1,1);
         items[1].setData(UnionConfig.contribute2,2);
         UnionManager.getIns().getTaskValue();
         EventManager.on("UNION_UPDATE_TASK",onUpdateTask);
      }
      
      protected function onUpdateTask() : void
      {
         update();
         items[0].updateTask();
         items[1].updateTask();
      }
      
      public function update() : void
      {
         if(mainPanel)
         {
            text("txtTicket").text = Unify.showTicket;
            text("txtSprite").text = Unify.showSprite;
         }
      }
      
      override public function updateView() : void
      {
         this.update();
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var item:* = null;
         EventManager.off("UNION_UPDATE_TASK",onUpdateTask);
         if(items)
         {
            for(i = 0; i < items.length; )
            {
               item = items[i];
               item.dispose();
               item = null;
               i++;
            }
            items = null;
         }
      }
   }
}

import flash.display.MovieClip;
import flash.display.SimpleButton;
import union.model.Unify;
import union.model.UnionManager;
import union.utils.UnionConfig;
import union.view.BasicView;

class Item extends BasicView
{
    
   
   public var index:int;
   
   private var arr:Array;
   
   private var btnGx:SimpleButton;
   
   function Item(panel:MovieClip)
   {
      super();
      this.mainPanel = panel;
      btnGx = mainPanel["btnGx"];
      this.addBtnEvent("btnGx");
   }
   
   override protected function onBtnName(name:String) : void
   {
      name = name;
      if(index == 1)
      {
         var money:int = 100;
         if(Unify.ticket >= money)
         {
            Unify.again(Unify.message("你确定消耗num点券贡献吗？",money),function():void
            {
               UnionManager.getIns().doTask(UnionConfig.contriTicketTaskId + "");
               Unify.removeTicket(money);
               buttonIsGray(btnGx,false);
               UnionConfig.isSave = true;
            });
         }
         else
         {
            Unify.alert("点券不足");
         }
      }
      else if(index == 2)
      {
         money = 100;
         if(!UnionConfig.canContribute)
         {
            return;
         }
         if(Unify.sprite >= money)
         {
            UnionManager.getIns().doTask(UnionConfig.contriSpriteTaskId + "");
            Unify.removeSprite(money);
            this.buttonIsGray(btnGx,false);
            UnionConfig.isSave = true;
         }
         else
         {
            Unify.alert("灵魂不足");
         }
      }
   }
   
   public function updateTask() : void
   {
      var num:int = 0;
      if(index == 1)
      {
         num = UnionManager.getIns().taskVo.conNumTicket;
         text("txt_3").text = Unify.message(arr[3],num);
      }
      else if(index == 2)
      {
         num = UnionManager.getIns().taskVo.conNumSprite;
         text("txt_3").text = Unify.message(arr[3],num);
      }
      this.buttonIsGray(mainPanel["btnGx"],num == 0);
   }
   
   public function setData(arr:Array, index:int) : void
   {
      var i:int = 0;
      this.index = index;
      this.arr = arr;
      for(i = 0; i < arr.length; )
      {
         text("txt_" + i).text = arr[i];
         i++;
      }
   }
   
   override public function dispose() : void
   {
      super.dispose();
   }
}
