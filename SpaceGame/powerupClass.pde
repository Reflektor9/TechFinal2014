class PowerUp
{//position
 PVector pos;
 //size
 PVector size;
 //what kind of powerup is it
 int type;
 //texture
 PImage tex;
 PowerUp(PVector p,int t, PImage te)
 {
   //set position
   pos = new PVector(p.x,p.y);
   //set type
   type = t;
   //set texture
   tex = te;
   //set size
   size = new PVector(25,25);
 }
 void display()
 {
   //if texture, display it
   if(tex!=null)
   {
   image(tex,pos.x,pos.y,size.x,size.y);
   }
 }
 boolean playerCol(Player p)
 {//if difference in x and y is les than average size x and y
   boolean c;
   c = (abs(pos.x-p.pos.x) <=(size.x+p.size.x)/2 && abs(pos.y-p.pos.y) <=(size.y+p.size.y)/2);
   return c;
 }
}
