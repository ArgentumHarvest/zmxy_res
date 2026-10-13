package export.cure
{
   import event.CommonEvent;
   
   public class SmallMP extends SmallHP
   {
       
      
      public function SmallMP(used:Boolean = false)
      {
         super();
         this.isUsed = used;
         this.cname = "SMp";
         this.curNum = 100;
         allcount = 72;
      }
      
      override protected function cure() : *
      {
         curWho.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[curWho.roleProperies.getMMP() + this.curNum]));
         this.addCureMpMc(this.curNum);
      }
   }
}
