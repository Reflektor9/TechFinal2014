class PowerUp
{
 PVector pos;
 PVector size;
 int type;
 PImage tex;
 PowerUp(PVector p,int t/*, PImage te*/)
 {
   pos = new PVector(p.x,p.y);
   type = t;
//   tex = te;
   size = new PVector(25,25);
 }
 void display()
 {
   stroke(255);
   fill(255*(1-float(type)/3),0,255*float(type)/3);
   ellipse(pos.x,pos.y,size.x,size.y);
 }
 boolean playerCol(Player p)
 {
   boolean c;
   c = (abs(pos.x-p.pos.x) <=(size.x+p.size.x)/2 && abs(pos.y-p.pos.y) <=(size.y+p.size.y)/2);
   return c;
 }
}
