/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



import conexion.Conexion;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



public class sqlController {

    private Conexion linkDB = null;
    private Connection con = null;

    //////////////////////////////////////////////////////////////////////
    public void setConexion(Conexion conex) {
        linkDB = conex;
        con = linkDB.getConnection();
        System.out.println("[CONEXION RECIBIDA]");
    }

    ///////////////////////////////////////////////////////////////////////
    public boolean isConected() {
        boolean result = false;
        if ((linkDB != null) && (linkDB.isConnect())) {
            result = true;
        }
        return result;
    }

    public void cerrarConexion() {

        if (this.isConected()) {
            linkDB.cerrarConexion();
        }
    }

   
}
