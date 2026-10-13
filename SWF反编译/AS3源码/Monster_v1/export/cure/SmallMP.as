package export.cure
{
   public class SmallMP extends SmallHP
   {
       
      
      public function SmallMP(param1:Boolean = false)
      {
         super();
         this.isUsed = param1;
         this.cname = "SMp";
         this.curNum = 100;
         allcount = 72;
      }
      
      override protected function cure() : *
      {
         curWho.roleProperies.setMMP(curWho.roleProperies.getMMP() + this.curNum);
         this.addCureMc(this.curNum,"bulnum");
      }
   }
}
