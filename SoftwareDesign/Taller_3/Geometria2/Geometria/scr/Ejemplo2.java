import java.awt.*;
import java.util.ArrayList;

public class Ejemplo2 {
    public static void main (String arg[]) throws InterruptedException {
        System.out.println("Comienza main()...");
        Rectangulo r1 = new Rectangulo(0, 0, 1.0, 1.0);
        Rectangulo r2 = new Rectangulo(0, 0, 1.0, 1.0);
        
        VentanaCerrable ventana
        = new VentanaCerrable("Ventana abierta al mundo...");
        ArrayList v = new ArrayList();
        RectanguloGrafico rg1 = new RectanguloGrafico(150, 120, 300, 260, Color.red);
        RectanguloGrafico rg2 = new RectanguloGrafico(80, 80, 200, 200, Color.blue);
        RectanguloGrafico rg = new RectanguloGrafico(50, 30, 450, 350, Color.green);
        rg.rotar(45);
        rg1.rotar(15);
        rg2.rotar(70);
        v.add(rg1);
        v.add(rg2);
        v.add(rg);
        PanelDibujo mipanel = new PanelDibujo(v);
        ventana.add(mipanel);
        ventana.setSize(500, 400);
        ventana.setVisible(true);
        System.out.println("Termina main()...");
    }
}
