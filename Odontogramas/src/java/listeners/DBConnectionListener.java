/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import conexion.jpaConnection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DBConnectionListener implements ServletContextListener {

    private ServletContext servletContext;
    private Context ctx;

    public final void contextInitialized(ServletContextEvent sce) {
        try {
            ctx = new InitialContext();
            jpaConnection.createEntityManagerFactory();
            System.out.println("++++++++++++++OKKKKKKKKKKKKKKKKKKKKKKK++++++++++++++++++");
        } catch (Exception e) {
            servletContext.log("No se puede obtener la fuente de datos ", e);
            System.out.println("++++++++++++++ERROR+++++++++++++++++++++++");
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        servletContext = sce.getServletContext();
        try {
            ctx.close();
        } catch (Exception e) {
            servletContext.log("No se puede cerrar la fuente de datos ", e);
        }
    }
}