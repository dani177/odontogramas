/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package info.sudr.file;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Andres
 */
public class cargar extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json;charset=UTF-8");
        HttpSession sesion = request.getSession();
        Result res = (Result) sesion.getAttribute("consulta");
        String dienteId = (String) sesion.getAttribute("dienteId");
        try {


            String str = request.getSession().getServletContext().getRealPath("/file/");



            // nos quedamos solo con el nombre y descartamos el path
            File fichero = new File(str);

            String[] ficheros = fichero.list();
            String aux = "";
            if (ficheros == null) {
            } else {
                for (int i = 0; i < ficheros.length; i++) {
                    String elementos[] = ficheros[i].split("\\.");
                    String elemento2[] = ficheros[i].split("-");
                    if (!aux.equals("")) {
                        if (elemento2[0].equals(""+res.getRowsByIndex()[0][0]) && elemento2[1].equals(""+dienteId)) {
                            aux += ",{\"name\":\"" + ficheros[i] + "\",\"size\":\"" + 2000 + "\",\"url\":\"/Odontogramas/file/" + ficheros[i] + "\",\"thumbnail_url\":\"/Odontogramas/thumbnails/" + ficheros[i] + "\",\"delete_url\":\"/Odontogramas/file/" + ficheros[i] + "?force_delete=true\",\"delete_type\":\"DELETE\",\"type\":\"" + elementos[1] + "\"}";
                        }
                    }else{
                    if (elemento2[0].equals(""+res.getRowsByIndex()[0][0]) && elemento2[1].equals(""+dienteId)) {
                            aux += "{\"name\":\"" + ficheros[i] + "\",\"size\":\"" + 2000 + "\",\"url\":\"/Odontogramas/file/" + ficheros[i] + "\",\"thumbnail_url\":\"/Odontogramas/thumbnails/" + ficheros[i] + "\",\"delete_url\":\"/Odontogramas/file/" + ficheros[i] + "?force_delete=true\",\"delete_type\":\"DELETE\",\"type\":\"" + elementos[1] + "\"}";
                        }
                    }

                }
                writer.write("[" + aux + "]");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
