package union.view
{
   import flash.text.TextField;
   import union.model.Unify;
   import union.model.UnionManager;
   
   public class UnionCreate extends BasicView
   {
       
      
      protected var txtName:TextField;
      
      public function UnionCreate(name:String)
      {
         this.assetName = name;
         this.isCloseMain = true;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("createPanel");
         txtName = mainPanel["txtName"];
         this.addBtnEvent("btnClose","btnCreate");
         var t:TextField = this.createTextField(297,306,366,25,"center",18);
         t.text = "创建联盟需消耗5000点券";
      }
      
      override protected function onBtnName(name:String) : void
      {
         name = name;
         super.onBtnName(name);
         var unionName:String = txtName.text;
         if(name == "btnCreate")
         {
            var money:int = 5000;
            if(Unify.ticket >= money)
            {
               UnionManager.getIns().match2(unionName,function(message:String):void
               {
                  message = message;
                  Unify.again(Unify.message("确定消耗num点券，创建联盟吗？",5000),function():void
                  {
                     UnionManager.getIns().unionCreate(message);
                  });
               });
            }
            else
            {
               Unify.alert("点券不足");
            }
         }
      }
   }
}
