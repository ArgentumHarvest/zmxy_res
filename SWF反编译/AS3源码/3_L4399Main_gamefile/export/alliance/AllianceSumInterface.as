package export.alliance
{
   import export.microshop.SumInterface;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import union.model.UnionManager;
   
   public class AllianceSumInterface extends SumInterface
   {
       
      
      public function AllianceSumInterface(mtotal:int, _price:int, _num:int, _name:String, _color:String)
      {
         super(mtotal,_price,_num,_name,_color);
      }
      
      override protected function changeClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new Event("ALLIANCEBUYCHANGLE"));
         this.destory();
      }
      
      override protected function okClick(e:MouseEvent) : void
      {
         if(this.allmoney < this.getPrice())
         {
            gc.ts.setTxt("联盟贡献点不足");
            gc.stage.addChild(gc.ts);
            gc.eventManger.dispatchEvent(new Event("ALLIANCEBUYCHANGLE"));
         }
         else
         {
            if(UnionManager.getIns().isInit)
            {
               UnionManager.getIns().buyProp(this.getPrice());
            }
            trace("buyByType --->>" + gc.honorData.findTypeIdByFillName(this.tname));
         }
         this.destory();
      }
      
      override protected function setText() : void
      {
         newTextField.text = "你确定要消耗" + this.getPrice() + "联盟贡献点，兑换" + this.tname;
      }
   }
}
