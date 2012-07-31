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
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String fecha = sdf.format(pa.getFechaNacimiento());
                sesion.setAttribute("fecha", fecha);
                sesion.setAttribute("departamentos", new DepartamentosJpaController().findDepartamentosEntities());
                sesion.setAttribute("municipios", new DepartamentosJpaController().findDepartamentos(pa.getMunicipiosCodigo().getDepartamentosCodigo1().getCodigo()).getMunicipiosList());
                session.setAttribute("diagnosticos", conDi.findDiagnosticoEntities());
                session.setAttribute("profesiones", new ProfesionesJpaController().findProfesionesEntities());
                session.setAttribute("tratamientos", conTra.findTratamientoEntities());

            }

            if (request.getParameter("action").equals("subirRadiografias")) {
                String idPersona = request.getParameter("id");
                PacienteJpaController conPa = new PacienteJpaController();
                Paciente pa = conPa.findPaciente(idPersona);
                HttpSession sesion = request.getSession();
                sesion.setAttribute("paciente", pa);


            }

            if (request.getParameter("action").equals("editarDatosPer")) {
                HttpSession sesion = request.getSession();
                Paciente pa = (Paciente) sesion.getAttribute("paciente");

                PacienteJpaController conPa = new PacienteJpaController();
                pa.setNombre((String) request.getParameter("nombre"));
                pa.setDireccion((String) request.getParameter("direccion"));
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
                    conPa.edit(pa);
                    session.setAttribute("listaDePacientes", new MedicoJpaController().findMedico(m.getIdmedico()).getPacienteList());
                } catch (PreexistingEntityException ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(formController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (request.getParameter("action").equals("registrarM")) {
                String idPersona = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                String curso = request.getParameter("curso");
                String codigo = request.getParameter("codigo");


                MedicoJpaController conMe = new MedicoJpaController();
                CursoJpaController conCu = new CursoJpaController();
                Medico me = new Medico();
                me.setIdmedico(Integer.parseInt(idPersona));
                me.setNombreUsuario(nombre);
                me.setDireccion(direccion);
                me.setTelefono(telefono);
                me.setClave(idPersona);
                List<Curso> listCur = new ArrayList<Curso>();
                Curso cur = conCu.findCurso(Integer.parseInt(curso));
                if (cur.getCodigo().equals(codigo)) {
                    listCur.add(cur);
                    me.setCursoList(listCur);
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


            if (request.getParameter("action").equals("listaConsultas")) {
                String idPersona = request.getParameter("id");

                HttpSession sesion = request.getSession();
                Paciente pa = new PacienteJpaController().findPaciente(idPersona);
                sesion.setAttribute("paciente", pa);

                sesion.setAttribute("listaDeConsulta", pa.getConsultaList());

            }
            if (request.getParameter("action").equals("nuevaConsulta")) {
                HttpSession sesion = request.getSession();
                DatosbasicosJpaController daCon = new DatosbasicosJpaController();
                Paciente pa = (Paciente) session.getAttribute("paciente");
                sesion.setAttribute("datosBasicos", daCon.findDatosbasicosEntities());

            }


            if (request.getParameter("action").equals("guardarDatosBasicos")) {
                HttpSession sesion = request.getSession();
                List<Datosbasicos> Listdb = (List<Datosbasicos>) sesion.getAttribute("datosBasicos");
                DatosbasicosJpaController daCon = new DatosbasicosJpaController();
                Paciente pa = (Paciente) session.getAttribute("paciente");
                String iddoc = (String) request.getParameter("docente");
                Docente doc = new DocenteJpaController().findDocente(Integer.parseInt(iddoc));
                Medico me = (Medico) session.getAttribute("medico");
                sesion.setAttribute("datosBasicos", daCon.findDatosbasicosEntities());
                String motivo = (String) request.getParameter("motivo");
                String historia = (String) request.getParameter("historia");
                String observaciones = (String) request.getParameter("observaciones");
                String otros = (String) request.getParameter("otros");
                String ultima = (String) request.getParameter("ultima");
                SimpleDateFormat formatoDelTexto2 = new SimpleDateFormat("yyyy-MM-dd");
                Date ultimaD = null;
                try {

                    ultimaD = formatoDelTexto2.parse(ultima);

                } catch (ParseException ex) {

                    ex.printStackTrace();

                }


                String motivo2 = (String) request.getParameter("motivo2");

                Consulta con = new Consulta();
                ConsultaJpaController conCon = new ConsultaJpaController();
                con.setMotivoConsulta(motivo);
                con.setPacienteIdpersona(pa);
                con.setObservaciones(observaciones);
                con.setHistoriaActualEnfermedad(historia);
                con.setMotivo(motivo2);
                con.setOtros(otros);
                con.setUltimaVisitaOdon(ultimaD);
                con.setMedicoIdmedico(me);
                con.setDocenteIddocente(doc);
                conCon.create(con);

                session.setAttribute("consulta", con);

            }

            if (request.getParameter("action").equals("guardarDatosBasicos2")) {
                HttpSession sesion = request.getSession();
                Consulta con = (Consulta) sesion.getAttribute("consulta");
                Examenfisicoestomatologico ex= new Examenfisicoestomatologico();
                ExamenfisicoestomatologicoJpaController conEx = new ExamenfisicoestomatologicoJpaController();
                String temperatura = (String)request.getParameter("temperatura");
                String pulso = (String)request.getParameter("pulso");
                String tension = (String)request.getParameter("tension");
                String higiene = (String)request.getParameter("higiene");
                String usoSeda = (String)request.getParameter("usoSeda");
                String cepillo = (String)request.getParameter("cepillo");
                String veces = (String)request.getParameter("veces");
                String enjuages1 = (String)request.getParameter("enjuages1");
                String enjuages2 = (String)request.getParameter("enjuages2");
                String habitosYvicios = (String)request.getParameter("habitosYvicios");
                
                ex.setTemperatura(temperatura);
                ex.setPulso(pulso);
                ex.setTensionArterial(tension);
                ex.setHigieneOral(higiene);
                ex.setSedaDental(usoSeda);
                ex.setCepilloDentalUso(cepillo);
                ex.setVecesAlDia(veces);
                ex.setEnjuagesBsinFluor(enjuages1);
                ex.setEnjuagesBconFluor(enjuages2);
                ex.setHabitosYvicios(habitosYvicios);
                ex.setDatosConsultaiddatosConsulta(con);
                conEx.create(ex);
                
                
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
