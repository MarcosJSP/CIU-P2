Draw2D draw2D;
Draw3D draw3D;
boolean mode3D;
Point lastMousePosition;
Point currentCameraPosition;
int scrollPosition;
PImage leftKey, rigthKey, upKey, downKey, wheelMouse, leftMouse, mKey, nKey, dKey, hKey;
boolean helpMenu;
PFont font1, font2, font3;
final int initialScrollPosition = -700;
void setup() {
  size(1100,700,P3D);
  fill(250);
  stroke(250);
  draw2D = new Draw2D();
  mode3D = false;
  currentCameraPosition = new Point(width/2,0);
  scrollPosition = initialScrollPosition;
  font1 = createFont("Arial", 20);
  font2 = createFont("Arial bold", 40);
  font3 = createFont("Arial bold", 80);
  
  leftKey = loadImage("./resources/images/LEFT.png");
  rigthKey = loadImage("./resources/images/RIGHT.png");
  upKey = loadImage("./resources/images/UP.png");
  downKey = loadImage("./resources/images/DOWN.png");
  wheelMouse = loadImage("./resources/images/WHEEL-MOUSE.png");
  leftMouse = loadImage("./resources/images/LEFT-MOUSE.png");
  mKey = loadImage("./resources/images/M.png");
  nKey = loadImage("./resources/images/N.png");
  dKey = loadImage("./resources/images/D.png");
  hKey = loadImage("./resources/images/H.png");
  
  helpMenu = false;
}

void draw() {
  background(50);
  textFont(font1);
  textAlign(LEFT);
  textSize(20);
  
  if (mode3D) {
    if (helpMenu){
      paintHelpMenu();
    }else{
      paint3DModeInfo();
      translate(currentCameraPosition.getX(),currentCameraPosition.getY(), scrollPosition);
      draw3D.paint();
    }
  } else {
    stroke(250);
    strokeWeight(1);
    line(width/2, 0, width/2, height);
    paint2DModeInfo();
    draw2D.paint();
  }
}

void paint3DModeInfo(){
    int keySize = 40;
    
    fill(250);
    textAlign(LEFT);
    
    textFont(font2);
    textSize(40);
    text("3D Mode", 50, 70);
    
    textFont(font1);
    textSize(20);
    image(hKey, 50, 100, keySize, keySize);
    text("Short-cuts list", 130, 100 + keySize/2+5);
    
}

void paint2DModeInfo(){
    int keySize = 40;
    int mouseWidth = 38;
    int mouseHeight = 50;
    int xRowSize = 450;
    int yRowMargin = 50;
    
    fill(250);
    textAlign(LEFT);
    
    textFont(font2);
    textSize(40);
    text("2D Mode",50, 70);
    
    textFont(font1);
    textSize(20);
    
    image(nKey, 50, yRowMargin*2, keySize, keySize);
    text("To clean the canvas", 130, keySize/2+5 + yRowMargin*2);
    
    image(mKey, 50, yRowMargin*3 + 12, keySize, keySize);
    text("To see your figure revolutionized", 130, keySize/2+5 + yRowMargin*3);
    text("in the 3D Mode ", 130, keySize/2+5 + yRowMargin*3 + 30);
    
    image(leftMouse, 50, yRowMargin*4 + 60, mouseWidth, mouseHeight);
    text("Use the left click from the middle", 130, keySize/2+10 + yRowMargin*4 + 30);
    text("line to the right to create the ", 130, keySize/2+10 + yRowMargin*4 + 60);
    text("vertex of the figure", 130, keySize/2+10 + yRowMargin*4 + 90);
 
}

void paintHelpMenu(){
    fill(250);
    
    int keySize = 40;
    int mouseWidth = 38;
    int mouseHeight = 50;
    int xRowSize = 450;
    int yRowMargin = 60;
        
    textFont(font2);
    textSize(40);
    textAlign(CENTER);
    text("3D Mode Short-cuts", width/2, height/6);
    
    textFont(font1);
    textSize(20);
    textAlign(LEFT);
    image(upKey, width/2 - xRowSize/2, height/6 + yRowMargin, keySize, keySize);
    image(downKey, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin, keySize, keySize);
    text("Rotates figure arround the x axis", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin);
    
    image(leftKey, width/2 - xRowSize/2, height/6 + yRowMargin * 2, keySize, keySize);
    image(rigthKey, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin * 2, keySize, keySize);
    text("Rotates figure arround the y axis", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin * 2);
    
    image(dKey, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin*3, keySize, keySize);
    text("Swaps the mesh that covers the figure", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin*3);
    
    image(mKey, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin*4, keySize, keySize);
    text("Heads back to 2D shape editor", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin*4);
    
    image(nKey, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin*5, keySize, keySize);
    text("Resets the 2D shape editor", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin*5);
    
    image(leftMouse, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin*6 - 5, mouseWidth, mouseHeight);
    text("Moves around the stage", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin*6);
    
    image(wheelMouse, (width/2 - xRowSize/2) + 50, height/6 + yRowMargin*7 - 5, mouseWidth, mouseHeight);
    text("Zooms in and out the figure", (width/2 - xRowSize/2) + 130, height/6 + keySize/2+5 + yRowMargin*7);
    
    textAlign(CENTER);
    textSize(14);
    text("Press any key to get out of the short-cuts menu", width/2, height/5 + keySize/2+5 + yRowMargin*8);
    
}

void mouseDragged(){
  if(mode3D){
    if (mouseButton == 37){ //LEFT CLICK
      if (lastMousePosition == null){
        lastMousePosition = new Point (mouseX, mouseY);
      }else{
        currentCameraPosition.x += (mouseX - lastMousePosition.getX()) * 1.2;
        currentCameraPosition.y += (mouseY - lastMousePosition.getY()) * 1.2;
        lastMousePosition = new Point (mouseX, mouseY);
      }
    }
  }
}

void mouseReleased() {
  if (mode3D) {
    if (mouseButton == 37)lastMousePosition = null;
  } else {
    if (mouseX < width/2)draw2D.addPoint(width/2, mouseY);
    else draw2D.addPoint(mouseX, mouseY);
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount() < 0)scrollPosition += 50;
  else scrollPosition -= 50;
}

void keyReleased (){
  if (mode3D){
    if (keyCode == UP ||keyCode == DOWN ||keyCode == LEFT || keyCode == RIGHT) draw3D.changerotationDirection("");
  }
}

void keyPressed () {
  if (mode3D) {
    if (helpMenu){
      helpMenu=false;
    }else{
      if (key == 'h' || key == 'H') helpMenu=true;
      if (key == 'd' || key == 'D') draw3D.nextDrawMode();
      if (keyCode == UP) draw3D.changerotationDirection("UP");
      if (keyCode == DOWN) draw3D.changerotationDirection("DOWN");
      if (keyCode == LEFT) draw3D.changerotationDirection("LEFT");
      if (keyCode == RIGHT) draw3D.changerotationDirection("RIGHT");
      if (key == 'm' || key == 'M')mode3D = !mode3D;
      if (key == 'n' || key == 'N') {
        draw2D.reset();
        mode3D = false;
        currentCameraPosition = new Point(width/2,0);
        scrollPosition = initialScrollPosition;
      }
    }
  } else {
    if ((key == 'm' || key == 'M') && !draw2D.getPoints().isEmpty()) {
      draw3D = new Draw3D(draw2D.getPoints());
      mode3D = !mode3D;
    }
    if (key == 'n' || key == 'N') {
      draw2D.reset();
      mode3D = false;
      currentCameraPosition = new Point(width/2,0);
      scrollPosition = initialScrollPosition;
    }
  }
}
