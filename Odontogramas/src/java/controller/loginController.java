/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import conexion.sqlController;
import entity.Medico;
import entity.controller.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;
import org.apache.tomcat.util.threads.ResizableExecutor;

/**
 *
 * @author Ususario
 */
public class loginController extends HttpServlet {

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
        String perfil = (String) request.getParameter("perfil");
        String un = (String) request.getParameter("un");
        String pw = (String) request.getParameter("pw");
        HttpSession session = request.getSession();
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (perfil.equals("Estudiante")) {
            try {
                Result medico = new sqlController().CargarSql2("SELECT * FROM `medico` WHERE `idmedico`=" + un + "");

                if (medico.getRowCount()!=0) {
                    if (medico.getRowsByIndex()[0][2].equals(pw)) {
                        session.setAttribute("medico", medico);
                        session.setAttribute("docentes", new sqlController().CargarSql2("SELECT * FROM `docente`"));
                        session.setAttribute("diagnosticos", new sqlController().CargarSql2("SELECT * FROM `diagnostico`"));
                        session.setAttribute("tratamientos", new sqlController().CargarSql2("SELECT * FROM `tratamiento`"));
                        session.setAttribute("planTratamiento", new sqlController().CargarSql2("SELECT * FROM `plantratamiento`"));
                        session.setAttribute("interconsulta", new sqlController().CargarSql2("SELECT * FROM `interconsulta`"));
                        session.setAttribute("remision", new sqlController().CargarSql2("SELECT * FROM `remision`"));
                        session.setAttribute("logueado", "ok");
                        session.setAttribute("departamentos", new sqlController().CargarSql2("SELECT * FROM `departamentos`"));
                        session.setAttribute("profesiones", new sqlController().CargarSql2("SELECT * FROM `profesiones`"));
                        session.setAttribute("listaDePacientes", new sqlController().CargarSql2("SELECT paciente.* FROM `medico` "
                                + "inner join medico_has_paciente on medico.idmedico= medico_has_paciente.`medico_idmedico` "
                                + "inner join paciente on medico_has_paciente.`paciente_idpersona`=paciente.idpersona "
                                + "where medico.idmedico=" + un));
                        out.println(0);
                    } else {
                        out.println(1);
                    }
                } else {
                    out.println(1);
                }
            } catch (Exception e) {
                out.println(1);
            } finally {
                out.close();
            }


        } else {
            if (perfil.equals("Docente")) {

                Result docente = new sqlController().CargarSql2("SELECT * FROM `docente` WHERE `iddocente`=" + un + "");
                if (docente.getRowCount() != 0) {
                    if (docente.getRowsByIndex()[0][2].equals(pw)) {
                        session.setAttribute("logueado", "ok");
                        session.setAttribute("docente",docente);
                        out.println(0);
                    }else{
                    out.println(1);
                    }
                }else{
                out.println(1);
                }
            }else{
            if (perfil.equals("Administrador")) {
                Result administrador = new sqlController().CargarSql2("SELECT * FROM `administrador` WHERE `idAdmin`=" + un + "");
                if (administrador.getRowCount() != 0) {
                    if (administrador.getRowsByIndex()[0][2].equals(pw)) {
                        session.setAttribute("logueado", "ok");
                        session.setAttribute("administrador",administrador);
                        out.println(0);
                    }else{
                    out.println(1);
                    }
                }else{
                    out.println(1);
                    }
            }
            }
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
