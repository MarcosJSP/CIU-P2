class Draw2D {
  ArrayList<Point> points;

  Draw2D() {
    points = new ArrayList<Point>();
  }
  
  public void reset(){
    points.clear();
  }

  public void addPoint(int x, int y) {
    Point point = new Point(x, y);
    this.points.add(point);
  }
  
  public void paint() {
    if(points.size()==0)return;
    Point lastPoint = points.get(0);
    for(int i = 1;points.size() > 1 && i < points.size(); i++){
      Point previousPoint = lastPoint;
      lastPoint = points.get(i);
      line(previousPoint.getX(),previousPoint.getY(),lastPoint.getX(), lastPoint.getY());
    }
    line(mouseX,mouseY,lastPoint.getX(), lastPoint.getY());
  }
  
  public ArrayList<Point> getPoints(){
    return points;
  }
}
