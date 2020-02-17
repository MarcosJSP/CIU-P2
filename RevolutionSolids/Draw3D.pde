class Draw3D {
  ArrayList<Point> points;
  PShape figure;
  final int meridians = 20;
  final float gradeIncrement = 360/meridians;
  final float radIncrement = (360/meridians) * PI/180;
  String drawMode;
  float overXRotation;
  float overYRotation;
  String rotationDirection;
  int pointOfGravity;
  
  Draw3D(ArrayList<Point> points) {
    this.points = new ArrayList<Point>();
    int max = -height;
    int min = height;
    for (Point point : points) {
      if (point.getY() > max) max = point.getY();
      if (point.getY() < min) min = point.getY();
      Point normalizedPoint = new Point(point.getX() - width/2, point.getY());
      this.points.add(normalizedPoint);
    }
    pointOfGravity = (max+min)/2;
    drawMode = "TRIANGLE_STRIP";
    createFigure();
    overXRotation = 0;
    overYRotation = 0;
    rotationDirection = "";
  }

  public void createNoMassFigure() {
    figure = createShape();
    figure.beginShape();
    figure.noFill();
    figure.stroke(250);
    figure.strokeWeight(1);

    for (float rad = 0; rad < 2*PI; rad += radIncrement) {
      float x1, y1, z1, x2, y2, z2;
      for (Point point : points) {
        x1 = point.getX(); 
        y1 = point.getY(); 
        z1 = point.getZ();
        x2 = x1 * cos(rad) - z1 * sin(rad);
        y2 = y1;
        z2 = x1 * sin(rad) + z1 * cos(rad);
        figure.vertex(x2, y2, z2);
      }
    }
    figure.endShape();
  }

  public void createMassFigure(int beginShape) {
    figure = createShape();
    figure.beginShape(beginShape);
    figure.noFill();
    figure.fill(150);
    figure.stroke(250);
    figure.strokeWeight(1);
    float p1x1, p1y1, p1z1, p1x2, p1y2, p1z2;
    float p2x1, p2y1, p2z1, p2x2, p2y2, p2z2;
    for (int i=0; i< points.size()-1; i++) {
      p1x1 = points.get(i).getX(); 
      p1y1 = points.get(i).getY(); 
      p1z1 = points.get(i).getZ();
      p2x1 = points.get(i+1).getX(); 
      p2y1 = points.get(i+1).getY(); 
      p2z1 = points.get(i+1).getZ();

      for (float rad = 0; rad < 2*PI; rad += radIncrement) {
        p1x2 = p1x1 * cos(rad) - p1z1 * sin(rad);
        p1y2 = p1y1;
        p1z2 = p1x1 * sin(rad) + p1z1 * cos(rad);
        figure.vertex(p1x2, p1y2, p1z2);

        p2x2 = p2x1 * cos(rad) - p2z1 * sin(rad);
        p2y2 = p2y1;
        p2z2 = p2x1 * sin(rad) + p2z1 * cos(rad);
        figure.vertex(p2x2, p2y2, p2z2);
      }
      figure.vertex(p1x1, p1y1, p1z1);
      figure.vertex(p2x1, p2y1, p2z1);
      figure.vertex(p2x1, p2y1, p2z1);
      figure.vertex(p2x1, p2y1, p2z1);
    }
    figure.endShape();
  }
  
  public void createFigure(){
    switch(drawMode){
      case "QUAD_STRIP":
        createMassFigure(QUAD_STRIP);
        break;
      case "TRIANGLE_STRIP":
        createMassFigure(TRIANGLE_STRIP);
        break;
      case "NO_MASS":
        createNoMassFigure();
        break;
    }
  }
  
  public void changeDrawMode(String drawMode){
      this.drawMode = drawMode;
      createFigure();
  }
  
  public void nextDrawMode(){
    String drawMode = "";
    if (this.drawMode=="TRIANGLE_STRIP"){
      drawMode = "QUAD_STRIP";
    }else if(this.drawMode=="QUAD_STRIP"){
      drawMode = "NO_MASS";
    }else if(this.drawMode=="NO_MASS"){
      drawMode = "TRIANGLE_STRIP";
    }
    changeDrawMode(drawMode);
  }
  
  public void changerotationDirection(String rotationDirection){
    this.rotationDirection = rotationDirection;
  }

  public void paint() {
    switch(rotationDirection){
      case "RIGHT":
        overYRotation+=.025;
        break;
      case "LEFT":
        overYRotation-=.025;
        break;
      case "UP":
        overXRotation+=.025;
        break;
      case "DOWN":
        overXRotation-=.025;
        break;
    }
    rotateY(-PI/6+overYRotation);
    rotateX(overXRotation);
    shape(figure);
    strokeWeight(2);
    textSize(20);
    
    //X AXIS
    stroke(250,0,0);
    fill(250,0,0);
    line (0, pointOfGravity, height/2, pointOfGravity);
    text("X",height/2 - 10, pointOfGravity - 10);
    
    //Y AXIS
    stroke(0,250,0);
    fill(0,250,0);
    line (0, pointOfGravity-height/2, 0, pointOfGravity);
    text("Y", 15 , (pointOfGravity + 15) -height/2);
    
    //Z AXIS
    stroke(0,0,250);
    fill(0,0,250);
    line(0,pointOfGravity,0,0,pointOfGravity,height/2);
    text("Z", 0 , pointOfGravity - 10, height/2 - 10);
  }
}
