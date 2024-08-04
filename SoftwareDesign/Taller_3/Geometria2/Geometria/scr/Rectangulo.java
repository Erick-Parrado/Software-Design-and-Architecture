// fichero Rectangulo.java
public class Rectangulo extends Geometria {
    // definici�n de variables miembro de la claes
    private static int numRectangulos = 0;
    protected double x1, y1, x2, y2,x3,y3,x4,y4, cx, cy,r;

    // constructores de la clase
    public Rectangulo(double p1x, double p1y, double p2x, double p2y) {
        x1 = p1x;
        x2 = p2x;
        y1 = p1y;
        y2 = p2y;
        r=0;
        
        cx =  x1+(( x2 - x1 ) / 2);
        cy =  y1+(( y2 - y1) /2);
    }

    public Rectangulo() {
        this(0, 0, 1.0, 1.0) ;
    }

    // definici�n de m�todos
    public double perimetro() {
        return 2.0 * ((x1 - x2) + (y1 - y2));
    }

    public double area() {
        return (x1 - x2) * (y1 - y2);
    }
}
// fin de la clase Rectangulo