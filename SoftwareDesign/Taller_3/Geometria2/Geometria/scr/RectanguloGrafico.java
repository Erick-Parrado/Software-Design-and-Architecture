// Fichero RectanguloGrafico.java
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;

class RectanguloGrafico extends Rectangulo implements Dibujable {
    // nueva variable miembro
    Color color;


    // constructor
    public RectanguloGrafico(double x1, double y1, double x2, double y2,Color unColor) {
        // llamada al constructor de Rectangulo
        super(x1, y1, x2, y2);
        this.color = unColor; // en este caso this es opcional

    }

    // metodos de la interface Dibujable
    public void dibujar(Graphics dw) {
        AffineTransform at = new AffineTransform();
        at.rotate(this.r,cx,cy);
        ((Graphics2D)dw).setTransform(at);
        dw.setColor(color);
        System.out.println(this.x1);
        dw.drawRect((int) x1, (int) y1, (int) (x2 - x1), (int) (y2 - y1));
    }

    public void setPosicion(double x, double y) {
        ; // metodo vacio, pero necesario de definir
    }
    public void rotar(double degree){
        // System.out.println(this.x1);
        // double ca=this.cx-this.x1;
        // double co=this.cy-this.y1;
        // double h = Math.sqrt(Math.pow(co,2)+Math.pow(ca,2));
        // double initAngle = Math.asin(co/h);
        // double finalAngle = initAngle+degree;
        // double dy = h*Math.sin(finalAngle); 
        // double dx = h*Math.cos(finalAngle);  
        // System.out.println(dx);
        // this.x1 = this.x1+dx;
        // this.x2 = this.x2-dx;
        // this.y1 = this.y1+dy;
        // this.y1 = this.y2-dy;
        this.r = Math.toRadians(degree);
    }

} // fin de la clase RectanguloGrafico