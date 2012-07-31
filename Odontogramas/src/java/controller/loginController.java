/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Medico;
import entity.controller.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
        String un = (String) request.getParameter("un");
        String pw = (String) request.getParameter("pw");
        HttpSession session = request.getSession();
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        MedicoJpaController conMed = new MedicoJpaController();
        DocenteJpaController conDoc = new DocenteJpaController();

        try {
            Medico medico = conMed.findMedico(Integer.parseInt(un));

            session.setAttribute("medico", medico);
            session.setAttribute("docentes", conDoc.findDocenteEntities());
            session.setAttribute("diagnosticos", new DiagnosticoJpaController().findDiagnosticoEntities());
            session.setAttribute("tratamientos", new TratamientoJpaController().findTratamientoEntities());

            if (medico != null) {
                if (medico.getClave().equals(pw)) {
                    session.setAttribute("logueado", "ok");
                    DepartamentosJpaController ConDe = new DepartamentosJpaController();
                    session.setAttribute("departamentos", ConDe.findDepartamentosEntities());
                    ProfesionesJpaController ConProf = new ProfesionesJpaController();
                    session.setAttribute("profesiones", ConProf.findProfesionesEntities());
                    session.setAttribute("listaDePacientes", medico.getPacienteList());
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
