class PowerUp
{
 PVector pos;
 PVector size;
 int type;
 //image for the texture of the powerups
 PImage tex;
 PowerUp(PVector p,int t, PImage te)
 {
   //position of powerups
   pos = new PVector(p.x,p.y);
   //type of powerup
   type = t;
   //texture of powerup
   tex = te;
   //size of the power up
   size = new PVector(25,25);
 }
 void display()
 {
   if(tex!=null)
   {
   image(tex,pos.x,pos.y,size.x,size.y);
   }
 }
 boolean playerCol(Player p)
 {
   boolean c;
   c = (abs(pos.x-p.pos.x) <=(size.x+p.size.x)/2 && abs(pos.y-p.pos.y) <=(size.y+p.size.y)/2);
   return c;
 }
}
