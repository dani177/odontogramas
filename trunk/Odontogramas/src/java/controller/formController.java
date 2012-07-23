/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.*;
import entity.controller.*;
import entity.controller.exceptions.PreexistingEntityException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import org.eclipse.persistence.sessions.Session;

/**
 *
 * @author Ususario
 */
public class formController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {

            if (request.getParameter("action").equals("municipios")) {
                response.setContentType("application/json;charset=UTF-8");
                String codDe = ((String) request.getParameter("codDep"));
                int codDep = Integer.parseInt(codDe);
                Departamentos dep = new DepartamentosJpaController().findDepartamentos(codDep);
                MunicipiosJpaController conMun = new MunicipiosJpaController();
                List<Municipios> listaDeMunicipios = conMun.findMunicipiosEntities();
                ArrayList<Municipios> mun = new ArrayList<Municipios>();
                for (Municipios m : listaDeMunicipios) {
                    if (m.getDepartamentosCodigo1().getCodigo() == dep.getCodigo()) {
                        mun.add(m);
                    }
                }

                String aux4 = "{ \"municipios\":[";


                for (Municipios m : mun) {
                    String aux5 = ""
                            + "{"
                            + "\"cod\": \"" + m.getCodigo() + "\" ," + " \"nombre\": \"" + m.getNombre()
                            + "\""
                            + "},"
                            + "";
                    aux4 += aux5;

                }

                aux4 = aux4.substring(0, aux4.length() - 1);
                aux4 += "]}";




                out.println("[" + aux4 + "]");


            }



            if (request.getParameter("action").equals("guardarDatosPer")) {
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = new Paciente();
                pa.setNombre((String) request.getParameter("nombre"));
                pa.setDireccion((String) request.getParameter("direccion"));
                pa.setIdpersona((String) request.getParameter("identificacion"));
                pa.setNumAfiliacion((String) request.getParameter("afiliacion"));
                pa.setTelefono((String) request.getParameter("telefono"));
                String codigomun = (String) (request.getParameter("municipio"));
                int codMun = Integer.parseInt(codigomun);
                MunicipiosJpaController ConMun = new MunicipiosJpaController();
                Municipios mun = ConMun.findMunicipios(codMun);
                pa.setMunicipiosCodigo(mun);
                SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
                String sFecha = (String) request.getParameter("fecha");
                Date fecha = null;
                try {

                    fecha = formatoDelTexto.parse(sFecha);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }
                pa.setFechaNacimiento(fecha);
                pa.setSexo((String) request.getParameter("sexo"));
                pa.setEstadoCivil((String) request.getParameter("estadoCivil"));
                String prof = (String) request.getParameter("profesion");
                int codPro = Integer.parseInt(prof);
                Profesiones profes = new ProfesionesJpaController().findProfesiones(codPro);
                pa.setProfesionesCodigo(profes);
                Medico m = (Medico) session.getAttribute("medico");
                ArrayList<Medico> listMedico = new ArrayList<Medico>();
                listMedico.add(m);
                pa.setMedicoList(listMedico);

                try {
                    conPa.create(pa);
                    session.setAttribute("listaDePacientes", new MedicoJpaController().findMedico(m.getIdmedico()).getPacienteList());
                } catch (PreexistingEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }

            }

            if (request.getParameter("action").equals("verPaciente")) {
                String idPersona = request.getParameter("id");
                DiagnosticoJpaController conDi = new DiagnosticoJpaController();
                TratamientoJpaController conTra = new TratamientoJpaController();
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = conPa.findPaciente(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);
                session.setAttribute("diagnosticos", conDi.findDiagnosticoEntities());
                session.setAttribute("tratamientos", conTra.findTratamientoEntities());

            }

            if (request.getParameter("action").equals("subirRadiografias")) {
                String idPersona = request.getParameter("id");
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = conPa.findPaciente(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);


            }
           
            if (request.getParameter("action").equals("registrarM")) {
                String idPersona = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String anio = request.getParameter("anio");
                String periodo = request.getParameter("periodo");
                String docente = request.getParameter("docente");
                String codigo = request.getParameter("codigo");


                MedicoJpaController conMe = new MedicoJpaController();
                DocenteJpaController conDo = new DocenteJpaController();
                Medico me = new Medico();
                me.setIdmedico(Integer.parseInt(idPersona));
                me.setNombreUsuario(nombre);
                me.setDireccion(direccion);
                me.setTelefono(telefono);
                me.setAnio(anio);
                me.setPeriodo(periodo);
                me.setClave(idPersona);
                List<Docente> listDoc = new ArrayList<Docente>();
                Docente doc = conDo.findDocente(Integer.parseInt(docente));
                if (doc.getCodigo().equals(codigo)) {
                    listDoc.add(doc);
                    me.setDocenteList(listDoc);
                    try {
                        conMe.create(me);
                    } catch (PreexistingEntityException ex) {
                         out.print(1);
                        Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (Exception ex) {
                        Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    out.print(0);
                } else {
                    out.print(1);
                }



            }



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